//
//  FirstContentSytleCollectionViewCell.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/13.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "RecommendCollectionViewCell.h"

#import "DiscoveryCollectionViewCell.h"

#import "FirstStyleTableViewCell.h"

#import "SecondStyleTableViewCell.h"

#import "SpecialColumnModel.h"

#import "EditorRecommendAlbumsModel.h"

#import "FocusImageModel.h"

#import "DiscoveryColumnsModel.h"

#import "SpecialColumnModel.h"



@interface RecommendCollectionViewCell()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UIView *tableHeaderView;

@property(nonatomic,strong) UIView *tableFooterView;

@property(nonatomic,strong) SDCycleScrollView *adHeaderView;

@property(nonatomic,strong) SDCycleScrollView *adFooterView;

@property(nonatomic,strong) UICollectionView *discoveryCollectionView;

@property(nonatomic,strong) NSMutableArray *discoveryDataSource;

@property(nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation RecommendCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self configureTableView];
    
    [self prepareForRecommendData];
    
}

#pragma mark - configureTableView

- (void) configureTableView {
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self prepareForRecommendData];
        
    }];
    
    [self.tableView registerClass:[FirstStyleTableViewCell class]forCellReuseIdentifier:@"FirstStyleTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SecondStyleTableViewCell" bundle:nil] forCellReuseIdentifier:@"SecondStyleTableViewCell"];
}

#pragma mark - DataSource

//array which stores the discovery buttons

- (NSMutableArray *)discoveryDataSource {
    
    if(!_discoveryDataSource) {
        
        _discoveryDataSource = [[NSMutableArray alloc]init];
    }
    
    return _discoveryDataSource;
}


//array which store the content of section

- (NSMutableArray *)dataSource {
    
    if(!_dataSource) {
        
        _dataSource = [[NSMutableArray alloc]init];
        
    }
    
    return _dataSource;
}

#pragma mark - tableHeaderView

- (UIView *)tableHeaderView {
    
    if(!_tableHeaderView) {
        
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        
        [_tableHeaderView addSubview:self.adHeaderView];
        
        [_tableHeaderView addSubview:self.discoveryCollectionView];
        
    }
    
    return _tableHeaderView;
}

- (SDCycleScrollView *)adHeaderView {
    
    if(!_adHeaderView) {
        
        _adHeaderView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableHeaderView.height/3*2) delegate:self placeholderImage:[UIImage imageNamed:@"ic_navi_history"]];
        
        _adHeaderView.showPageControl = YES;
        
        _adHeaderView.infiniteLoop = YES;
        
    }
    return _adHeaderView;
}

- (UICollectionView *)discoveryCollectionView {
    
    if(!_discoveryCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumLineSpacing = 0;
        
        layout.minimumInteritemSpacing = 0;
        
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/4, self.tableHeaderView.height/3);
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _discoveryCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.adHeaderView.height, SCREEN_WIDTH, self.tableHeaderView.height/3) collectionViewLayout:layout];
        
        _discoveryCollectionView.backgroundColor = [UIColor whiteColor];
        
        _discoveryCollectionView.delegate = self;
        
        _discoveryCollectionView.dataSource = self;
        
        _discoveryCollectionView.showsHorizontalScrollIndicator = NO;
        
        [_discoveryCollectionView registerNib:[UINib nibWithNibName:@"DiscoveryCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"DiscoveryCollectionViewCell"];
        
    }
    
    return _discoveryCollectionView;
}


#pragma mark - tableFooterView

- (UIView *)tableFooterView {
    
    if(!_tableFooterView) {
        
        _tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        
        backView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        
        [backView addGestureRecognizer:tap];
        
        [_tableFooterView addSubview:backView];
        
        UIImageView *iconImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"category_more"]];
        
        [backView addSubview:iconImgView];
        
        [iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(backView);
            
            make.height.mas_equalTo(@24);
            
            make.width.mas_equalTo(@24);
            
            make.left.equalTo(backView).offset(10);
        }];
        
        
        UILabel *titleLabel = [[UILabel alloc]init];
        
        [backView addSubview:titleLabel];
        
        titleLabel.text = @"查看更多分类";
        
        titleLabel.textColor = [UIColor lightGrayColor];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(iconImgView);
            
            make.left.equalTo(iconImgView.mas_right).offset(15);
            
            make.height.mas_equalTo(@25);
            
        }];
        
        
        UIImageView *arrowImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_more_normal"]];
        
        [backView addSubview:arrowImgView];
        
        [arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(titleLabel);
            
            make.height.mas_equalTo(@15);
            
            make.width.mas_equalTo(@15);
            
            make.right.equalTo(backView).offset(-10);
            
        }];
        
        [_tableFooterView addSubview:self.adFooterView];
        
    }
    
    return _tableFooterView;
}

- (SDCycleScrollView *)adFooterView {
    
    if(!_adFooterView) {
        
        _adFooterView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 90) delegate:self placeholderImage:[UIImage imageNamed:@"ic_navi_history"]];
        
        _adFooterView.showPageControl = NO;
        
        _adFooterView.infiniteLoop = NO;
        
    }
    return _adFooterView;
}

- (void)tapAction {
    
    [self.delegate skipToCategoryBoard];
}

#pragma mark - NetworkingRequest

- (void)prepareForRecommendData{
    
    [self.dataSource removeAllObjects];
    
    [self.discoveryDataSource removeAllObjects];
    
    [[NetworkingRequest sharedManager]requestForRecommendPartOneWithCallback:^(NSArray *headAdsArr, SpecialColumnBoardModel *specials, RecommendBoardModel *focus, NSArray *discoveryColumns, NSError *err) {
        
        if(err == nil) {
            
            self.tableView.tableHeaderView = self.tableHeaderView;
            
            self.tableView.tableFooterView = self.tableFooterView;
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                NSMutableArray *adsUrlArr = [[NSMutableArray alloc]init];
                
                for(FocusImageModel *model in headAdsArr){
                    
                    [adsUrlArr addObject:model.pic];
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.adHeaderView.imageURLStringsGroup = adsUrlArr;
                    
                });
                
            });
            
            [self.discoveryDataSource addObjectsFromArray:discoveryColumns];
            
            [self.dataSource addObject:focus];
            
            [self.dataSource addObject:specials];
            
            [[NetworkingRequest sharedManager]requestForRecommentPartTwoWithCallback:^(NSArray *recommendModels, NSError *err) {
                
                if(err == nil){
                    
                    [self.dataSource addObjectsFromArray:recommendModels];
                    
                    [self.tableView reloadData];
                }
                
                [self.tableView.mj_header endRefreshing];
            }];
        }
    }];
    
    [[NetworkingRequest sharedManager]requestForRecommendFinalPartWithCallBack:^(NSString *link, NSString *cover, NSError *err) {
       
        if(err == nil) {
            
            self.adFooterView.imageURLStringsGroup = [NSArray arrayWithObject:cover];
            
            [self.tableView reloadData];
        }
    }];
    
}


#pragma mark - UICollectionViewDelegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.discoveryDataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reusedIdentifier = @"DiscoveryCollectionViewCell";
    
    DiscoveryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedIdentifier forIndexPath:indexPath];
    
    DiscoveryColumnsModel *model = [self.discoveryDataSource objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = model.title;
    
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.coverPath] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 1){
        
        return ((SpecialColumnBoardModel *)[self.dataSource objectAtIndex:1]).list.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section != 1){
        
        static NSString *reusedSytleOneIdentifier = @"FirstStyleTableViewCell";
        
        FirstStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedSytleOneIdentifier forIndexPath:indexPath];
        
        NSArray *arr = ((RecommendBoardModel *)[self.dataSource objectAtIndex:indexPath.section]).list;
        
        [cell.contentDataSource removeAllObjects];
        
        [cell.contentDataSource addObjectsFromArray:arr];
        
        [cell.contentCollectionView reloadData];
        
        return cell;
        
    }else {
        
        static NSString *reusedStyleTwoIdentifier = @"SecondStyleTableViewCell";
        
        SecondStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedStyleTwoIdentifier forIndexPath:indexPath];
        
        SpecialColumnModel *model = [((SpecialColumnBoardModel *)[self.dataSource objectAtIndex:indexPath.section]).list objectAtIndex:indexPath.row];
        
        [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.coverPath] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
        
        cell.titleLabel.text = model.title;
        
        cell.subTitleLabel.text = model.subtitle;
        
        cell.footNoteLabel.text = model.footnote;
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section!= 1){
        
        return SCREEN_WIDTH/3 + 60;
    }else {
        
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    RecommendBoardModel *model = [self.dataSource objectAtIndex:section];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *findingImgView = [[UIImageView alloc]init];
    
    findingImgView.image = [UIImage imageNamed:@"ic_section_header"];
    
    [headerView addSubview:findingImgView];
    
    [findingImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(headerView).offset(15);
        
        make.centerY.equalTo(headerView);
        
        make.height.mas_equalTo(@20);
        
        make.width.mas_equalTo(@15);
        
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    
    titleLabel.text = model.title;
    
    titleLabel.font=  [UIFont systemFontOfSize:15];
    
    [headerView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(findingImgView.mas_right).offset(5);
        
        make.centerY.equalTo(headerView);
        
        make.height.mas_equalTo(@20);
        
    }];
    
    
    UIButton *btn = [[UIButton alloc]init];
    
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    [btn setImage:[UIImage imageNamed:@"ic_more_normal"] forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:@"ic_more_pressed"] forState:UIControlStateHighlighted];
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 30 , 0, -30)];
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    
    [headerView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(headerView).offset(10);
        
        make.centerY.equalTo(headerView);
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@20);
        
    }];
    
    return headerView;
}

@end
