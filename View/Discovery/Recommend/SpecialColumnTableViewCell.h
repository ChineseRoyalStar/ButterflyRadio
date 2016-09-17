//
//  SpecialColumnTableViewCell.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/16.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialColumnTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *footNoteLabel;

@end
