//
//  RecommendBoardModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/15.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EditorRecommendAlbumsModel.h"

@interface RecommendBoardModel : NSObject

@property(nonatomic,assign) BOOL hasMore;

@property(nonatomic,copy) NSString *title;

@property(nonatomic,strong) NSNumber *ret;

@property(nonatomic,strong) NSArray *list;

@end
