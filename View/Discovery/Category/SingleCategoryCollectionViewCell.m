//
//  SingleCategoryCollectionViewCell.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/18.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "SingleCategoryCollectionViewCell.h"

@implementation SingleCategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.borderWidth = 0.6;
    
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;

}

@end
