//
//  DataPersistentManager.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "DataPersistentManager.h"


@interface DataPersistentManager()

@property(nonatomic,strong) FMDatabase *manager;

@end

@implementation DataPersistentManager

+ (instancetype)sharedManager {
    
    static DataPersistentManager *singleton = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        singleton = [[self alloc]init];
    });
    
    return singleton;
}


- (instancetype)init {
    
    if(self=[super init]){
        
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *dbPath = [NSString stringWithFormat:@"%@/radioList",documentPath];
        
        if(!_manager) {
            
            _manager = [[FMDatabase alloc]initWithPath:dbPath];
        }
    
        if(![self.manager open]){
            
            NSLog(@"Database open error");
        }
        
        
        NSString *createDatabase = @"create table if not exists radioList(id integer primary key autoincrement,name varchar(256), programme varchar(256), playTime varchar(256),image varchar(256))";
        
        [self.manager executeUpdate:createDatabase];
    }
    
    return self;
}

- (void)insertRecord:(TopRadiosModel *)model{
    
    NSString *insertRecord = @"insert into radioList(name,programme,playTime,image) values(?,?,?,?)";
    
    NSError *error = nil;
    
    NSDate *currentDate = [[NSDate alloc]init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    
    NSString *playTime = [formatter stringFromDate:currentDate];
    
    [self.manager executeUpdate:insertRecord values:@[model.name,model.programName,playTime,model.coverSmall] error:&error];
}


- (NSMutableArray *)queryForAll {
    
    NSMutableArray *results = [[NSMutableArray alloc]init];
    
    NSString *query = @"select * from radioList order by id desc";
    
    NSError *error = nil;
    
    FMResultSet *rs = [self.manager executeQuery:query values:nil error:&error];

    while([rs next]) {
        
        TopRadiosModel *model = [[TopRadiosModel alloc]init];
        
        model.name = [rs stringForColumn:@"name"];
        
        model.programName = [rs stringForColumn:@"programme"];
        
        model.playedTime = [rs stringForColumn:@"playTime"];
        
        model.coverSmall = [rs stringForColumn:@"image"];
        
        [results addObject:model];
    }
    
    return results;
}


- (BOOL)queryForExistenceWithChannelName:(NSString *)channelName{
    
    NSString *query = [NSString stringWithFormat:@"select * from radioList where name = '%@'",channelName];
    
    NSError *err = nil;
    
    FMResultSet *rs = [self.manager executeQuery:query values:nil error:&err];
    
    if([rs next]){
        
        return true;
        
    }else{
        
        return false;
    }
}


- (void)deleteAll {
    
    NSString *delete = @"delete from radioList";
    
    NSError *error = nil;
    
    [self.manager executeUpdate:delete values:nil error:&error];
}


- (void)deleteRecordWithName:(NSString *)name {
    
    NSString *delete = [NSString stringWithFormat:@"delete from radioList where name='%@'",name];
    
    NSError *err = nil;
    
    [self.manager executeUpdate:delete values:nil error:&err];
    
}


@end
