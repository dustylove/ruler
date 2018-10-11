//
//  ScrollRulerView.h
//  坐标系
//
//  Created by 严凯 on 2018/5/29.
//  Copyright © 2018年 优品互联网. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ValueBlock)(NSInteger value);
@interface ScrollRulerView : UIView<UIScrollViewDelegate>
@property(nonatomic, copy) ValueBlock block;
@property(nonatomic, strong) UIColor *centerColor;
/**同步跟随变化，默认为NO*/
@property(nonatomic, assign) BOOL follow;

/**
 刻度尺生成方法

 @param frame frame
 @param unitValue 单位值
 @param maxValue 最大值，可以除以（单位值的10倍）
 @param defaultValue 默认值（单位值的倍数）
 @param block 返回滑动到的数值
 @return rluerview
 */
- (instancetype)initWithFrame:(CGRect)frame Unit:(NSInteger)unitValue Max:(NSInteger)maxValue Defalt:(NSInteger)defaultValue block:(ValueBlock)block;

@end
