//
//  QRCodeViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/8/7.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "QRCodeViewController.h"
#import "SGQRCodeTool.h"
#import <AVFoundation/AVFoundation.h>

@interface QRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *QRCode;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码";
    self.QRCode.image = [SGQRCodeTool SG_generateWithLogoQRCodeData:@"sfgdsfgdsgds" logoImageName:@"logo.png" logoWidth:100];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
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
