//
//  DrBarrageView.m
//  Driver
//
//  Created by zhangyapeng on 16/8/29.
//  Copyright © 2016年 Driver. All rights reserved.
//

#import "DrBarrageView.h"
#import "DrBarragePieceView.h"
#define selfHeight self.frame.size.height

@interface DrBarrageView ()
{
    dispatch_source_t timer;
}
@property (nonatomic, strong)UIImageView *backgroundImageView;
@end
@implementation DrBarrageView

- (instancetype)initWithFrame:(CGRect)frame moveDirection:(BarrageMoveDirection)direction
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.barrageDirection = direction;
        [self addSubview:self.backgroundImageView];
        [self layoutUI];
        [self startTimer];
    }
    return self;
}
#pragma mark--- 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundImageView.frame = self.bounds;
}

- (void)layoutUI
{
    for (NSInteger K = 0; K < 4; K++)
    {
        DrBarragePieceView *pieceView = [[DrBarragePieceView alloc] initWithFrame:CGRectMake(0, selfHeight/4.0*K, self.frame.size.width, selfHeight/4.0) direction:self.barrageDirection noficationName:[NSString stringWithFormat:@"%ld",K]];
        [self addSubview:pieceView];
    }
}
#pragma mark--- 定时器
- (void)startTimer
{
    // 要将timer保存起来，不然timer复制完就释放掉了
    dispatch_queue_t timerQueue = dispatch_queue_create("timerQueue", 0);
     timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, timerQueue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.03 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"11111");
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"frame_change" object:nil];
        });
    });
    dispatch_resume(timer);
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(startMove:) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopMove
{
    dispatch_cancel(timer);
}

- (void)startMove:(NSTimer *)timer
{
}
#pragma mark--- lazy load
- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
        _backgroundImageView.image = [UIImage imageNamed:@"barrage"];
    }
    return _backgroundImageView;
}









@end
