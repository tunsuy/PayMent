//
//  UITableViewCell+TSCreateCell.m
//  PayMent
//
//  Created by tunsuy on 21/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "UITableViewCell+TSCreateCell.h"

static NSString *const reuseIdentifier = @"cellID";

@implementation UITableViewCell (TSCreateCell)

+ (__kindof UITableViewCell *)createCellWithTableView:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

@end
