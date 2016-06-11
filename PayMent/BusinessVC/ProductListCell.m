//
//  ProductListCell.m
//  PayMent
//
//  Created by tunsuy on 19/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "ProductListCell.h"

#define kSubViewPadding_left 15
#define kSubViewPadding_right 15
#define kSubViewPadding_top 10
#define kSubViewPadding_bottom 10
#define kProductNamePaddingShortDescription 5
#define kShortDescriptionPaddingPrice 10

#define kProductNameFontSize 18
#define kShortDescriptionFontSize 14
#define kPriceFontSize 14

@interface ProductListCell()

@property (nonatomic, strong) UILabel *productName;
@property (nonatomic, strong) UILabel *shortDescription;
@property (nonatomic, strong) UILabel *price;

@end

@implementation ProductListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _productName = [[UILabel alloc] initWithFrame:CGRectMake(kSubViewPadding_left, kSubViewPadding_top, SCREEN_WIDTH-kSubViewPadding_left-kSubViewPadding_right, kProductNameFontSize)];
        _productName.font = [UIFont systemFontOfSize:kProductNameFontSize];
        _productName.textColor = [UIColor blackColor];
        
        _shortDescription = [[UILabel alloc] initWithFrame:CGRectMake(kSubViewPadding_left, CGRectGetMaxY(_productName.frame)+kProductNamePaddingShortDescription, SCREEN_WIDTH-kSubViewPadding_left-kSubViewPadding_right, kShortDescriptionFontSize)];
        _shortDescription.font = [UIFont systemFontOfSize:kShortDescriptionFontSize];
        _shortDescription.textColor = [UIColor lightGrayColor];
        
        _price = [[UILabel alloc] initWithFrame:CGRectMake(kSubViewPadding_left, CGRectGetMaxY(_shortDescription.frame)+kShortDescriptionPaddingPrice, SCREEN_WIDTH-kSubViewPadding_left-kSubViewPadding_right, kPriceFontSize)];
        _price.font = [UIFont systemFontOfSize:kPriceFontSize];
        _price.textColor = [UIColor orangeColor];
        
        [self.contentView addSubview:_productName];
        [self.contentView addSubview:_shortDescription];
        [self.contentView addSubview:_price];
    }
    return self;
}

- (void)setProduct:(NSDictionary *)product {
    self.productName.text = product[@"productName"];
    self.shortDescription.text = product[@"shortDescription"];
    self.price.text = [NSString stringWithFormat:@"%@", product[@"price"]];
}

+ (CGFloat)heightOfVisibilityCellWithProduct:(NSDictionary *)product {
    NSDictionary *productNameAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:kProductNameFontSize]};
    CGRect productNameRect = [product[@"productName"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-kSubViewPadding_left-kSubViewPadding_right, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:productNameAttributes context:nil];
    
    NSDictionary *shortDescriptionAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:kShortDescriptionFontSize]};
    CGRect shortDescriptionRect = [product[@"shortDescription"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-kSubViewPadding_left-kSubViewPadding_right, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:shortDescriptionAttributes context:nil];
    
    NSDictionary *priceAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:kPriceFontSize]};
    CGRect priceRect = [[NSString stringWithFormat:@"%@", product[@"price"]] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-kSubViewPadding_left-kSubViewPadding_right, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:priceAttributes context:nil];
    
    return kSubViewPadding_top + productNameRect.size.height + kProductNamePaddingShortDescription + shortDescriptionRect.size.height + kShortDescriptionPaddingPrice + priceRect.size.height + kSubViewPadding_bottom;
    
}

@end
