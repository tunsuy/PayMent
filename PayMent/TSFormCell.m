//
//  TSFormCell.m
//  PayMent
//
//  Created by tunsuy on 20/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "TSFormCell.h"
#import "TSFormCell+Controller.h"

#define kSubViewPadding_left 10
#define kSubViewPadding_right 10
#define kSubViewPadding_top 10
#define kSubViewPadding_bottom 10
#define kSubViewPadding 5

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface TSFormCell () {
    NSMutableDictionary *substanceViewDict;
}

@end

@implementation TSFormCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        _cellHeight = kPublicFormMinHeight;
        
        substanceViewDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)setInputView:(UIView *)inputView
{
    if (_inputView) {
        [_inputView removeFromSuperview];
    }
    _inputView = inputView;
    [self.contentView addSubview:_inputView];
}

- (void)setCellSubstanceViewTypeDict:(NSDictionary *)cellSubstanceViewTypeDict
{
    _cellSubstanceViewTypeDict  = cellSubstanceViewTypeDict;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [substanceViewDict removeAllObjects];
    UIView *inputView = [self generateInputView];
    UIView *substanceView = nil;
    
    NSArray *sortKeyArray = [cellSubstanceViewTypeDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    for (NSNumber *number in sortKeyArray) {
        CellSubstanceViewType substanceViewType = [number integerValue];
        id object =  cellSubstanceViewTypeDict[number];
        switch (substanceViewType) {
            case CellSubstanceViewTypeImage:
                substanceView = [self generateImageViewWithImage:object];
                break;
            case CellSubstanceViewTypeTitle:
                substanceView = [self generateTitleLabelWithTitle:object];
                break;
            case CellSubstanceViewTypeAccessory:
                self.selectionStyle = UITableViewCellSelectionStyleDefault;
                substanceView = [self generateAccessoryButton];
                break;
            case CellSubstanceViewTypeDetail:
                substanceView = [self generateDetalTitleLabelWithDetailTitle:object];
                break;
            case CellSubstanceViewTypeSwich:
                substanceView = [self generateSwichControlWithISon:[object integerValue]];
                break;
            case CellSubstanceViewTypeCheck:
                substanceView = [self generateCheckImageView];
                break;
            case CellSubstanceViewTypeTextField:
                substanceView = [self generateTextFieldWithPlaceholder:object];
                break;
            case CellSubstanceViewTypeRightHead:
                substanceView = [self generateRightHeadWithHeadWidth:[object floatValue]];
                break;
            case CellSubstanceViewTypeCustomView:
                substanceView = [self generateCustomViewWithView:object];
                break;
            case CellSubstanceViewTypeCheckButton:
                substanceView = [self generateCheckButtonWithISCheck:[object boolValue]];
                break;
            default:
                break;
        }
        if (substanceView) {
            [substanceViewDict setObject:substanceView forKey:number];
            [inputView addSubview:substanceView];
        }
    }
    
    self.inputView = inputView;
}

- (BOOL)containSubstanceViewType:(CellSubstanceViewType)type {
    NSArray *keyArray = self.cellSubstanceViewTypeDict.allKeys;
    return [keyArray containsObject:@(type)];
}

//获取对应类型的SubstanceView
- (UIView*)getSubstanceView:(CellSubstanceViewType)substanceViewType {
    return substanceViewDict[@(substanceViewType)];
}

@end
