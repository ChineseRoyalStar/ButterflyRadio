//
//  AnchorSectionModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnchorSectionModel : NSObject

@property(nonatomic,strong) NSNumber *Id;

@property(nonatomic,copy) NSString *name;

@property(nonatomic,copy) NSString *title;

@property(nonatomic,strong) NSMutableArray *list;

@end
