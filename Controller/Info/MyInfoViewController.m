//
//  MyInfoViewController.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/10.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "MyInfoViewController.h"

#import "InfoOptionCell.h"

@interface MyInfoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) NSArray *dataSource;


@end

@implementation MyInfoViewController

- (NSArray *)dataSource {
    
    if(_dataSource == nil) {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MyInfoList" ofType:@"plist"];
        
        _dataSource = [NSArray arrayWithContentsOfFile:filePath];
        
    }
  
    return _dataSource;
}

- (UITableView *)tableView{

    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGTH-64-49) style:UITableViewStyleGrouped];
        
        [_tableView registerNib:[UINib nibWithNibName:@"InfoOptionCell" bundle:nil] forCellReuseIdentifier:@"InfoOptionCell"];
        
        [_tableView setSectionHeaderHeight:2];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)];
        
        [imgView addSubview:self.avatarImgView];
        
        imgView.image = [UIImage imageNamed:@"userinfo_bg.jpg"];
        
        [self.avatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(imgView);
            
            make.size.mas_equalTo(CGSizeMake(80,80));
            
        }];
        
        _tableView.tableHeaderView = imgView;
        
    }
    
    return _tableView;
}

- (UIImageView *)avatarImgView {
    
    if(_avatarImgView == nil) {
        
        _avatarImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"userinfo_avatar"]];
        
        _avatarImgView.layer.cornerRadius = _avatarImgView.frame.size.height/4;
        
        _avatarImgView.layer.masksToBounds = true;

    }

    return _avatarImgView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.backgroundColor = PURPLE_COLOR;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark:- UITableViewDelegaet Methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)[self.dataSource objectAtIndex:section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InfoOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoOptionCell" forIndexPath:indexPath];
    
    NSDictionary *dict = [(NSArray *)[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.iconImage.image = [UIImage imageNamed:[dict valueForKey:@"img"]];
    
    cell.titleLabel.text = [dict valueForKey:@"title"];
    
    cell.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:false];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 2;
}


@end
