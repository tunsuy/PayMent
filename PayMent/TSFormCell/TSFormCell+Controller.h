//
//  TSFormCell+Controller.h
//  PayMent
//
//  Created by tunsuy on 21/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "TSFormCell.h"

@interface TSFormCell (Controller)

- (UIView*)generateInputView;
//左边图片
- (UIImageView*)generateImageViewWithImage:(UIImage*)image;
//左边标题
- (UILabel*)generateTitleLabelWithTitle:(NSString*)title;
//TextField
- (UITextField *)generateTextFieldWithPlaceholder:(NSString*)placeholder;
//右边箭头
- (UIButton*)generateAccessoryButton;
//右边详情文字
- (UILabel*)generateDetalTitleLabelWithDetailTitle:(NSString*)title;
//开关按钮
- (UISwitch *)generateSwichControlWithISon:(BOOL)on;
//打钩按钮
- (UIImageView*)generateCheckImageView;
//右边头像按钮
- (UIImageView*)generateRightHeadWithHeadWidth:(CGFloat)width;
//自定义View
-(UIView*)generateCustomViewWithView:(UIView*)view;
//复选按钮
-(UIButton *)generateCheckButtonWithISCheck:(BOOL)isCheck;
//计算多行描述中cell高度
+ (CGFloat)getCellHeightForDescriptionWithDescription:(NSString*)string;

@end
