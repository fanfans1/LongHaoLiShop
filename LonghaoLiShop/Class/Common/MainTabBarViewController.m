//
//  MainTabBarViewController.m
//  Longhaoli
//
//  Created by 亿缘 on 2017/7/8.
//  Copyright © 2017年 亿缘. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "ShopMineViewController.h"
#import "ShopOrderViewController.h"
#import "ShopCommonOrderViewController.h"


@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabbarController];
    
    // Do any additional setup after loading the view.
}


- (void)setTabbarController{
    
    ShopMineViewController *mine = [[ShopMineViewController alloc] init];
    ShopOrderViewController *order = [[ShopOrderViewController alloc] init];
    ShopCommonOrderViewController *commonOrder = [[ShopCommonOrderViewController alloc] init];
    
    UINavigationController *navmine = [[UINavigationController alloc] initWithRootViewController:mine];
    UINavigationController *navorder = [[UINavigationController alloc] initWithRootViewController:order];
    UINavigationController *navCommon = [[UINavigationController alloc] initWithRootViewController:commonOrder];
    
 
    
    // 设置字体颜色
    
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
//    self.navigationController.navigationBar.titleTextAttributes= dict;
    navmine.title = @"我的";
    navmine.navigationBar.titleTextAttributes= dict;
    navorder.title = @"订单";
    navorder.navigationBar.titleTextAttributes= dict;
    
    navCommon.title = @"订单";
    navCommon.navigationBar.titleTextAttributes = dict;
  
    
    navmine.tabBarItem.image = [[UIImage imageNamed:@"minegray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navorder.tabBarItem.image = [[UIImage imageNamed:@"ordergray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    navCommon.tabBarItem.image = [[UIImage imageNamed:@"ordergray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navCommon.tabBarItem.selectedImage = [[UIImage imageNamed:@"order"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    navmine.tabBarItem.selectedImage = [[UIImage imageNamed:@"mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navorder.tabBarItem.selectedImage = [[UIImage imageNamed:@"order"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 普通商户
    [self setViewControllers:@[navCommon,navmine] animated:YES];
    // 邮寄商户
//    [self setViewControllers:@[navorder,navmine] animated: YES];
    
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
