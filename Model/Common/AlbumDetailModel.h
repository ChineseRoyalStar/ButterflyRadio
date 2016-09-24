//
//  AlbumDetailModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumDetailModel : NSObject

@property(nonatomic,strong) NSNumber *albumId;

@property(nonatomic,strong) NSNumber *categoryID;

@property(nonatomic,copy) NSString *categoryName;

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *coverOrigin;

@property(nonatomic,copy) NSString *coverSmall;

@property(nonatomic,copy) NSString *coverMiddle;

@property(nonatomic,copy) NSString *coverLarge;

@property(nonatomic,copy) NSString *coverWebLarge;

@property(nonatomic,copy) NSString *coverLargePop;

@property(nonatomic,strong) NSNumber *createdAt;

@property(nonatomic,strong) NSNumber *updatedAt;

@property(nonatomic,strong) NSNumber *uid;

@property(nonatomic,copy) NSString *nickName;

@property(nonatomic,assign) BOOL isVerified;

@property(nonatomic,copy) NSString *avatarPath;

@property(nonatomic,copy) NSString *intro;

@property(nonatomic,copy) NSString *playTimes;

@property(nonatomic,copy) NSString *detailCoverPath;

@end
