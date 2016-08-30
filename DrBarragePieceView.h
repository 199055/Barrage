//
//  DrBarragePieceView.h
//  Driver
//
//  Created by zhangyapeng on 16/8/29.
//  Copyright © 2016年 Driver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrBarrageView.h"
@interface DrBarragePieceView : UIView

- (instancetype)initWithFrame:(CGRect)frame direction:(BarrageMoveDirection)direction noficationName:(NSString *)noName;
@property (nonatomic, assign)BarrageMoveDirection direction;
@property (nonatomic, copy)NSString *noName;


@end
