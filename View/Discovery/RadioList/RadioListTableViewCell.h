//
//  RadioListTableViewCell.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *programNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;


@end
