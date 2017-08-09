//
//  loginViewController.m
//  LongHaoLiShop
//
//  Created by 亿缘 on 2017/7/18.
//  Copyright © 2017年 亿缘. All rights reserved.
//

#import "LoginViewController.h"
#import "MainTabBarViewController.h"
#import "EmployeeViewController.h"

#import "MBViewController.h"


@interface LoginViewController (){
    
    
    int timeCount;
    NSTimer*timer;
    
}
@property (nonatomic, retain)UIButton *rem;// 是否员工按钮

@property (nonatomic, strong)UITextField *phone;
@property (nonatomic, strong)UITextField *resigNum;
@property (nonatomic, strong)UIButton *getResignNum; // 获取验证码按钮
@property(nonatomic,strong)UILabel *tipLabel;       // 倒数秒
@property (nonatomic,strong)NSString * temp;        // 验证码
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     [self.navigationController.navigationBar setBarTintColor: BACKGROUNDCOLOR];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    //    self.navigationController.navigationBar.titleTextAttributes= dict;
//    self.title = @"我的";
    self.navigationController.navigationBar.titleTextAttributes= dict;
    self.title = @"登录";
    [self setViewController];
   
   
    // Do any additional setup after loading the view.
}

// 用户登录判断
- (void)setViewController{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"model"];
    if (data) {
        
        UserMassageModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if ([model.isLogin isEqualToString:@"1"]) {
            MainTabBarViewController *main = [[MainTabBarViewController alloc] init];
            APPDELEGATE.window.rootViewController =  main;
        }else if ([model.isLogin isEqualToString:@"2"]){
            EmployeeViewController *employee = [[EmployeeViewController alloc] init];
            
            APPDELEGATE.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:employee];
        }else{
            [self setLoginView];
        }
    }else{
        [self setLoginView];
    }
    
}



// 设置登录界面
- (void)setLoginView{
    
    self.phone = [[UITextField alloc] initWithFrame:RECTMACK(67, 100, 300, 50)];
    
    self.phone.layer.masksToBounds = YES;
    
    self.phone.layer.borderWidth = 1;
    
    self.phone.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.phone.keyboardType = UIKeyboardTypeNumberPad;
    self.phone.layer.cornerRadius = 5;
    
    self.phone.borderStyle = UITextBorderStyleRoundedRect;
    self.phone.leftViewMode = UITextFieldViewModeAlways;
    self.phone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:RECTMACK(5, 5, 40, 40)];
    image1.image = [UIImage imageNamed:@"user"];
    self.phone.leftView = image1;
    
    
    self.phone.placeholder = @"请输入账号";
    
    
    
    [self.view addSubview: self.phone];
    
    self.resigNum = [[UITextField alloc] initWithFrame:RECTMACK(67, 200, 300, 50)];
    
    self.resigNum.layer.masksToBounds = YES;
    
    self.resigNum.keyboardType = UIKeyboardTypeNumberPad;
    
    self.resigNum.layer.borderWidth = 1;
    
    self.resigNum.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.resigNum.layer.cornerRadius = 5;
    
    self.resigNum.borderStyle = UITextBorderStyleRoundedRect;
    self.resigNum.leftViewMode = UITextFieldViewModeAlways;
    self.resigNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:RECTMACK(5, 5, 40, 40)];
    image2.image = [UIImage imageNamed:@"pwd"];
    self.resigNum.leftView =  image2;
;
    
    self.resigNum.placeholder = @"请输入密码";
    
    [self.view addSubview: self.resigNum];
    
 
    
    UIButton *rem = [UIButton buttonWithType:UIButtonTypeCustom];
    rem.frame = RECTMACK(67, 275, 16, 16);
    [rem setImage:[UIImage imageNamed:@"glayRem.png"] forState:UIControlStateNormal];
    [rem setImage:[UIImage imageNamed:@"rember.png"] forState:UIControlStateSelected];
    rem.selected = NO;
    [self.view addSubview:rem];
    [rem addTarget:self action:@selector(remberPWD) forControlEvents:UIControlEventTouchUpInside];
    self.rem = rem;
    
    UILabel *remb = [[UILabel alloc] initWithFrame:RECTMACK(87, 275, 100, 16)];
    remb.textAlignment = NSTextAlignmentLeft;
    remb.font = FONT(16);
    remb.textColor = COLOUR( 192, 192, 192);
    remb.text = @"我是员工";
    
    [self.view addSubview: remb];
    remb.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remberPWD)];
    [remb addGestureRecognizer:tap];

    
    
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = RECTMACK(67, 400, 300, 50);
    btn.backgroundColor = [UIColor whiteColor];
    
    [btn setTitle:@"立即登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = BACKGROUNDCOLOR;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    btn.titleLabel.font = [UIFont systemFontOfSize:18*SCREEN_WIDTH/414 weight:1.5];
    [btn addTarget:self action:@selector(loginAccountButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];
    
 
}


- (void)remberPWD{
    self.rem.selected = !self.rem.selected;
    if (self.rem.selected) {
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        UserMassageModel *model = [[UserMassageModel alloc] init];
        model.isLogin = @"2";   // 登录类型
        model.alia = @"sadfhadjksfhaks";    // 头像
        model.userid = @"1";    // 用户ID
        model.name = @"小杜";     // 名字
        model.phone = @"15599998888";   // 电话号码
        model.type = @"common";
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        [user setObject:data forKey:@"model"];
    }else{
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        UserMassageModel *model = [[UserMassageModel alloc] init];
        model.isLogin = @"1";   // 登录类型
        model.alia = @"sadfhadjksfhaks";    // 头像
        model.userid = @"1";    // 用户ID
        model.name = @"小杜";     // 名字
        model.phone = @"15599998888";   // 电话号码
        model.type = @"employee";
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        [user setObject:data forKey:@"model"];
    }
    //    NSLog(@"记住密码");
}


//登录方法
-(void)loginAccountButton
{
    
    [self setViewController];
//    if ([_phone.text isEqualToString:@""]||_phone.text == nil||[_resigNum.text isEqualToString:@""]||_resigNum.text == nil) {
//        ALERT(@"用户名或密码不能为空");
//        return;
//    }else if (![_resigNum.text isEqualToString:_temp]){
//        ALERT(@"验证码有误")
//        return;
//    }else{
//        // 登录
//        [self loginAccountInter];
//    }
    
    
}



-(void)loginAccountInter
{
    [self.view endEditing:YES];
    
    
    NSString *json = [NSString stringWithFormat:@"{\"mobile_tel\":\"%@\", \"latitude_y\":\"%@\",\"latitude_x\":\"%@\"}",_phone.text ,@"0",@"0"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:json,@"param", nil];
    
    //    [mdic setObject:signture forKey:@"signture"];
    [MJPush postWithURLString:LOGIN parameters:dic success:^(id sucess) {
        // 登录成功赋值
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        UserMassageModel *model = [[UserMassageModel alloc] init];
        model.isLogin = @"1";   // 登录类型
        model.alia = @"sadfhadjksfhaks";    // 头像
        model.userid = @"1";    // 用户ID
        model.name = @"小杜";     // 名字
        model.phone = @"15599998888";   // 电话号码
        model.type = @"common";
        [user setObject:model forKey:@"model"];
        
        
        APPDELEGATE.window.rootViewController = [[MainTabBarViewController alloc] init];
        //         APPDELEGATE.window.rootViewController = [[MainTabBarViewController alloc] init];
    } failure:^(NSError *error) {
        
    }];
    
    
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
