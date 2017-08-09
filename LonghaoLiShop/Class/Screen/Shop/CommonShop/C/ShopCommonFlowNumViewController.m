//
//  ShopCommonFlowNumViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/8/1.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "ShopCommonFlowNumViewController.h"
#import "ShopWaitTableViewCell.h"
#import "ShopCommonWaitUseTableViewCell.h"

@interface ShopCommonFlowNumViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)int page;

@end

@implementation ShopCommonFlowNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40 - 49)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopWaitTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopCommonWaitUseTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
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

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
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
    if (indexPath.row%2 == 1) {
        return 120+16+24;
    }else{
        return 90 + 26;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row%2 == 1) {
        
        ShopWaitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderName.text = @"订单名称：点点滴滴";
        cell.orderNum.text = @"    订单号：56472356785645656";
        cell.orderTime.text = @"下单时间：2017.12.12";
        cell.orderPhone.text = @"联系方式：8888888888";
        cell.orderSure.hidden = YES;
        
        return cell;
        
    }else{
        ShopCommonWaitUseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderName.text = @"订单名称：点点滴滴";
        cell.orderTime.text = @"下单时间：2017.12.12";
        cell.orderPhone.text = @"联系方式：8888888888";
        return cell;
    }
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
