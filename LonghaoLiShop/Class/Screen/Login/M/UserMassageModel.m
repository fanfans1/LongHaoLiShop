//
//  UserMassage.m
//  LongHaoLiShop
//
//  Created by 亿缘 on 2017/7/18.
//  Copyright © 2017年 亿缘. All rights reserved.
//

#import "UserMassageModel.h"

@implementation UserMassageModel



- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.isLogin forKey:@"isLogin"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.userid forKey:@"userid"];
    [aCoder encodeObject:self.alia forKey:@"alia"];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
     
        self.isLogin = [aDecoder decodeObjectForKey:@"isLogin"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.userid = [aDecoder decodeObjectForKey:@"userid"];
        self.alia = [aDecoder decodeObjectForKey:@"alia"];
        
        
    }
    return self;
}



@end
