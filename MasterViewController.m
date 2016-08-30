//
//  MasterViewController.m
//  BarrageTest
//
//  Created by zhangyapeng on 16/8/30.
//  Copyright © 2016年 zhangyapeng. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "DrBarrageView.h"

#define BarrageHeight self.view.frame.size.height
#define BarrageWidth self.view.frame.size.width

@interface MasterViewController ()

@property NSMutableArray *objects;
@property (nonatomic, strong)DrBarrageView *barrageView;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.barrageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (DrBarrageView *)barrageView
{
    if (!_barrageView)
    {
        _barrageView = [[DrBarrageView alloc] initWithFrame:CGRectMake(10, 100, BarrageWidth-20, 260) moveDirection:BarrageDirectionRight];
    }
    return _barrageView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
