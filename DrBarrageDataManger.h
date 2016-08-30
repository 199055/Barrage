//
//  DrBarrageDataManger.h
//  Driver
//
//  Created by zhangyapeng on 16/8/30.
//  Copyright © 2016年 Driver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrBarrageDataManger : NSObject

+ (instancetype)shareBarrageManger;
- (NSDictionary *)getNewItemData;
@end
