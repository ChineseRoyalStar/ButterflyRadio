//
//  AnchorModel.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnchorModel : NSObject

@property(nonatomic,strong) NSNumber *uid;

@property(nonatomic,copy) NSString *nickname;

@property(nonatomic,copy) NSString *smallLogo;

@property(nonatomic,assign) BOOL isVerified;

@property(nonatomic,copy) NSString *verifyTitle;

@end
