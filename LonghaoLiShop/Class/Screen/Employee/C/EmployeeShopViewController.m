//
//  EmployeeShopViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/8/7.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "EmployeeShopViewController.h"
#import "EmployeeWaitShopViewController.h"
@interface EmployeeShopViewController ()

@end

@implementation EmployeeShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOUR(222, 222, 222);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self ViewInit];
    // Do any additional setup after loading the view.
}

- (void)ViewInit{
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH/2-0.5, 64)];
    num.textAlignment = NSTextAlignmentCenter;
    num.font = FONT(17);
    num.backgroundColor = [UIColor whiteColor];
    num.text = @"月（85）";
    [self.view addSubview: num];
    
    UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+0.5, 64, SCREEN_WIDTH/2-0.5, 64)];
    money.textAlignment = NSTextAlignmentCenter;
    money.font = FONT(17);
    money.text = @"全（85525）";
    money.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: money];
    num.layer.masksToBounds= YES;
    num.layer.borderWidth = 1;
    num.layer.borderColor = COLOUR(222, 222, 222).CGColor;
    money.layer.masksToBounds= YES;
    money.layer.borderWidth = 1;
    money.layer.borderColor = COLOUR(222, 222, 222).CGColor;
    
    
    UILabel *payNum = [[UILabel alloc] initWithFrame:RECTMACK(30, 250, 150, 150)];
    payNum.numberOfLines = 2;
    payNum.textAlignment = NSTextAlignmentCenter;
    payNum.text = @"消费笔数\n25200";
    payNum.layer.masksToBounds = YES;
    payNum.layer.cornerRadius = 75*SCREEN_WIDTH/414;
    payNum.backgroundColor = [UIColor whiteColor];
    payNum.font = FONT(17);
    [self.view addSubview: payNum];
    
    UILabel *payMoney = [[UILabel alloc] initWithFrame:RECTMACK(234, 250, 150, 150)];
    payMoney.numberOfLines = 2;
    payMoney.text = @"消费金额\n25200";
    payMoney.layer.masksToBounds = YES;
    payMoney.textAlignment = NSTextAlignmentCenter;

    payMoney.layer.cornerRadius = 75*SCREEN_WIDTH/414;
    payMoney.font = FONT(17);
    payMoney.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: payMoney];
    
    
    UIButton *shop = [UIButton buttonWithType:UIButtonTypeSystem];
    shop.frame = RECTMACK(50, 450, 314, 50);
    [shop  setTitle:@"未激活商户" forState:UIControlStateNormal];
    [shop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shop.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview: shop];
    [shop addTarget:self action:@selector(shop) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)shop{
    EmployeeWaitShopViewController *wait = [[EmployeeWaitShopViewController alloc] init];
    [self.navigationController pushViewController:wait animated:YES];
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
