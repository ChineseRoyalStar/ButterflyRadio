//
//  NetworkingRequest.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RecommendBoardModel.h"

#import "SpecialColumnBoardModel.h"

#import <AFNetworking/AFNetworking.h>

@interface NetworkingRequest : NSObject

+ (instancetype)sharedManager;

#pragma mark - 发现页标题请求
- (void)requestForNaviTitlesWithCallback:(void (^)(NSArray *titleArr,NSError *error))callBack;

#pragma mark - 推荐界面的一部分，接口内容从ViewPager一直到精品听单
- (void)requestForRecommendPartOneWithCallback:(void(^)(NSArray *headAdsArr, SpecialColumnBoardModel *special, RecommendBoardModel *focusArr, NSArray *discoveryColumns, NSError *err))callBack;

#pragma mark - 从付费精品一致到听健康
- (void)requestForRecommentPartTwoWithCallback:(void(^)(NSArray *recommendModels, NSError *err))callBack;

#pragma mark - 现界面底部是广告接口，点击查看更多分类跳转到发现界面的分类中
- (void)requestForRecommendFinalPartWithCallBack:(void(^)(NSString *link, NSString *cover, NSError *err))callBack;

#pragma mark - 发现分类界面
- (void)requestForCategoryDataWithCallBack:(void(^)(NSString *adCover, NSArray *models, NSError *err))callBack;

#pragma mark - 发现分类界面底部广告栏
- (void)requestForAdFooterInCategoryWithCallback:(void(^)(NSArray *adsUrl, NSError *err))callBack;

#pragma mark - 发现广播界面
- (void)reuquestForChannelListWithCallback:(void(^)(NSArray *channelList, NSArray *topRadios, NSError *err))callBack;

#pragma mark - 发现榜单
- (void)requestForRankingListWithCallback:(void(^)(NSArray *rankingListModels, NSArray *focusImages, NSError *err))callBack;


@end
