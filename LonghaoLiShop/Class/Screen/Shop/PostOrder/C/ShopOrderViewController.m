//
//  ShopOrderViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/7/28.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "ShopOrderViewController.h"
#import "YYTopTitleView.h"
#import "ShopWaitShipmentsViewController.h"
#import "ShopOrderFinishViewController.h"
#import "ShopFlowNumViewController.h"

@interface ShopOrderViewController ()

@property (nonatomic,strong) YYTopTitleView *titleView;

@end

@implementation ShopOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
     self.navigationController.navigationBar.barTintColor = BACKGROUNDCOLOR;
    [self setScrollView];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)setScrollView{
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 )];
    
    
    ShopOrderFinishViewController *order = [[ShopOrderFinishViewController alloc] init];
    ShopWaitShipmentsViewController *compan = [[ShopWaitShipmentsViewController alloc] init];
    ShopFlowNumViewController *flow = [[ShopFlowNumViewController alloc] init];
    
    self.titleView.title = @[@"待发货",@"已核销",@"流水号"];
    [self.titleView setupViewControllerWithFatherVC:self childVC:@[compan,order,flow]];
    [self.view addSubview:self.titleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (YYTopTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[YYTopTitleView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, SCREEN_HEIGHT - 64 - 49)];
        _titleView.selectIndex = 0;
    }
    return _titleView;
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
