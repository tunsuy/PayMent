//
//  PayOrderViewController.m
//  PayMent
//
//  Created by tunsuy on 21/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "PayOrderViewController.h"
#import "TSFormCell.h"
#import "TSFormCell+Controller.h"
#import "PayManager.h"


typedef NS_ENUM(NSInteger, ClickPayType) {
    ClickPayTypeAli = 0,
    ClickPayTypeWx
};

@interface PayOrderViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *uiDataArr;
@property (nonatomic, assign) ClickPayType clickPayType;

@end

@implementation PayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
}

- (void)loadData {
    _uiDataArr = @[
                   @[
                       @{@"title": @"订单名称"},
                       @{@"title": @"订单金额"}
                       ],
                   @[
                       @{@"title": @"支付方式"},
                       @{@"title": @"支付宝支付"},
                       @{@"title": @"微信支付"}
                       ]
                   ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.uiDataArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.uiDataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFormCell *cell = [TSFormCell createCellWithTableView:tableView];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSDictionary *subViewsDic = @{@(CellSubstanceViewTypeDetail): self.order[@"orderName"],
                                          @(CellSubstanceViewTypeTitle): self.uiDataArr[indexPath.section][indexPath.row][@"title"]};
            [cell setCellSubstanceViewTypeDict:subViewsDic];
            return cell;
        }
        if (indexPath.row == 1) {
            NSDictionary *subViewsDic = @{@(CellSubstanceViewTypeDetail): [NSString stringWithFormat:@"%@", self.order[@"orderPrice"]],
                                          @(CellSubstanceViewTypeTitle): self.uiDataArr[indexPath.section][indexPath.row][@"title"]};
            [cell setCellSubstanceViewTypeDict:subViewsDic];
            return cell;
        }
        return nil;
    }
    if (indexPath.section == 1) {
        NSDictionary *subViewsDic = @{@(CellSubstanceViewTypeTitle): self.uiDataArr[indexPath.section][indexPath.row][@"title"]};
        [cell setCellSubstanceViewTypeDict:subViewsDic];
        UILabel *payLabel = (UILabel *)[cell getSubstanceView:CellSubstanceViewTypeTitle];
        payLabel.textColor = [UIColor blackColor];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 1 || indexPath.row == 2) {
            TSFormCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (indexPath.row == 1) {
                self.clickPayType = ClickPayTypeAli;
                cell.inputView.backgroundColor = [UIColor blueColor];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
                cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.inputView.backgroundColor = [UIColor clearColor];
            }
            else if (indexPath.row == 2) {
                self.clickPayType = ClickPayTypeWx;
                cell.inputView.backgroundColor = [UIColor blueColor];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
                cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.inputView.backgroundColor = [UIColor clearColor];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 60;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 50)];
        submitBtn.backgroundColor = [UIColor orangeColor];
        [submitBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(confirmPay:) forControlEvents:UIControlEventTouchUpInside];
        return submitBtn;
    }
    return nil;
}

- (void)confirmPay:(UIButton *)sender {
    /** 这里应该是要有个服务端请求，以此来得到serverResult */
    NSDictionary *serverResult;
    switch (self.clickPayType) {
        case ClickPayTypeAli:{
            OrderForPay *order = [[OrderForPay alloc] initWithAliPayOrderServerResult:serverResult];
            [[PayManager shareInstance] payForAliWithOrder:order callBack:^(id result) {
                if ([result isKindOfClass:[NSError class]]) {
                    /** 失败的处理 */
                    return;
                }
                /** 成功的处理 */
            }];
        }
            break;
        case ClickPayTypeWx:{
            OrderForPay *order = [[OrderForPay alloc] initWithWxPayReqServerResult:serverResult];
            [[PayManager shareInstance] payForWxWithPayReq:order.payReq callBack:^(id result) {
                if ([result isKindOfClass:[NSError class]]) {
                    /** 失败的处理 */
                    return;
                }
                /** 成功的处理 */
            }];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
