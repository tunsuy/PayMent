//
//  TSOrderForPay.m
//  PayMent
//
//  Created by tunsuy on 19/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "OrderForPay.h"

@implementation OrderForPay

- (NSString *)description {
    NSMutableString * discription = [NSMutableString string];
    if (self.partner) {
        [discription appendFormat:@"partner=\"%@\"", self.partner];
    }
    
    if (self.seller) {
        [discription appendFormat:@"&seller_id=\"%@\"", self.seller];
    }
    if (self.tradeNO) {
        [discription appendFormat:@"&out_trade_no=\"%@\"", self.tradeNO];
    }
    if (self.productName) {
        [discription appendFormat:@"&subject=\"%@\"", self.productName];
    }
    
    if (self.productDescription) {
        [discription appendFormat:@"&body=\"%@\"", self.productDescription];
    }
    if (self.amount) {
        [discription appendFormat:@"&total_fee=\"%@\"", self.amount];
    }
    if (self.notifyURL) {
        [discription appendFormat:@"&notify_url=\"%@\"", self.notifyURL];
    }
    
    if (self.service) {
        [discription appendFormat:@"&service=\"%@\"",self.service];//mobile.securitypay.pay
    }
    if (self.paymentType) {
        [discription appendFormat:@"&payment_type=\"%@\"",self.paymentType];//1
    }
    
    if (self.inputCharset) {
        [discription appendFormat:@"&_input_charset=\"%@\"",self.inputCharset];//utf-8
    }
    if (self.itBPay) {
        [discription appendFormat:@"&it_b_pay=\"%@\"",self.itBPay];//30m
    }
    if (self.showUrl) {
        [discription appendFormat:@"&show_url=\"%@\"",self.showUrl];//m.alipay.com
    }
    if (self.rsaDate) {
        [discription appendFormat:@"&sign_date=\"%@\"",self.rsaDate];
    }
    if (self.appID) {
        [discription appendFormat:@"&app_id=\"%@\"",self.appID];
    }
    for (NSString * key in [self.extraParams allKeys]) {
        [discription appendFormat:@"&%@=\"%@\"", key, [self.extraParams objectForKey:key]];
    }
    return discription;
}

- (instancetype)initWithAliPayOrderServerResult:(NSDictionary *)resultInfo {
    if (self = [super init]) {
        //将商品信息赋予AlixPayOrder的成员变量
        self.partner            = resultInfo[@"partner"];
        self.seller             = resultInfo[@"seller_id"];
        self.tradeNO            = resultInfo[@"tradeId"]; //订单ID（由商家自行制定）
        self.productName        = resultInfo[@"subject"]; //商品标题
        self.productDescription = resultInfo[@"body"]; //商品描述
        self.amount             = [NSString stringWithFormat:@"%.2f", [resultInfo[@"total_fee"] floatValue]]; //商品价格
        self.notifyURL          = resultInfo[@"notify_url"]; //回调URL
        
        self.service            = resultInfo[@"service"];
        self.paymentType        = resultInfo[@"payment_type"];
        self.inputCharset       = resultInfo[@"_input_charset"];
        self.itBPay             = resultInfo[@"it_b_pay"];
        //  order.showUrl            = @"m.alipay.com";
        
        self.signString         = resultInfo[@"signString"];
        self.signType           = resultInfo[@"sign_type"];
        
        self.linkStr            = resultInfo[@"linkStr"];
    }
    return self;
}

- (instancetype)initWithWxPayReqServerResult:(NSDictionary *)resultInfo {
    if (self = [super init]) {
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = resultInfo[@"appid"];
        req.partnerId           = resultInfo[@"partnerid"];
        req.prepayId            = resultInfo[@"prepayid"];
        req.nonceStr            = resultInfo[@"noncestr"];
        req.timeStamp           = (UInt32)[resultInfo[@"timestamp"] integerValue];
        req.package             = resultInfo[@"package"];
        req.sign                = resultInfo[@"sign"];
    
        self.payReq = req;
        self.appID = resultInfo[@"appid"];
    }
    return self;
}

@end
