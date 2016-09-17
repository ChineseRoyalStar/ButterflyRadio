//
//  FirstStyleTableViewCell.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/15.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstStyleTableViewCell : UITableViewCell

@property(nonatomic,strong) UICollectionView *contentCollectionView;

@property(nonatomic,strong) NSMutableArray *contentDataSource;

@end
