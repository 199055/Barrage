//
//  DrBarrageItem.m
//  Driver
//
//  Created by zhangyapeng on 16/8/29.
//  Copyright © 2016年 Driver. All rights reserved.
//

#import "DrBarrageItem.h"
#import "DrBarragePieceView.h"
#define BarrageHeight self.frame.size.height

@interface DrBarrageItem ()

@property (nonatomic, strong)UIImageView *headerImageV;
@property (nonatomic, strong)UILabel     *contentLabel;
@property (nonatomic, assign)BOOL isAllShow;//全部呈现出来
@property (nonatomic, copy)NSString *noName;
@end

@implementation DrBarrageItem

- (instancetype)initWithFrame:(CGRect)frame withData:(NSDictionary *)dic noficationName:(NSString *)noName
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isAllShow = NO;
        self.noName = noName;
        self.backgroundColor = [UIColor blackColor];
        self.layer.cornerRadius = 14;
        self.layer.masksToBounds = YES;
        self.alpha = 0.8;
        
        self.contentLabel.text = [dic objectForKey:@"content"];
        self.headerImageV.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFrame:) name:@"frame_change" object:nil];
        [self addSubview:self.headerImageV];
        [self addSubview:self.contentLabel];
        [self setNeedsLayout];
    }
    return self;
}

//- (void)
#pragma mark--- 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headerImageV.frame = CGRectMake(2, 2,BarrageHeight-4, BarrageHeight-4);
    CGSize size = [self getSizeWithText:self.contentLabel.text andFontSize:14];
    self.contentLabel.frame = CGRectMake(BarrageHeight+ 6, 0, size.width, BarrageHeight);
    CGRect rect = self.frame;
    DrBarragePieceView *pieceView =(DrBarragePieceView *)self.superview;
    NSInteger dixtanceX = arc4random() % 20;
    if (pieceView.direction == BarrageDirectionLeft)
    {
        self.frame = CGRectMake(-(BarrageHeight + 20 + size.width + dixtanceX), rect.origin.y, BarrageHeight + 20 + size.width, rect.size.height);
 
    }else if (pieceView.direction == BarrageDirectionRight)
    {
        self.frame = CGRectMake(pieceView.frame.size.width+dixtanceX+20, rect.origin.y, BarrageHeight + 20+ size.width, rect.size.height);
    }
}

#pragma mark--- 通知方法
- (void)changeFrame:(NSNotification *)no
{
    DrBarragePieceView *pieceView =(DrBarragePieceView *)self.superview;
    CGRect rect = self.frame;
    if (pieceView.direction == BarrageDirectionLeft)
    {
        rect.origin.x += 1;
        self.frame = rect;
         if(rect.origin.x >= pieceView.frame.size.width + 10)
        {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            [self removeFromSuperview];
        } else if (rect.origin.x > 10)
        {
            if (self.isAllShow == NO)
            {
                NSInteger time = arc4random() % 3;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:self.noName object:nil];
                });
                self.isAllShow = YES;
            }
        }

    }else if (pieceView.direction == BarrageDirectionRight)
    {
        rect.origin.x-= 1;
        self.frame = rect;
         if(-rect.origin.x > rect.size.width + 10)
        {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            [self removeFromSuperview];
        }else if (pieceView.frame.size.width - rect.origin.x > rect.size.width + 15)
        {
            if (self.isAllShow == NO)
            {
                NSInteger time = arc4random() % 3;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:self.noName object:nil];
                });
                self.isAllShow = YES;
            }
        }
    }
}

- (CGSize)getSizeWithText:(NSString *)text andFontSize:(CGFloat)size{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size], NSParagraphStyleAttributeName:paragraphStyle}
                              context:nil].size;
}


#pragma mark --- lazy load
- (UIImageView *)headerImageV
{
    if (!_headerImageV) {
        _headerImageV = [[UIImageView alloc] init];
        _headerImageV.contentMode = UIViewContentModeScaleToFill;
        _headerImageV.layer.cornerRadius = (BarrageHeight-2)/2;
        _headerImageV.layer.masksToBounds = YES;
    }
    return _headerImageV;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}








@end
