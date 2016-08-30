//
//  DrBarragePieceView.m
//  Driver
//
//  Created by zhangyapeng on 16/8/29.
//  Copyright © 2016年 Driver. All rights reserved.
//

#import "DrBarragePieceView.h"
#import "DrBarrageDataManger.h"
#import "DrBarrageItem.h"


#define selfHeight self.frame.size.height

@implementation DrBarragePieceView

- (instancetype)initWithFrame:(CGRect)frame direction:(BarrageMoveDirection)direction noficationName:(NSString *)noName
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.direction = direction;
        self.noName = noName;
        //默认创建一个
        [self creatItem];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createNewItem:) name:noName object:nil];
    }
    return self;
}

#pragma mark--- 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
- (void)createNewItem:(NSNotification *)no
{
    [self creatItem];
}

- (void)creatItem
{
    NSDictionary *dataDic = [[DrBarrageDataManger shareBarrageManger] getNewItemData];
    NSInteger height = (int)(selfHeight/3);
    NSInteger dixtanceY = arc4random() % height;
    if (self.direction == BarrageDirectionLeft) {
        DrBarrageItem *item = [[DrBarrageItem alloc] initWithFrame:CGRectMake(0, dixtanceY, 0, selfHeight/3*2) withData:dataDic noficationName:self.noName];
        [self addSubview:item];
    }else if (self.direction == BarrageDirectionRight)
    {
        DrBarrageItem *item = [[DrBarrageItem alloc] initWithFrame:CGRectMake(self.frame.size.width, dixtanceY, 0, selfHeight/3*2) withData:dataDic noficationName:self.noName];
        [self addSubview:item];
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];;
}






@end
