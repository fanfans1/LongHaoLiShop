//
//  ShopWaitShipmentsViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/7/29.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "ShopWaitShipmentsViewController.h"
#import "ShopWaitTableViewCell.h"
@interface ShopWaitShipmentsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)int page;

@property (nonatomic, retain)UITextField *orderNum; // 快递单号
@property (nonatomic, retain)UITextField *name; // 快递名称

@end

@implementation ShopWaitShipmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40 - 49)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopWaitTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview: self.tableView];
    // Do any additional setup after loading the view.
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    // Do any additional setup after loading the view.
}
- (void)refresh{
    _page = 1;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        [self getMassage];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        });
    });
}

- (void)loadMore{
    _page++;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        });
    });
}

- (void)getMassage{
    
    [MJPush postWithURLString:@"" parameters:nil success:^(id sucess) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120+16+24;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopWaitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.orderName.text = @"订单名称：点点滴滴";
    cell.orderNum.text = @"    订单号：56472356785645656";
    cell.orderTime.text = @"下单时间：2017.12.12";
    cell.orderPhone.text = @"联系方式：8888888888";
    cell.orderSure.text = @"确认发货";
    cell.orderSure.layer.borderWidth = 1;
    cell.orderSure.layer.cornerRadius = 3;
    cell.orderSure.layer.borderColor = [UIColor grayColor].CGColor;
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入核销订单号" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        //                text = textField;
        textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        self.orderNum =textField;
        textField.placeholder = @"请输入快递单号";
        textField.secureTextEntry = YES;
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        //                text = textField;
        textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        self.name =textField;
        textField.placeholder = @"请输入快递名称";
        textField.secureTextEntry = YES;
    }];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];

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
