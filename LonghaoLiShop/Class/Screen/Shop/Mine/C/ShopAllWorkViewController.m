//
//  ShopAllWorkViewController.m
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/8/7.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import "ShopAllWorkViewController.h"
#import "ShopWorkTodayAndMonthTableViewCell.h"

@interface ShopAllWorkViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, assign)int page;

@end

@implementation ShopAllWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewInit];
    self.view.backgroundColor = COLOUR(222, 222, 222);
    // Do any additional setup after loading the view.
}

- (void)viewInit{
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2-0.5, 64)];
    num.textAlignment = NSTextAlignmentCenter;
    num.font = FONT(17);
    num.backgroundColor = [UIColor whiteColor];
    num.text = @"消费笔数：85";
    [self.view addSubview: num];
    
    UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+0.5, 0, SCREEN_WIDTH/2-0.5, 64)];
    money.textAlignment = NSTextAlignmentCenter;
    money.font = FONT(17);
    money.text = @"消费金额:85525";
    money.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: money];
    num.layer.masksToBounds= YES;
    num.layer.borderWidth = 1;
    num.layer.borderColor = COLOUR(222, 222, 222).CGColor;
    money.layer.masksToBounds= YES;
    money.layer.borderWidth = 1;
    money.layer.borderColor = COLOUR(222, 222, 222).CGColor;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 128 )];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    [self.tableView registerClass:[ShopWorkTodayAndMonthTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopWorkTodayAndMonthTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview: self.tableView];
    
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10*2 + 30*4 +8 *3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopWorkTodayAndMonthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.name.text = @"大盘鸡";
    cell.order.text = @"2345674564564";
    cell.time.text = @"2014.02.3";
    cell.phone.text = @"11011012145";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
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
