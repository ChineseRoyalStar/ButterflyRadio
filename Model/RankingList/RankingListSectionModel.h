//
//  RankingListSectionModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankingListSectionModel : NSObject

@property(nonatomic,strong) NSNumber *count;

@property(nonatomic,copy) NSString *title;

@property(nonatomic,strong) NSMutableArray *list;

@end
