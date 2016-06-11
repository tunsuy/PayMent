//
//  TSOrderForPay.h
//  PayMent
//
//  Created by tunsuy on 19/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface OrderForPay : NSObject

/********************************/
//额外信息，不包含在description
@property(nonatomic, strong) NSString * signString;
@property(nonatomic, strong) NSString * signType;
/********************************/

@property(nonatomic, copy) NSString * partner;
@property(nonatomic, copy) NSString * seller;
@property(nonatomic, copy) NSString * tradeNO;
@property(nonatomic, copy) NSString * productName;
@property(nonatomic, copy) NSString * productDescription;
@property(nonatomic, copy) NSString * amount;
@property(nonatomic, copy) NSString * notifyURL;

@property(nonatomic, copy) NSString * service;
@property(nonatomic, copy) NSString * paymentType;
@property(nonatomic, copy) NSString * inputCharset;
@property(nonatomic, copy) NSString * itBPay;
@property(nonatomic, copy) NSString * showUrl;


@property(nonatomic, copy) NSString * rsaDate;//可选
@property(nonatomic, copy) NSString * appID;//可选

@property(nonatomic, readonly) NSMutableDictionary * extraParams;

/********************************/
//这个字段可以是服务端封装好返回的字符串（免去了客户端自己拼接）
@property(nonatomic, strong) NSString *linkStr;
/********************************/

/********************************/
//微信只需要封装该信息
@property(nonatomic, strong) PayReq *payReq;
@property(nonatomic, strong) NSString *appid;
/********************************/

- (instancetype)initWithAliPayOrderServerResult:(NSDictionary *)resultInfo;
- (instancetype)initWithWxPayReqServerResult:(NSDictionary *)resultInfo;


@end
