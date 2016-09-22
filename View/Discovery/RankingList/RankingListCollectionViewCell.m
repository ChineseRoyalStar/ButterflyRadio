//
//  RankingListCollectionViewCell.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "RankingListCollectionViewCell.h"

#import "NetworkingRequest.h"

#import "RankingListSectionModel.h"

#import "RankingListModel.h"

#import "FirstResultsModel.h"

#import "FocusImageModel.h"


#import "SDCycleScrollView.h"

#import "RankingListTableViewCell.h"


@interface RankingListCollectionViewCell()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property(nonatomic,strong) NSMutableArray *dataSource;

@property(nonatomic,strong) SDCycleScrollView *adScrollView;

@end

@implementation RankingListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self configureTableView];
    
    [self requestForRankingListData];
}


- (void)configureTableView {
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RankingListTableViewCell" bundle:nil] forCellReuseIdentifier:@"RankingListTableViewCell"];
    
}

- (NSMutableArray *)dataSource{
    
    if(!_dataSource){
        
        _dataSource = [[NSMutableArray alloc]init];
    }
    
    return _dataSource;
}

- (SDCycleScrollView *)adScrollView {
    
    if(!_adScrollView) {
        
        _adScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) delegate:self placeholderImage:[UIImage imageNamed:@"image_default_606.9"]];
        
    }
    return _adScrollView;
}


- (void)requestForRankingListData {
    
    [[NetworkingRequest sharedManager]requestForRankingListWithCallback:^(NSArray *rankingListModels, NSArray *focusImages, NSError *err) {
       
        if(!err){
            
            self.tableView.tableHeaderView = self.adScrollView;
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            
            [self.dataSource addObjectsFromArray:rankingListModels];
            
            NSMutableArray *imagesUrl = [[NSMutableArray alloc]init];
            
            for(FocusImageModel *model in focusImages){
                
                [imagesUrl addObject:model.pic];
            }
            
            self.adScrollView.imageURLStringsGroup = imagesUrl;
           
            [self.tableView reloadData];
            
        }
        
    }];

}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((RankingListSectionModel *)[self.dataSource objectAtIndex:section]).list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reusedIdentifier = @"RankingListTableViewCell";
    
    RankingListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedIdentifier forIndexPath:indexPath];
    
    RankingListModel *model = [((RankingListSectionModel *)[self.dataSource objectAtIndex:indexPath.section]).list objectAtIndex:indexPath.row];
    
    [cell.coverPathImageView sd_setImageWithURL:[NSURL URLWithString:model.coverPath] placeholderImage:[UIImage imageNamed:@"image_default_202.9"]];
    
    cell.titleLabel.text = model.title;
    
    cell.firstResultLabel.text = [NSString stringWithFormat:@"1 %@",((FirstResultsModel *)[model.firstKResults objectAtIndex:0]).title];
    
    cell.secondResultLabel.text = [NSString stringWithFormat:@"2 %@",((FirstResultsModel *)[model.firstKResults objectAtIndex:1]).title];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *sectionHeader = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_section_header"]];
    
    [headerView addSubview:sectionHeader];
    
    [sectionHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(headerView);
        
        make.height.mas_equalTo(@20);
        
        make.width.mas_equalTo(@17);
        
        make.left.equalTo(headerView).offset(15);
        
    }];
    
    UILabel *sectionTitleLabel = [[UILabel alloc]init];
    
    RankingListSectionModel *model = [self.dataSource objectAtIndex:section];
    
    sectionTitleLabel.text = model.title;
    
    [headerView addSubview:sectionTitleLabel];
    
    [sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(sectionHeader.mas_right).offset(3);
        
        make.centerY.equalTo(headerView);
        
        make.height.mas_equalTo(@20);
        
        make.right.equalTo(headerView).offset(8);
        
    }];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:false];
}


@end
