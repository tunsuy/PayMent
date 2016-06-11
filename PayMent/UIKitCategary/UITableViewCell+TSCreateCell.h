//
//  UITableViewCell+TSCreateCell.h
//  PayMent
//
//  Created by tunsuy on 21/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (TSCreateCell)

+ (__kindof UITableViewCell *)createCellWithTableView:(UITableView *)tableView;

@end
