//
//  RadioListCollectionViewCell.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/19.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "RadioListCollectionViewCell.h"

#import "NetworkingRequest.h"

#import "RadioCategoryModel.h"

#import "TopRadiosModel.h"

#import "RadioListTableViewCell.h"

#import "DataPersistentManager.h"


#define ICON_TITLES @[@"本地台",@"国家台",@"省市台",@"网络台"]

#define ICON_NAMES @[@"icon_radio_local",@"icon_radio_country",@"icon_radio_province",@"icon_radio_internet"]

#define LINE_SPACE 30 //行间距

#define INTER_SPACE 30 //列间距

#define ICON_WIDTH (SCREEN_WIDTH-LINE_SPACE*5)/4

#define ICON_HEIGHT 70

#define BUTTON_WIDTH SCREEN_WIDTH/4

#define BUTTON_HEIGHT 40


@interface RadioListCollectionViewCell()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIView *tableHeaderView;

@property(nonatomic,strong) NSMutableArray<NSArray *> *dataSource;

@property(nonatomic,strong) UIView *btnView;

@end

@implementation RadioListCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self configureTableView];
    
    [self prepareForChannelData];
    
}


- (void)configureTableView {
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RadioListTableViewCell" bundle:nil] forCellReuseIdentifier:@"RadioListTableViewCell"];
    
}

- (NSMutableArray *)dataSource {
    
    if(!_dataSource){
        
        _dataSource = [[NSMutableArray alloc]init];
        
    }
    return _dataSource;
}

- (UIView *)tableHeaderView{
    
    if(!_tableHeaderView) {
        
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
        
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        
        self.tableView.tableHeaderView = _tableHeaderView;
        
        UIButton *preBtn = nil;
        
        for(int i=0;i<ICON_TITLES.count;i++){
            
            UIButton *button = [[UIButton alloc]init];
            
            [_tableHeaderView addSubview:button];
            
            button.frame = CGRectMake((CGFloat)(i*(ICON_WIDTH+INTER_SPACE)+INTER_SPACE), LINE_SPACE, ICON_WIDTH, ICON_HEIGHT);
            
            [button setTitle:ICON_TITLES[i] forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
            
            [button setBackgroundImage:[UIImage imageNamed:ICON_NAMES[i]] forState:UIControlStateNormal];
            
            button.titleEdgeInsets = UIEdgeInsetsMake(40, 0, -40, 0);
            
            preBtn = button;
            
            [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
               
                [[DataPersistentManager sharedManager] deleteAll];
                
                [self.dataSource removeObjectAtIndex:1];
                
                [self.dataSource addObject:[[NSArray alloc]init]];
                
                [self.tableView reloadData];
                
            }];
            
        }
        
    }
    
    return _tableHeaderView;
}

- (UIView *)btnView {
    
    if(!_btnView) {
        
        _btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 2*LINE_SPACE+ICON_HEIGHT, SCREEN_WIDTH, BUTTON_HEIGHT*2)];
        
        [_btnView setClipsToBounds:YES];
        
        [self.tableHeaderView addSubview:_btnView];
        
    }
    
    return _btnView;
}


- (void)createButtonWithModels:(NSArray<RadioCategoryModel*> *)channelList {
    
    for(int i=0;i<channelList.count+1;i++){
        
        int column = i/4;
        
        int row = i%4;
        
        CGRect rect = CGRectMake((CGFloat)row*BUTTON_WIDTH, (CGFloat)column*BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT);
        
        UIButton *button =  [[UIButton alloc]initWithFrame:rect];
        
        [self.btnView addSubview:button];
        
        button.tag = i+1000;
        
        button.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        
        button.layer.borderWidth = 1;
        
        if(i==channelList.count){
            
            [button setImage:[UIImage imageNamed:@"icon_radio_hide.png"] forState:UIControlStateNormal];
            
            [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
                UIButton *btn = [self.btnView viewWithTag:1007];
                
                [btn setImage:[UIImage imageNamed:@"icon_radio_show.png"] forState:UIControlStateNormal];
                
                [btn setTitle:nil forState:UIControlStateNormal];
                
                
                self.btnView.height -= (CGFloat)2*BUTTON_HEIGHT;
                
                self.tableHeaderView.height -= (CGFloat)2*BUTTON_HEIGHT;
                
                self.tableView.tableHeaderView = self.tableHeaderView;
                
            }];
            
        }else if(i==7){//创建show按钮
            
            [button setImage:[UIImage imageNamed:@"icon_radio_show.png"] forState:UIControlStateNormal];
            
            [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
                [button setTitle:channelList[i].name forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
                
                [button setImage:nil forState:UIControlStateNormal];
                
                self.btnView.height += (CGFloat)2*BUTTON_HEIGHT;
                
                self.tableHeaderView.height += (CGFloat)2*BUTTON_HEIGHT;
                
                [self.tableView beginUpdates];
                
                [self.tableView setTableHeaderView:self.tableHeaderView];
                
                [self.tableView endUpdates];
                
            }];
            
        }else {
            
            [button setTitle:[channelList objectAtIndex:i].name forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
            
        }
        
    }
    
}


#pragma NetworkingRequest

- (void)prepareForChannelData {
    
    [[NetworkingRequest sharedManager] reuquestForChannelListWithCallback:^(NSArray *channelList, NSArray *topRadios, NSError *err) {
        
        if(!err) {
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            
            [self createButtonWithModels:channelList];
            
            [self.dataSource addObject:topRadios];
            //数据库缓存上次收听频道和节目
            NSArray *arr = [[DataPersistentManager sharedManager]queryForAll];
            
            [self.dataSource addObject:arr];
            
            [self.tableView reloadData];
            
        }
        
    }];
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataSource objectAtIndex:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *reusedIdentifier = @"RadioListTableViewCell";
    
    RadioListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedIdentifier forIndexPath:indexPath];
    
    TopRadiosModel *model = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] placeholderImage:[UIImage imageNamed:@"image_default_200"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.nameLabel.text = model.name;
    
    
    
    if(indexPath.section == 0) {
        
        cell.programNameLabel.text = [NSString stringWithFormat:@"正在直播:%@",model.programName];
        
        cell.playCountLabel.text = [NSString stringWithFormat:@"%.1f万人",model.playCount.floatValue/10000];
    }else {
        
        cell.programNameLabel.text = [NSString stringWithFormat:@"上次收听的节目：%@",model.programName];
        
        cell.playCountLabel.text = [NSString stringWithFormat:@"上次收听的时间：%@",model.playedTime];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    
    TopRadiosModel *model = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if(indexPath.section == 0) {
        
        BOOL isExist = [[DataPersistentManager sharedManager]queryForExistenceWithChannelName:model.name];
        
        if(isExist) {
            
            [[DataPersistentManager sharedManager]deleteRecordWithName:model.name];
        }
        
        [[DataPersistentManager sharedManager]insertRecord:[[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        
        [self.dataSource removeObjectAtIndex:1];
        
        [self.dataSource addObject:[[DataPersistentManager sharedManager]queryForAll]];
        
        [self.tableView reloadData];
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
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
    
    if(section == 0){
        
        titleLabel.text = @"排行榜";
    }else{
        
        titleLabel.text = @"收听历史";
    }
    

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

@end
