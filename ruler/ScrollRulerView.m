//
//  ScrollRulerView.m
//  坐标系
//
//  Created by 严凯 on 2018/5/29.
//  Copyright © 2018年 优品互联网. All rights reserved.
//

#import "ScrollRulerView.h"
#define WIDTH  self.frame.size.width
#define HEIGHT self.frame.size.height
@interface ScrollRulerView()
{
    NSInteger _unitValue;
    NSInteger _maxValue;
    NSInteger _defaultValue;
    UIScrollView *_scrollView;
    UILabel * _centerLabel;
}

@end
static NSInteger const kW = 5;//间隔
static CGFloat const kW1 = 1;//刻度线的宽度
static NSInteger const kH1 = 8;//短线高度
static NSInteger const kH2 = 15;//长线高度
@implementation ScrollRulerView

- (instancetype)initWithFrame:(CGRect)frame Unit:(NSInteger)unitValue Max:(NSInteger)maxValue Defalt:(NSInteger)defaultValue block:(ValueBlock)block{
    if(self = [super initWithFrame:frame]){
        _unitValue = unitValue?unitValue:1000;
        _maxValue = maxValue?maxValue:300000;
        _defaultValue = defaultValue?defaultValue:0;
        NSCAssert(_defaultValue%_unitValue == 0, @"起始值必须是最小单位的倍数！");
        _block = block;
        _follow = NO;
        //添加scrollview
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _scrollView.contentSize = CGSizeMake(WIDTH+_maxValue/_unitValue*kW, HEIGHT);
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        //刻度view
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2, 0, _maxValue/_unitValue*kW, HEIGHT)];
        view.backgroundColor=[UIColor whiteColor];
        [_scrollView addSubview:view];
        //添加中间刻度
        _centerLabel =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-kW1, 10, kW1*2, HEIGHT-10)];
        _centerLabel.backgroundColor = UIColor.redColor;
        [self addSubview:_centerLabel];
        [self createXInView:view];
        //滑到默认值
        [_scrollView setContentOffset:CGPointMake(_defaultValue/_unitValue*kW, 0)];
    }
    return self;
}
#pragma mark - 设置
- (void)setCenterColor:(UIColor *)centerColor{
    _centerLabel.backgroundColor = centerColor;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_follow) {
        [self goWithScrollView:scrollView];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!_follow) {
        [self goWithScrollView:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (!_follow) {
        [self goWithScrollView:scrollView];
    }
}

- (void)goWithScrollView:(UIScrollView *)scrollView{
    float k =scrollView.contentOffset.x;
    CGFloat value = roundf((scrollView.contentOffset.x)/kW) *kW;
    long a = _maxValue/_unitValue;
    if (k>=0 && k<=a*kW) {
        _scrollView.contentOffset = CGPointMake(value,0);
        self.block((_scrollView.contentOffset.x)/kW*_unitValue);
    }
}

-(void)createXInView:(UIView *)view
{
    long b = _maxValue/_unitValue;
    //把前后的x轴填满
    CAShapeLayer*layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(-WIDTH/2, HEIGHT-10, (b+1)*kW+WIDTH, 1);
    layer.backgroundColor = [[UIColor lightGrayColor] CGColor];
    [view.layer addSublayer:layer];
    //x轴用到的部分
    CAShapeLayer*layer1 = [CAShapeLayer layer];
    layer1.frame = CGRectMake(0, HEIGHT-10, (b+1)*kW, 1);
    [view.layer addSublayer:layer1];
    //短线
    for (int i=0; i<b+1; i++)
    {
        CAShapeLayer *layer2 = [CAShapeLayer layer];
        layer2.frame = CGRectMake(i*kW, -kH1, kW1, kH1);
        layer2.backgroundColor = [UIColor lightGrayColor].CGColor;
        [layer1 addSublayer:layer2];
    }
    //长线
    long k = b/10;
    for (int i=0; i<k+1; i++)
    {
        CAShapeLayer *layer2 = [CAShapeLayer layer];
        layer2.frame = CGRectMake(i*kW*10, -kH2, kW1, kH2);
        layer2.backgroundColor = [UIColor lightGrayColor].CGColor;
        [layer1 addSublayer:layer2];
    }
    
   //x轴上的文字
    for (int i=0; i<k+1; i++) {
        CATextLayer *layer3 = [CATextLayer layer];
        layer3.frame = CGRectMake(i*kW*10-30, -(25+kH2), 60, 20);
        layer3.string = [NSString stringWithFormat:@"%ld",i*_unitValue*10];
        layer3.alignmentMode=kCAAlignmentCenter;
        layer3.fontSize = 10;
        layer3.contentsScale=2;
        layer3.foregroundColor = [UIColor lightGrayColor].CGColor;
        [layer1 addSublayer:layer3];
    }
}

@end
