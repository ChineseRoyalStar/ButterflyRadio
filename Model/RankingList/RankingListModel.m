//
//  RankingListModel.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "RankingListModel.h"

#import "FirstResultsModel.h"

@implementation RankingListModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"firstKResults":[FirstResultsModel class]};
}

@end
