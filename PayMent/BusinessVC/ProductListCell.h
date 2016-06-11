//
//  ProductListCell.h
//  PayMent
//
//  Created by tunsuy on 19/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListCell : UITableViewCell

/** 为了方便，这里使用字典类型来模拟一个商品对象 */
@property (nonatomic, copy) NSDictionary *product;

+ (CGFloat)heightOfVisibilityCellWithProduct:(NSDictionary *)product;

@end
