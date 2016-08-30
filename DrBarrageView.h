//
//  DrBarrageView.h
//  Driver
//
//  Created by zhangyapeng on 16/8/29.
//  Copyright © 2016年 Driver. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    BarrageDirectionLeft,
    BarrageDirectionRight
}BarrageMoveDirection;

//设计弹幕
@interface DrBarrageView : UIView
@property (nonatomic, assign)BarrageMoveDirection  barrageDirection;

- (instancetype)initWithFrame:(CGRect)frame moveDirection:(BarrageMoveDirection)direction;
- (void)startTimer;
- (void)stopMove;


@end
