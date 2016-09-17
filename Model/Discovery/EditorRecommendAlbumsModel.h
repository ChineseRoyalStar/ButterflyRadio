//
//  EditorRecommendAlbumsModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditorRecommendAlbumsModel : NSObject

@property(nonatomic,strong) NSNumber *identifier;

@property(nonatomic,strong) NSNumber *albumId;

@property(nonatomic,strong) NSNumber *uid;

@property(nonatomic,copy) NSString *intro;

@property(nonatomic,copy) NSString *nickname;

@property(nonatomic,copy) NSString *albumCoverUrl290;

@property(nonatomic,copy) NSString *coverSmall;

@property(nonatomic,copy) NSString *coverMiddle;

@property(nonatomic,copy) NSString *coverLarge;

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *tags;

@property(nonatomic,strong) NSNumber *tracks;

@property(nonatomic,strong) NSNumber *playCounts;

@property(nonatomic,strong) NSNumber *isFinished;

@property(nonatomic,strong) NSNumber *serialState;

@property(nonatomic,strong) NSNumber *trackId;

@property(nonatomic,copy) NSString *trackTitle;

@property(nonatomic,strong) NSNumber *commentsCount;

@property(nonatomic,strong) NSNumber *priceTypeId;

@end
