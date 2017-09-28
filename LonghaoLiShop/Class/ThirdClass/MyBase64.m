//
//  MyBase64.m
//  LongHaoLi
//
//  Created by Guang shen on 2017/8/29.
//  Copyright © 2017年 fanfan. All rights reserved.
//

#import "MyBase64.h"

@implementation MyBase64



+(NSString *)base64EncodingWithData:(NSData *)sourceData{
    if (!sourceData) {//如果sourceData则返回nil，不进行加密。
        return nil;
    }
    NSString *resultString = [sourceData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return resultString;
}

+(id)base64EncodingWithString:(NSString *)sourceString{
    if (!sourceString) {
        return nil;//如果sourceString则返回nil，不进行解密。
    }
    NSData *resultData = [[NSData alloc]initWithBase64EncodedString:sourceString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return resultData;
}

+(NSString*)getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a*1000];//转为字符型
    return timeString;
}




@end
