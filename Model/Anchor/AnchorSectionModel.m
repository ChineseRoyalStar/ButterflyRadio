//
//  AnchorSectionModel.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "AnchorSectionModel.h"

#import "AnchorModel.h"

@implementation AnchorSectionModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"list":[AnchorModel class]};
}

@end
