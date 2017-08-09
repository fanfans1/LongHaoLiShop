//
//  ShopCommonPayViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/8/5.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "ShopCommonPayViewController.h"

@interface ShopCommonPayViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ShopCommonPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btn.backgroundColor = BACKGROUNDCOLOR;
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.cornerRadius = 3;
    TAP(resign);
  
    // Do any additional setup after loading the view from its nib.
}

- (void)resign{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (IBAction)pushWithJPush:(id)sender {
    if (self.Money.text.length > 0) {
        
        NSLog(@"%@   %@",self.Money.text, self.beizhu.text);
    }
}




@end
