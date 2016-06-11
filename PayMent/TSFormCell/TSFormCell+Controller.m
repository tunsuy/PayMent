//
//  TSFormCell+Controller.m
//  PayMent
//
//  Created by tunsuy on 21/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "TSFormCell+Controller.h"

@implementation TSFormCell (Controller)

- (UIView*)generateInputView {
    UIView *inputView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,self.cellHeight)];
    inputView.backgroundColor = [UIColor clearColor];
    return inputView;
}

//左边图片
- (UIImageView*)generateImageViewWithImage:(UIImage*)image {
    /** 待处理 */
    return nil;
}

//左边标题
- (UILabel*)generateTitleLabelWithTitle:(NSString *)title {
    BOOL hasImage = [self containSubstanceViewType:CellSubstanceViewTypeImage];
    BOOL hasRightHead = [self containSubstanceViewType:CellSubstanceViewTypeRightHead];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kPublicFormPaddingLeft+hasImage*(kPublicFormLogoLeft+kPublicFormLeftTextPaddingAfterImg), 0, 160,kPublicFormMinHeight)];
    if (hasRightHead) {
        CGRect frame = label.frame;
        frame.origin.y = (self.cellHeight-label.frame.size.height)/2;
        label.frame = frame;
    }
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:kPublicFormItemTextFontLeft];
    label.text = title;
    
    return label;
}

//TextField
- (UITextField *)generateTextFieldWithPlaceholder:(NSString *)placeholder {
    /** 待处理 */
    return nil;
}

//右边箭头
- (UIButton*)generateAccessoryButton {
    /** 待处理 */
    return nil;
}

//右边详情文字
- (UILabel*)generateDetalTitleLabelWithDetailTitle:(NSString *)title {
    BOOL hasAccessory = [self containSubstanceViewType:CellSubstanceViewTypeAccessory];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-kPublicFormRightLabelMaxWidth-hasAccessory*(kPublicFormArrowLeft+kPublicFormArrow)-kPublicFormPaddingRight, 0, kPublicFormRightLabelMaxWidth, self.cellHeight)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:kPublicFormItemTextFontRight];
    label.text = title;
    
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width, 1000)];
    
    label.textAlignment = size.height>kPublicFormItemTextFontRight+10?NSTextAlignmentLeft:NSTextAlignmentRight;
    
    return label;
}

//开关按钮
- (UISwitch *)generateSwichControlWithISon:(BOOL)on {
    /** 待处理 */
    return nil;
}

//打钩按钮
- (UIImageView*)generateCheckImageView {
    /** 待处理 */
    return nil;
}

//右边头像按钮
- (UIImageView*)generateRightHeadWithHeadWidth:(CGFloat)width {
    /** 待处理 */
    return nil;
}

//自定义View
-(UIView*)generateCustomViewWithView:(UIView *)view {
    return view;
}

//复选按钮
-(UIButton *)generateCheckButtonWithISCheck:(BOOL)isCheck {
    /** 待处理 */
    return nil;
}

//计算多行描述中cell高度
+ (CGFloat)getCellHeightForDescriptionWithDescription:(NSString *)string {
    if (string.length==0) {
        string = @" ";
    }
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:kPublicFormItemTextFontRight] constrainedToSize:CGSizeMake(kPublicFormRightLabelMaxWidth, 10000)];
    
    return size.height+ kPublicFormTitleMergeTop+kPublicFormTitleMergeBottom;
    
}

+ (CGFloat)getCellHeightForContent:(NSString*)string andHasArrow:(BOOL)has
{
    if (string.length==0) {
        string = @" ";
    }
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:kPublicFormItemTextFontLeft] constrainedToSize:CGSizeMake(SCREEN_WIDTH - 2*kPublicFormPaddingLeft - has*(kPublicFormArrow + kPublicFormArrowLeft), 10000)];
    return size.height+ kPublicFormTitleMergeTop+kPublicFormTitleMergeBottom;
}

+ (CGFloat)getCellHeightForContent:(NSString*)string
{
    if (string.length==0) {
        string = @" ";
    }
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:kPublicFormItemTextFontLeft] constrainedToSize:CGSizeMake(SCREEN_WIDTH - 2*kPublicFormPaddingLeft, 10000)];
    return size.height+ kPublicFormTitleMergeTop+kPublicFormTitleMergeBottom;
}

@end
