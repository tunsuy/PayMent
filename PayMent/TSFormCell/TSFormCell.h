//
//  TSFormCell.h
//  PayMent
//
//  Created by tunsuy on 20/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellSubstanceViewType)
{
    CellSubstanceViewTypeImage,  //左边图片
    CellSubstanceViewTypeTitle,  //左边标题
    
    CellSubstanceViewTypeAccessory,//右边箭头
    CellSubstanceViewTypeSwich, //右边开关
    CellSubstanceViewTypeTextField, //右边输入框
    CellSubstanceViewTypeDetail,  //右边文字
    CellSubstanceViewTypeRightHead, //右边头像
    CellSubstanceViewTypeCheck,
    CellSubstanceViewTypeCustomView,//textView文本
    CellSubstanceViewTypeCheckButton, //复选按钮
};

@interface TSFormCell : UITableViewCell

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) NSDictionary *cellSubstanceViewTypeDict;

- (BOOL)containSubstanceViewType:(CellSubstanceViewType)type;
//获取对应类型的SubstanceView
- (UIView*)getSubstanceView:(CellSubstanceViewType)substanceViewType;

@end
