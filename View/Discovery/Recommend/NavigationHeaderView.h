//
//  NavigationHeaderView.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/13.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "DiscoveryViewController.h"


@interface NavigationHeaderView : UIView

@property(nonatomic,strong) NSMutableArray *navTitles;

@property(nonatomic,weak) DiscoveryViewController *delegate;

- (void)setUnderlineViewFrameWithOriginX:(CGFloat)originX;

- (void)setUnderlineViewFrameWithOriginY:(CGFloat)originY;

- (void)changeToCurrentSelectedIndex:(NSInteger)currentIndex;

@end
