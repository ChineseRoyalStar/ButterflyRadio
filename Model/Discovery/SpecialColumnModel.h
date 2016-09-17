//
//  SpecialColumnModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialColumnModel : NSObject

@property(nonatomic,strong) NSNumber *columnType;

@property(nonatomic,strong) NSNumber *specialId;

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *subtitle;

@property(nonatomic,copy) NSString *footnote;

@property(nonatomic,copy) NSString *coverPath;

@property(nonatomic,copy) NSString *contentType;

@end
