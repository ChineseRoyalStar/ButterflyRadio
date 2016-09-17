//
//  FirstContentSytleCollectionViewCell.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/13.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDCycleScrollView.h"

#import "NetworkingRequest.h"

@protocol RecommendCollectionViewCellDelegate <NSObject>

- (void)skipToCategoryBoard;

@end


@interface RecommendCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) id<RecommendCollectionViewCellDelegate> delegate;

@end
