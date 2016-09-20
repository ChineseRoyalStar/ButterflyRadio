//
//  TopRadiosModel.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "TopRadiosModel.h"

@implementation TopRadiosModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray {

    return @{@"playUrl":[PlayUrlModel class]};
}

@end
