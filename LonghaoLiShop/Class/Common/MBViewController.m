//
//  MBViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/8/1.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "MBViewController.h"

#define iOS7 [[[UIDevice currentDevice] systemVersion] floatValue]>=7.0

@interface MBViewController ()

@property (nonatomic, retain) MBProgressHUD  *HUD;

@end

@implementation MBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建各种HUD效果的点击按钮
  
}

- (id)initWith{
    if (self = [super init]) {
        
        [APPDELEGATE.window.rootViewController addChildViewController: self];
        [APPDELEGATE.window.rootViewController.view addSubview: self.view];
        self.view.backgroundColor = [UIColor clearColor];
        [self hudAction];
    }
    return self;
}

//设置hud的提示文字、样式、代理等等
- (void)hudAction{
    
    _HUD =[MBProgressHUD showHUDAddedTo:self.view animated:YES]; //HUD效果添加哪个视图上
    _HUD.label.text = @"正在努力加载中...";     //加载时的提示文字
//    _HUD.detailsLabel.text = @"猪猪侠在这";    //详细提示文字，跟UITableViewCell的detailTextLabel差不多
 
    _HUD.mode = MBProgressHUDModeIndeterminate;   //加载效果的显示样式
            
    [self animationHud:_HUD];    ////MBProgressHUD自带HUD效果
  
    
}

//MBProgressHUD自带视图
- (void)animationHud:(MBProgressHUD *)hud {
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD HUDForView:self.view].progress = progress;
            });
            usleep(30);
        }
    });
}

- (void)remove{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.HUD removeFromSuperview];
        [self.view removeFromSuperview];
        self.HUD = nil;
    });
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
