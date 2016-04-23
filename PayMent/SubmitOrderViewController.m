//
//  SubmitOrderViewController.m
//  PayMent
//
//  Created by tunsuy on 20/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "SubmitOrderViewController.h"
#import "TSFormCell.h"
#import "TSFormCell+Controller.h"
#import "PayOrderViewController.h"

#define kReduceOrAddBtnWidthOrHeight 30
#define kTotalPriceLabelWidthMin 50
#define kSubViewsPadding 5

@interface SubmitOrderViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *UIDataArr;
@property (nonatomic, assign) NSUInteger totalCopies;

@end

@implementation SubmitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadData];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
}

- (void)loadData {
    self.totalCopies = 1;
    NSString *productName = (self.product && self.product[@"productName"]) ? self.product[@"productName"] : @"";
    _UIDataArr = @[
                    @{@"title": productName,
                         @"cellType": @"singleLabelCell"},
                    @{@"title": @"份数",
                         @"cellType": @"muiltViewCell"},
                    @{@"title": @"合计",
                         @"cellType": @"singleLabelCell"}
                   ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_UIDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFormCell *cell = (TSFormCell *)[TSFormCell createCellWithTableView:tableView];

    if (indexPath.row == 0) {
        NSDictionary *subViewsDic = @{@(CellSubstanceViewTypeTitle): _UIDataArr[indexPath.row][@"title"],
                                      @(CellSubstanceViewTypeDetail): [NSString stringWithFormat:@"%@", self.product[@"price"]]};
        [cell setCellSubstanceViewTypeDict:subViewsDic];
        return cell;
    }
    if (indexPath.row == 1) {
        NSDictionary *subViewsDic = @{@(CellSubstanceViewTypeTitle): _UIDataArr[indexPath.row][@"title"]};
        [cell setCellSubstanceViewTypeDict:subViewsDic];
        
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-kPublicFormPaddingRight-kReduceOrAddBtnWidthOrHeight, kPublicFormTitleMergeTop, kReduceOrAddBtnWidthOrHeight, kPublicFormMinHeight-kPublicFormTitleMergeTop-kPublicFormTitleMergeBottom)];
        [addBtn setTitle:@"加" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addCopies:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-kPublicFormPaddingRight-kReduceOrAddBtnWidthOrHeight-kSubViewsPadding-kTotalPriceLabelWidthMin, kPublicFormTitleMergeTop, kTotalPriceLabelWidthMin, kPublicFormMinHeight-kPublicFormTitleMergeTop-kPublicFormTitleMergeBottom)];
        totalPriceLabel.text = [NSString stringWithFormat:@"%zd", self.totalCopies];
        totalPriceLabel.textAlignment = NSTextAlignmentCenter;
        
        UIButton *reduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-kReduceOrAddBtnWidthOrHeight-kPublicFormPaddingRight-kSubViewsPadding*2-totalPriceLabel.frame.size.width-kReduceOrAddBtnWidthOrHeight, kPublicFormTitleMergeTop, kReduceOrAddBtnWidthOrHeight, kPublicFormMinHeight-kPublicFormTitleMergeTop-kPublicFormTitleMergeBottom)];
        [reduceBtn setTitle:@"减" forState:UIControlStateNormal];
        [reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [reduceBtn addTarget:self action:@selector(reduceCopies:) forControlEvents:UIControlEventTouchUpInside];
        if (self.totalCopies <=1) {
            reduceBtn.enabled = NO;
        }
        
        [cell.inputView addSubview:addBtn];
        [cell.inputView addSubview:totalPriceLabel];
        [cell.inputView addSubview:reduceBtn];
        
        return cell;
    }
    if (indexPath.row == 2) {
        NSDictionary *subViewsDic = @{@(CellSubstanceViewTypeTitle): _UIDataArr[indexPath.row][@"title"],
                                      @(CellSubstanceViewTypeDetail): [NSString stringWithFormat:@"%u",       [self.product[@"price"] integerValue]*self.totalCopies]};
        [cell setCellSubstanceViewTypeDict:subViewsDic];
        return cell;
    }
    return nil;
    
}

- (void)addCopies:(UIButton *)sender {
    self.totalCopies += 1;
    [self.tableView reloadData];
}

- (void)reduceCopies:(UIButton *)sender {
    self.totalCopies -= 1;
    [self.tableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 50)];
    submitBtn.backgroundColor = [UIColor orangeColor];
    [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitOrder:) forControlEvents:UIControlEventTouchUpInside];
    return submitBtn;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60;
}

- (void)submitOrder:(UIButton *)sender {
    PayOrderViewController *payOrderVC = [[PayOrderViewController alloc] init];
//    payOrderVC.product = self.product;
    payOrderVC.order = @{@"orderName": self.product[@"productName"],
                         @"orderPrice": @([self.product[@"price"] integerValue]*self.totalCopies)};
    [self.navigationController pushViewController:payOrderVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
