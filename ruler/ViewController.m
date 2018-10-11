//
//  ViewController.m
//  ruler
//
//  Created by 严凯 on 2018/8/21.
//  Copyright © 2018年 严凯. All rights reserved.
//

#import "ViewController.h"
#import "ScrollRulerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 30)];
    [self.view addSubview:label];
    
    ScrollRulerView *ruler = [[ScrollRulerView alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 100) Unit:100 Max:20000 Defalt:1000 block:^(NSInteger value) {
        label.text = [NSString stringWithFormat:@"滑到%ld了",value];
    }];
    ruler.follow = YES;//同步变化
    [self.view addSubview:ruler];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
