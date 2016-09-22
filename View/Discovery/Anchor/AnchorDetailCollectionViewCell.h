//
//  AnchorDetailCollectionViewCell.h
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnchorDetailCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;

@end
