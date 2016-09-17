//
//  NetworkingRequest.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "NetworkingRequest.h"

#import "NavTitleModel.h"

#import "DiscoveryColumnsModel.h"

#import "EditorRecommendAlbumsModel.h"

#import "SpecialColumnModel.h"

#import "FocusImageModel.h"

#import <AFNetworking/AFNetworking.h>

@implementation NetworkingRequest

#pragma mark - 网络请求单例
+ (instancetype)sharedManager {
    
    static NetworkingRequest *sharedNetworkSingleton = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedNetworkSingleton = [[self alloc]init];
    });
    
    return sharedNetworkSingleton;
    
}

#pragma mark - 发现页标题请求
- (void)requestForNaviTitlesWithCallback:(void (^)(NSArray *titleArr,NSError *error))callBack {
    
    //http://mobile.ximalaya.com/mobile/discovery/v1/tabs?device=android
    
    
    NSString *url = @"http://mobile.ximalaya.com/mobile/discovery/v1/tabs?device=android";
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err = nil;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:NSJSONReadingMutableContainers error:&err];
        
        NSArray *arr = [((NSDictionary *)[dic valueForKey:@"tabs"]) valueForKey:@"list"];
        
        NSArray *modelArr = [NavTitleModel mj_objectArrayWithKeyValuesArray:arr];
        
        callBack(modelArr,nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        callBack(nil,error);
        
    }];
    
}

#pragma mark - 推荐界面的一部分，接口内容从ViewPager一直到精品听单

- (void)requestForRecommendPartOneWithCallback:(void (^)(NSArray *headAdsArr,SpecialColumnBoardModel *specials, RecommendBoardModel *focus, NSArray *discoveryColumnsArr, NSError *err))callBack {
    
    /*
     http://mobile.ximalaya.com/mobile/discovery/v3/recommends?channel=and-a1&device=android&includeActivity=true&includeSpecial=true&scale=2&version=4.3.98
     */
    
    NSString *baseUrl = @"http://mobile.ximalaya.com/mobile/discovery/v3/recommends";
    
    NSDictionary *paras = @{@"channel":@"and-a1",@"device":@"android",@"includeActivity":@"true",@"includeSpecial":@"true",@"scale":@"2",@"version":@"4.3.98"};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [manager POST:baseUrl parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err = nil;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        
        RecommendBoardModel *focus = [RecommendBoardModel mj_objectWithKeyValues:[dict valueForKey:@"editorRecommendAlbums"]];
        
        SpecialColumnBoardModel *specials = [SpecialColumnBoardModel mj_objectWithKeyValues:[dict valueForKey:@"specialColumn"]];
        
        NSArray *headerAdsArr = [FocusImageModel mj_objectArrayWithKeyValuesArray:[[dict valueForKey:@"focusImages"] valueForKey:@"list"]];
        
        NSArray *discoveryColumnsArr = [DiscoveryColumnsModel mj_objectArrayWithKeyValuesArray:[[dict valueForKey:@"discoveryColumns"] valueForKey:@"list"]];
        
        
        callBack(headerAdsArr,specials,focus,discoveryColumnsArr,nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        callBack(nil,nil,nil,nil,error);
        
    }];
    
}

#pragma mark - 从付费精品一致到听健康
- (void)requestForRecommentPartTwoWithCallback:(void (^)(NSArray *recommendModels, NSError *err))callBack{
    
    /*
     http://mobile.ximalaya.com/mobile/discovery/v1/recommend/hotAndGuess?device=android
     */
    
    NSString *baseUrl = @"http://mobile.ximalaya.com/mobile/discovery/v1/recommend/hotAndGuess";
    
    NSDictionary *paras = @{@"device":@"android"};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [manager POST:baseUrl parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err = nil;
        
        NSArray *listArr = [[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err] valueForKey:@"hotRecommends"] valueForKey:@"list"];
        
        NSArray *recommendModels = [RecommendBoardModel mj_objectArrayWithKeyValuesArray:listArr];
        
        callBack(recommendModels,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        callBack(nil,error);
    }];
    
}

#pragma mark - 现界面底部是广告接口，点击查看更多分类跳转到发现界面的分类中
- (void)requestForRecommendFinalPartWithCallBack:(void(^)(NSString *link, NSString *cover, NSError *err))callBack{
    
    /*
     http://adse.ximalaya.com/ting?device=android&name=find_banner&network=wifi&operator=0&version=4.3.98
     */
    
    NSString *baseUrl = @"http://adse.ximalaya.com/ting";
    
    NSDictionary *paras = @{@"device":@"android",@"name":@"find_banner",@"network":@"wifi",@"operator":@"0",@"version":@"4.3.98"};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [manager GET:baseUrl parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err = nil;

        NSDictionary *data = [[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err] valueForKey:@"data"] objectAtIndex:0];
        
       // NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        NSString *link = [data valueForKey:@"link"];
        
        NSString *cover = [data valueForKey:@"cover"];
        
        callBack(link,cover,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        callBack(nil,nil,error);
        
    }];
    
}

@end
