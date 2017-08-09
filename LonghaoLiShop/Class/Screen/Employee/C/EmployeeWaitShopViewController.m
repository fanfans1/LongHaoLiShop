//
//  EmployeeWaitShopViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/8/7.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "EmployeeWaitShopViewController.h"
#import "EmployeeWaitShopTableViewCell.h"

@interface EmployeeWaitShopViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain)UITableView *tableView;

@end

@implementation EmployeeWaitShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"未激活商户";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"EmployeeWaitShopTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview: self.tableView];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10*2 + 30*3 + 8*2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EmployeeWaitShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.name.text = @"安徽省大会上的好";
    cell.phone.text = @"123456789123";
    cell.payNum.text = [NSString stringWithFormat:@"消费笔数:%d",1234];
    cell.payMoney.text = [NSString stringWithFormat:@"消费金额:%.2f",5646.56];
    
    return cell;
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
