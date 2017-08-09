//
//  ShopWaitTableViewCell.h
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/7/29.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopWaitTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderName;
@property (weak, nonatomic) IBOutlet UILabel *orderNum;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet UILabel *orderPhone;
@property (weak, nonatomic) IBOutlet UILabel *orderSure;

@end
