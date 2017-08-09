//
//  ChangePhoneViewController.h
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/8/5.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangePhoneViewControllerDelegate <NSObject>

- (void)passPhoneNum:(NSString *)phoneNum;

@end

@interface ChangePhoneViewController : UIViewController

@property (nonatomic, assign) id<ChangePhoneViewControllerDelegate>delegate;

@end
