//
//  PayManager.h
//  PayMent
//
//  Created by tunsuy on 22/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "OrderForPay.h"

@interface PayManager : NSObject

@property (nonatomic, copy) TSCallBack callBack;

+ (instancetype)shareInstance;

- (void)payForAliWithOrder:(OrderForPay *)order callBack:(TSCallBack)callBack;
- (void)payForWxWithPayReq:(PayReq *)payReq callBack:(TSCallBack)callBack;

- (void)dealPayResultForAliWithResult:(NSURL *)url;
- (void)dealPayResultForWxWithResult:(id)result;

@end
