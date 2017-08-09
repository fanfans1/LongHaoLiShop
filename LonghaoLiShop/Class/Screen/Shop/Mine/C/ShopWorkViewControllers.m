//
//  ShopWorkViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/8/7.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "ShopWorkViewControllers.h"

#import "ShopWorkMonthViewController.h"
#import "ShopWorkTodayViewController.h"
#import "YYTopTitleView.h"

@interface ShopWorkViewControllers ()

@property (nonatomic, retain)YYTopTitleView *titleView;

@end

@implementation ShopWorkViewControllers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    [self setScrollViews];
    self.view.backgroundColor = COLOUR(222, 222, 222);
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)setScrollViews{
    
    
        ShopWorkTodayViewController *order = [[ShopWorkTodayViewController alloc] init];
        ShopWorkMonthViewController *compan = [[ShopWorkMonthViewController alloc] init];
    
        self.titleView.title = @[@"今日业绩",@"本月业绩"];
        [self.titleView setupViewControllerWithFatherVC:self childVC:@[order,compan]];
    
        [self.view addSubview:self.titleView];
}

- (YYTopTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[YYTopTitleView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, SCREEN_HEIGHT - 64)];
        _titleView.selectIndex = self.selectIndex;
    }
    return _titleView;
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
