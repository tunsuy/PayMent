//
//  ProductViewController.m
//  PayMent
//
//  Created by tunsuy on 19/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductListCell.h"
#import "SubmitOrderViewController.h"

@interface ProductListViewController()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *products;

@end

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    /** 这句只对没有内容的空行有效 */
//    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    /** 这样设置有效，没有测试是不是在所有的系统均有效 */
    _tableView.tableFooterView = [[UIView alloc] init];

    [self.view addSubview:_tableView];
    
    [self loadData];
    
}

- (void)loadData{
    _products = @[
                    @{@"productName": @"工作汇报导出",
                      @"shortDescription": @"导出工作汇报",
                      @"price": @(100.0f)},
                    @{@"productName": @"客户拜访导出",
                      @"shortDescription": @"导出客户拜访",
                      @"price": @(100.0f)},
                    @{@"productName": @"群发短信",
                      @"shortDescription": @"祝福短信",
                      @"price": @(100.0f)}
                  ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"productCell";
    ProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ProductListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.product = self.products[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ProductListCell heightOfVisibilityCellWithProduct:self.products[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SubmitOrderViewController *submitOrderVC = [[SubmitOrderViewController alloc] init];
    submitOrderVC.product = self.products[indexPath.row];
    [self.navigationController pushViewController:submitOrderVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
