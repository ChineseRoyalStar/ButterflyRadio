//
//  AlbumTracksModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumTracksModel : NSObject

@property(nonatomic,strong) NSNumber *trackId;

@property(nonatomic,strong) NSNumber *uid;

@property(nonatomic,copy) NSString *playUrl64;

@property(nonatomic,copy) NSString *playUrl32;

@property(nonatomic,copy) NSString *playPathHq;

@property(nonatomic,copy) NSString *playPathAacy164;

@property(nonatomic,copy) NSString *playPathAacy224;

@property(nonatomic,copy) NSString *title;

@property(nonatomic,strong) NSNumber *duration;

@property(nonatomic,strong) NSNumber *albumId;

@property(nonatomic,copy) NSString *coverSmall;

@property(nonatomic,copy) NSString *coverMiddle;

@property(nonatomic,copy) NSString *coverLarge;

@property(nonatomic,copy) NSString *nickName;

@property(nonatomic,copy) NSString *smallLogo;

@property(nonatomic,strong) NSNumber *likes;

@property(nonatomic,strong) NSNumber *playtimes;

@property(nonatomic,strong) NSNumber *comments;

@property(nonatomic,strong) NSNumber *shares;

@end
