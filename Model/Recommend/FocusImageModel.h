//
//  FocusImageModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FocusImageModel : NSObject

@property(nonatomic,strong) NSNumber *id;

@property(nonatomic,copy) NSString *shortTitle;

@property(nonatomic,copy) NSString *longTitle;

@property(nonatomic,copy) NSString *pic;

@property(nonatomic,strong) NSNumber *type;

@property(nonatomic,strong) NSNumber *uid;

@property(nonatomic,strong) NSNumber *albumId;

@property(nonatomic,assign) BOOL isShare;

@end
