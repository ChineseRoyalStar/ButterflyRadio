//
//  SpecialColumnBoardModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/16.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SpecialColumnModel.h"

@interface SpecialColumnBoardModel : NSObject

@property(nonatomic,strong) NSNumber *ret;

@property(nonatomic,copy) NSString *title;

@property(nonatomic,assign) BOOL hasMore;

@property(nonatomic,strong) NSArray *list;

@end
