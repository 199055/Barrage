//
//  DrBarrageDataManger.m
//  Driver
//
//  Created by zhangyapeng on 16/8/30.
//  Copyright © 2016年 Driver. All rights reserved.
//

#import "DrBarrageDataManger.h"


@interface DrBarrageDataManger ()
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, strong)NSLock *lock;
@end
@implementation DrBarrageDataManger
+ (instancetype)shareBarrageManger
{
    static DrBarrageDataManger *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[DrBarrageDataManger alloc] init];
    });
    return manger;
}

- (NSDictionary *)getNewItemData
{
    [self.lock lock];
    NSDictionary *dic;
    if (self.index < self.dataArray.count) {
        dic = [self.dataArray objectAtIndex:self.index];
    }else
    {
        self.index = 0;
        dic = [self.dataArray objectAtIndex:self.index];
    }
    self.index ++;
    [self.lock unlock];
    return dic;
}




#pragma mark--- lazy load
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        self.index = 0;
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i < 20; i++)
        {
            NSString *content = [NSString stringWithFormat:@"弹幕 %ld",i];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"vipbiao",@"image",content,@"content" ,nil];
            [_dataArray addObject:dic];
        }
    }
    return _dataArray;
}

- (NSLock *)lock
{
    if (!_lock) {
        _lock = [[NSLock alloc] init];
    }
    return _lock;
}





@end
