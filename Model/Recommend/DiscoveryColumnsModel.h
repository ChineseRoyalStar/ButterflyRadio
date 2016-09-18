//
//  DiscoveryColumnsModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoveryColumnsModel : NSObject

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *subtitle;

@property(nonatomic,copy) NSString *coverPath;

@property(nonatomic,copy) NSString *contentType;

@property(nonatomic,copy) NSString *url;

@property(nonatomic,copy) NSString *sharePic;

@property(nonatomic,assign) BOOL enableShare;

@property(nonatomic,assign) BOOL isExternalUrl;

@end
