//
//  RankingListTableViewCell.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverPathImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *firstResultLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondResultLabel;

@end
