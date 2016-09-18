//
//  CategoryModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/18.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property(nonatomic,strong) NSNumber *Id;

@property(nonatomic,copy) NSString *name;

@property(nonatomic,copy) NSString *title;

@property(nonatomic,assign) BOOL isChecked;

@property(nonatomic,strong) NSNumber *orderNum;

@property(nonatomic,copy) NSString *coverPath;

@property(nonatomic,assign) BOOL selectedSwitch;

@property(nonatomic,assign) BOOL isFinished;

@property(nonatomic,copy) NSString *contentType;

@property(nonatomic,strong) NSNumber *categoryType;

@property(nonatomic,assign) BOOL filterSupported;

@property(nonatomic,assign) BOOL isPaid;

@end
