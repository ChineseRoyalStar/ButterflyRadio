//
//  TopRadiosModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PlayUrlModel.h"

@interface TopRadiosModel : NSObject

@property(nonatomic,copy) NSString *coverLarge;

@property(nonatomic,copy) NSString *coverSmall;

@property(nonatomic,strong) NSNumber *fmUid;

@property(nonatomic,strong) NSNumber *Id;

@property(nonatomic,copy) NSString *name;

@property(nonatomic,strong) NSNumber *playCount;

@property(nonatomic,strong) NSMutableArray *playUrl;

@property(nonatomic,strong) NSNumber *programId;

@property(nonatomic,copy) NSString *programName;

@property(nonatomic,strong) NSNumber *programScheduleId;

@property(nonatomic,strong) NSString *playedTime;

@end



