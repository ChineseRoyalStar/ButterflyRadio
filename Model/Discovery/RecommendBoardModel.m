//
//  RecommendBoardModel.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/15.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "RecommendBoardModel.h"


@implementation RecommendBoardModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"list":[EditorRecommendAlbumsModel class]};
}

@end
