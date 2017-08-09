//
//  ForPWDViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/8/2.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "ForPWDViewController.h"

@interface ForPWDViewController ()<UITextFieldDelegate>{
    int timeCount;
    NSTimer*timer;
}
@property (weak, nonatomic) IBOutlet UITextField *userPhone;
@property (weak, nonatomic) IBOutlet UITextField *userNum;
@property (weak, nonatomic) IBOutlet UITextField *userPwd;
@property (weak, nonatomic) IBOutlet UITextField *userSurePwd;
@property (weak, nonatomic) IBOutlet UIButton *yanzheng;

@property (nonatomic, strong)UITextField *temp;

@end

@implementation ForPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更改密码";
    [_yanzheng setTitle:@"获取验证码" forState:UIControlStateNormal];
    _yanzheng.backgroundColor = [UIColor whiteColor];
  
    timeCount = 180;
    _userNum.delegate = self;
    _userPwd.delegate = self;
    _userPhone.delegate = self;
    _userSurePwd.delegate = self;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)yanzhengAction:(id)sender {
    
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
    timer.fireDate=[NSDate distantPast];
    _yanzheng.userInteractionEnabled = NO;
    
}

#pragma mark-->跑秒操作
-(void)dealTimer{
    
    
    [_yanzheng setTitle:[[NSString alloc]initWithFormat:@"%ds",timeCount] forState:UIControlStateNormal];
    timeCount=timeCount - 1;
    if(timeCount== 0){
        timer.fireDate=[NSDate distantFuture];
        timeCount= 180;
        _yanzheng.userInteractionEnabled = YES;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    return YES;
}

- (void)keyWillShow:(NSNotification *)notif{
    CGRect keyboardFrame = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = keyboardFrame.origin.y;
    //    NSLog(@"%f", height);
    CGFloat textField_maxY = self.temp.frame.size.height + self.temp.frame.origin.y;
    CGFloat transformY = SCREEN_HEIGHT - height - textField_maxY;
    if (transformY < 0) {
        CGRect frame = self.view.frame;
        frame.origin.y = transformY ;
        self.view.frame = frame;
    }
}



- (void)keyWillHide:(NSNotification *)notif{
    //恢复到默认y为0的状态，有时候要考虑导航栏要+64
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    self.view.frame = frame;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyWillHide:) name:UIKeyboardWillHideNotification object:nil];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    //    self.tabBarController.tabBar.hidden = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.temp = textField;
}


- (IBAction)changPwd:(id)sender {
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
