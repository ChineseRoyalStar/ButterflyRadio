//
//  RankingListSectionModel.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "RankingListSectionModel.h"

#import "RankingListModel.h"

@implementation RankingListSectionModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"list":[RankingListModel class]};
}

@end
