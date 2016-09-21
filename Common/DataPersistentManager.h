//
//  DataPersistentManager.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FMDB/FMDB.h>

#import "TopRadiosModel.h"

@interface DataPersistentManager : NSObject

+ (instancetype)sharedManager;

- (void)deleteAll;

- (void)insertRecord:(TopRadiosModel *)model;

- (NSMutableArray *)queryForAll;

@end
