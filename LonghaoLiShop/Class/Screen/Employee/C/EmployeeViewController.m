//
//  EmployeeViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/7/28.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "EmployeeViewController.h"

#import "EmployeeShopViewController.h" // 商户推荐
#import "EmployeeNoticeTableViewController.h"  // 公告
 

@interface EmployeeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation EmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBarTintColor: BACKGROUNDCOLOR];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces =NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview: self.tableView];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 8) {
        return 64*SCREEN_WIDTH/414;
    }else{
        return 150;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
        cell.textLabel.text = @"推广人";
        cell.detailTextLabel.text = @"张三";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 1){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellStyleValue1;
        cell.textLabel.text = @"联系方式";
        NSString *originTel = @"15355554444";
        if (originTel.length > 5) {
            
            NSString *tel = [originTel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            cell.detailTextLabel.text = tel;
        }else{
            cell.detailTextLabel.text= @"";
        }
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 2){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellStyleValue1;
        cell.textLabel.text = @"去推荐";
        NSString *originTel = @"Z54XY4";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text= originTel;
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 3){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellStyleValue1;
        cell.textLabel.text = @"用户推荐";
        NSString *originTel = @"15325";
        cell.detailTextLabel.text= originTel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 4){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellStyleValue1;
        cell.textLabel.text = @"商户推荐";
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 5){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellStyleValue1;
        cell.textLabel.text = @"我的二维码";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 6){
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellStyleValue1;
        cell.textLabel.text = @"公告";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 7){
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellStyleValue1;
        cell.textLabel.text = @"更改密码";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = RECTMACK(20, 50, 374, 50);
            [btn setTitle:@"退出登录" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 5;
            btn.backgroundColor = BACKGROUNDCOLOR;
            [btn addTarget:self action:@selector(ResignLogin) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview: btn];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        ChangePhoneViewController *change = [[ChangePhoneViewController alloc] init];
        [self.navigationController pushViewController:change animated:YES];
    }if (indexPath.row == 4) {
        EmployeeShopViewController *change = [[EmployeeShopViewController alloc] init];
        [self.navigationController pushViewController:change animated:YES];
    }if (indexPath.row == 5) {
        QRCodeViewController *qr = [[QRCodeViewController alloc] init];
        [self.navigationController pushViewController:qr animated:YES];
    }if (indexPath.row == 6) {
        EmployeeNoticeTableViewController *notice = [[EmployeeNoticeTableViewController alloc] init];
        [self.navigationController pushViewController:notice animated:YES];
    }else if (indexPath.row == 7){
        ForPWDViewController *pwd = [[ForPWDViewController alloc] init];
        [self.navigationController pushViewController:pwd animated:YES];
    }
    
    
    
    
}

- (void)ResignLogin{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    UserMassageModel *model = [[UserMassageModel alloc] init];
    model.isLogin = @"0";   // 登录类型
    model.alia = @"";    // 头像
    model.userid = @"";    // 用户ID
    model.name = @"";     // 名字
    model.phone = @"";   // 电话号码
    model.type = @"";
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [user setObject:data forKey:@"model"];

    LoginViewController  *login = [[LoginViewController alloc] init];
    
    APPDELEGATE.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:login];
//    ALERT(@"取消登录");
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
