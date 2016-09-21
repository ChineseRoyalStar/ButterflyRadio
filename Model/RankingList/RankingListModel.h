//
//  RankingListModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankingListModel : NSObject

@property(nonatomic,strong) NSNumber *ret;

@property(nonatomic,strong) NSNumber *maxPageId;

@property(nonatomic,strong) NSNumber *totalCount;

@property(nonatomic,strong) NSNumber *pageId;

@property(nonatomic,strong) NSNumber *pageSize;

@property(nonatomic,strong) NSNumber *rankingListId;

@property(nonatomic,copy) NSString *coverPath;

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *subtitle;

@property(nonatomic,copy) NSString *key;

@property(nonatomic,strong) NSNumber *orderNum;

@property(nonatomic,copy) NSString *contentType;

@property(nonatomic,copy) NSString *rankingRule;

@property(nonatomic,strong) NSNumber *period;

@property(nonatomic,strong) NSNumber *categoryId;

@property(nonatomic,strong) NSNumber *fisetId;

@property(nonatomic,copy) NSString *firstTitle;

@property(nonatomic,copy) NSString *calcPeriod;

@property(nonatomic,strong) NSNumber *top;

@property(nonatomic,strong) NSMutableArray *firstKResults;

@end
