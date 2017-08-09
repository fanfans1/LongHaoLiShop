//
//  ShopCommonOrderViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/8/1.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "ShopCommonOrderViewController.h"
#import "ShopCommonNoUseViewController.h"
#import "ShopCommonFlowNumViewController.h"
#import "ShopCommonOrderFinishViewController.h"

#import "YYTopTitleView.h"

#import "SGScanningQRCodeVC.h"
#import "SGAlertView.h"
#import <AVFoundation/AVFoundation.h>

@interface ShopCommonOrderViewController ()

@property (nonatomic, retain)YYTopTitleView *titleView;
@property (nonatomic, retain)UITextField *textFile;

@end

@implementation ShopCommonOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = BACKGROUNDCOLOR;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"核销" style:UIBarButtonItemStyleDone target:self action:@selector(hexiao)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"扫一扫" style:UIBarButtonItemStyleDone target:self action:@selector(saoyisao)];
    
    [self setScrollView];
    // Do any additional setup after loading the view.
}

// 核销
- (void)hexiao{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入核销订单号" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        //                text = textField;
        textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        self.textFile =textField;
        textField.placeholder = @"请输入订单号";
        textField.secureTextEntry = YES;
    }];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self sureHeXiao];
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

// 确认核销

- (void)sureHeXiao{
    
    NSString *str = [NSString stringWithFormat:@"订单号：245638695684534556\n手机号：15536665544"];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否核销" message:str preferredStyle:UIAlertControllerStyleAlert];
    
 
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}



// 扫一扫
- (void)saoyisao{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        SGScanningQRCodeVC *VC = [[SGScanningQRCodeVC alloc] init];
//        VC.delegate = self;
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"未检测到您的摄像头, 请在真机上测试" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
        [alertView show];
    }
}

- (void)setScrollView{
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 )];
    
    
    ShopCommonNoUseViewController *order = [[ShopCommonNoUseViewController alloc] init];
    ShopCommonOrderFinishViewController *compan = [[ShopCommonOrderFinishViewController alloc] init];
    ShopCommonFlowNumViewController *flow = [[ShopCommonFlowNumViewController alloc] init];
    
    self.titleView.title = @[@"待使用",@"已核销",@"流水号"];
    [self.titleView setupViewControllerWithFatherVC:self childVC:@[order,compan,flow]];
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
