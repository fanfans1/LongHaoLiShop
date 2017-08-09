//
//  ChangePhoneViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/8/5.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "ChangePhoneViewController.h"

@interface ChangePhoneViewController ()<UITextFieldDelegate>{
    int timeCount1;
    NSTimer*timer1;
    int timeCount2;
    NSTimer*timer2;
    
    
}
@property (weak, nonatomic) IBOutlet UIButton *yanzhengma1;
@property (weak, nonatomic) IBOutlet UIButton *yanzhengma2;
@property (weak, nonatomic) IBOutlet UITextField *yanzheng1;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *yanzheng2;

@property (nonatomic, strong)UITextField *temp;

@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    timeCount1= 180;
    timeCount2= 180;
    _yanzhengma2.userInteractionEnabled = NO;
    _yanzheng2.delegate = self;
    _yanzheng1.delegate = self;
    _phone.delegate = self;
    [self.phone addTarget:self action:@selector(changeUserActive) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view from its nib.
}

// 监听手机号码，改变获取验证码按钮
- (void)changeUserActive{
    if (_phone.text.length == 11) {
        _yanzhengma2.userInteractionEnabled = YES;
    }else{
        _yanzhengma2.userInteractionEnabled = NO;

    }
}

- (IBAction)yanzheng1Act:(id)sender {
    timer1=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dealTimer1) userInfo:nil repeats:YES];
    timer1.fireDate=[NSDate distantPast];
    _yanzhengma1.userInteractionEnabled = NO;
}

- (IBAction)yanzheng2Act:(id)sender {
    timer2=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dealTimer2) userInfo:nil repeats:YES];
    timer2.fireDate=[NSDate distantPast];
    _yanzhengma2.userInteractionEnabled = NO;
}

#pragma mark-->跑秒操作
-(void)dealTimer1{
    
    
    [_yanzhengma1 setTitle:[[NSString alloc]initWithFormat:@"%ds",timeCount1] forState:UIControlStateNormal];
    timeCount1=timeCount1 - 1;
    if(timeCount1== 0){
        timer1.fireDate=[NSDate distantFuture];
        timeCount1= 180;
        _yanzhengma1.userInteractionEnabled = YES;
    }
    
}


-(void)dealTimer2{
    
    
    [_yanzhengma2 setTitle:[[NSString alloc]initWithFormat:@"%ds",timeCount2] forState:UIControlStateNormal];
    timeCount2=timeCount2 - 1;
    if(timeCount2== 0){
        timer2.fireDate=[NSDate distantFuture];
        timeCount2= 180;
        _yanzhengma2.userInteractionEnabled = YES;
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
    CGFloat transformY = SCREEN_HEIGHT -  height - textField_maxY  ;
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

- (IBAction)change:(id)sender {
    
    [self.delegate passPhoneNum:self.phone.text];
    [self.navigationController popViewControllerAnimated:YES];
}

//获取键盘UIKeyboard
- (UIView *)getKeyBoard
{
    
    UIView *keyBoardView = nil;
    
    NSArray *windows = [[UIApplication sharedApplication] windows];
    
    for (UIWindow*window in [windows reverseObjectEnumerator])
    {
        keyBoardView = [self getKeyBoardInView:window];
        if (keyBoardView)
        {
            return keyBoardView;
        }
    }
    
    return nil;
}

- (UIView *)getKeyBoardInView:(UIView *)view
{
    
    for(UIView *subView in [view subviews])
    {
        if (strstr(object_getClassName(subView), "UIKeyboard"))
        {
            return subView;
        }else{
            
            UIView *tempView = [self getKeyBoardInView:subView];
            
            if (tempView)
            {
                return tempView;
            }
        }
    }
    
    return nil;
    
}

- (void)KeyBoardConcal{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
