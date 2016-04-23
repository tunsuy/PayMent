//
//  PayManager.m
//  PayMent
//
//  Created by tunsuy on 22/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "PayManager.h"

#define kPayResultErroeCodeForCancel @990001

#define kCallBackForAli @"callBackForAli"
#define kCallBackForWx  @"callBackForWx"

@interface PayManager ()

@property (nonatomic, strong) NSMutableDictionary *callBackDict;

@end

@implementation PayManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static PayManager *payManager;
    dispatch_once(&onceToken, ^{
        payManager = [[PayManager alloc] init];
    });
    return payManager;
}

#pragma mark - pay method
/** 支付宝支付 */
- (void)payForAliWithOrder:(OrderForPay *)order callBack:(TSCallBack)callBack {
    NSString *orderSpec = order.linkStr;
    NSString *signedString = order.signString;
    NSString *signedType = order.signType;
    
    //应用注册scheme,在info.plist定义URL types
    NSString *appScheme = @"";
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, signedType];
        
        __weak typeof(self) weakself= self;
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            [weakself dealAlipayResultWithResult:resultDic];
        }];
    }

}

/** 微信支付 */
- (void)payForWxWithPayReq:(PayReq *)payReq callBack:(TSCallBack)callBack {
    if (self.callBackDict == nil) {
        self.callBackDict = [NSMutableDictionary dictionary];
    }
    
    if (callBack) {
        self.callBackDict[kCallBackForWx] = callBack;
    }
    
    NSLog(@"partid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@", payReq.partnerId, payReq.prepayId, payReq.nonceStr, (long)payReq.timeStamp, payReq.package, payReq.sign);
    
    [WXApi sendReq:payReq];
}

#pragma mark - deal pay result
/** 支付宝支付结果 */
- (void)dealAlipayResultWithResult:resultDic {
    self.callBack = self.callBackDict[kCallBackForAli];
    
    NSLog(@"result = %@", resultDic);
    /*
     resultStatus，状态码，SDK里没对应信息，第一个文档里有提到：
     9000 订单支付成功
     8000 正在处理中
     4000 订单支付失败
     6001 用户中途取消
     6002 网络连接出错
     memo， 提示信息
     result，订单信息，以及签名验证信息。
     */
    NSString *resultStatus = [NSString stringWithFormat:@"%@", resultDic[@"resultStatus"]];
    NSString *memo = [NSString stringWithFormat:@"%@", resultDic[@"memo"]];
    //    NSString *result = [NSString stringWithFormat:@"%@", resultDic[@"result"]];
    
    NSString *errorCode = resultStatus;
    NSString *errorMsg = nil;
    switch (resultStatus.integerValue) {
        case 9000:
        {
            if (self.callBack) {
                self.callBack(nil);
            }
            return;
        }
            break;
        case 8000:
        {
            errorMsg = memo.length > 0?memo:@"正在处理中";
        }
            break;
        case 4000:
        {
            errorMsg = memo.length > 0?memo:@"订单支付失败";
        }
            break;
        case 6001:
        {
            errorCode = [NSString stringWithFormat:@"%@", kPayResultErroeCodeForCancel];
            errorMsg = memo.length > 0?memo:@"用户中途取消";
        }
            break;
        case 6002:
        {
            errorMsg = memo.length > 0?memo:@"网络连接出错";
        }
            break;
            
        default:
            break;
    }
    if (self.callBack) {
        self.callBack(MOAErrorMake(errorMsg, errorCode.integerValue));
    }
}

/** 微信支付结果 */
- (void)dealPayResultForWxWithResult:(id)result {
    
    self.callBack = self.callBackDict[kCallBackForWx];
    NSAssert([result isKindOfClass:[PayResp class]], nil);
    //支付返回结果，实际支付结果需要去微信服务器端查询
    PayResp *resp = (PayResp *)result;
    NSString *errCode = [NSString stringWithFormat:@"%zd", resp.errCode];
    NSString *errMsg = nil;
    switch (resp.errCode) {
        case WXSuccess:
        {
            errMsg = @"支付结果：成功！";
            NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            if (self.callBack) {
                self.callBack(nil);
            }
            return;
        }
            break;
        case WXErrCodeCommon:
        {
            errMsg = resp.errStr.length>0?resp.errStr:@"普通错误类型";
        }
            break;
        case WXErrCodeUserCancel:
        {
            errCode = [NSString stringWithFormat:@"%@", kPayResultErroeCodeForCancel];
            errMsg = resp.errStr.length>0?resp.errStr:@"用户取消";
        }
            break;
        case WXErrCodeSentFail:
        {
            errMsg = resp.errStr.length>0?resp.errStr:@"发送失败";
        }
            break;
        case WXErrCodeAuthDeny:
        {
            errMsg = resp.errStr.length>0?resp.errStr:@"授权失败";
        }
            break;
        case WXErrCodeUnsupport:
        {
            errMsg = resp.errStr.length>0?resp.errStr:@"微信不支持";
        }
            break;
        default:
        {
            errMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
        }
            break;
    }
    if (self.callBack) {
        self.callBack(MOAErrorMake(errMsg, errCode.integerValue));
    }
}

- (void)dealPayResultForAliWithResult:(NSURL *)url {
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                              standbyCallback:^(NSDictionary *resultDic) {
                                                  //如果进这个回调，说明我们应用被系统或者用户手动kill掉了
                                                  NSLog(@"%@", resultDic);
                                              }];
}

#pragma mark   ==============产生随机订单号==============

//- (NSString *)generateTradeNO
//{
//    static int kNumber = 15;
//    
//    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//    NSMutableString *resultStr = [[NSMutableString alloc] init];
//    srand((unsigned)time(0));
//    for (int i = 0; i < kNumber; i++)
//    {
//        unsigned index = rand() % [sourceStr length];
//        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
//        [resultStr appendString:oneStr];
//    }
//    return resultStr;
//}

@end
