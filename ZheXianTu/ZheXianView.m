//
//  ZheXianView.m
//  ZheXianTu
//
//  Created by caimengnan on 2018/1/22.
//  Copyright © 2018年 frameworkdemo. All rights reserved.
//

#import "ZheXianView.h"
#import "TDYView.h"
#import "BackgroundView.h"
#import <Masonry.h>

//y坐标轴的宽度，也是标注的宽度
#define Y_PADDING_WIDTH 50

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth [UIScreen mainScreen].bounds.size.width

//分成几份
#define each 8


@implementation ZheXianView
{
    UIScrollView *scrollView;
    BackgroundView *backView;
    CGFloat point_x;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    
    return self;
}



- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {

    }
    
    return self;
}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
}

- (void)setdataArrWithNoShadow:(NSArray *)dataArrWithNoShadow {
    _dataArrWithNoShadow = dataArrWithNoShadow;
}

- (void)setMonthArr:(NSArray *)monthArr {
    
    _monthArr = monthArr;
    
    [self addSubViews];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    scrollView.contentSize = CGSizeMake(point_x, self.frame.size.height);
    backView.frame = CGRectMake(0, 0,point_x, self.frame.size.height);
    
}

#pragma mark 初始化布局  添加左边Y轴视图
- (void)addSubViews {
    
    CGFloat superHeight = self.frame.size.height;
    
    //左边Y
    TDYView *tdView = [[TDYView alloc] initWithFrame:CGRectMake(0, 0, Y_PADDING_WIDTH, superHeight - 40)];
    
    //传入阴影曲线数据
    tdView.dataArray = self.dataArr;
    
    [self addSubview:tdView];
    
    //右边Y
    TDYView *rightView = [[TDYView alloc] initWithFrame:CGRectMake(0, 0, Y_PADDING_WIDTH, superHeight - 40)];
    
    //传入非阴影曲线数据
    rightView.dataArray = self.dataArrWithNoShadow;
    
    [self addSubview:rightView];
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 60, [UIScreen mainScreen].bounds.size.width-60, superHeight)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = YES;

    scrollView.backgroundColor = [UIColor whiteColor];
    
    CGFloat distance = kWidth - Y_PADDING_WIDTH;
    point_x = ((kWidth-Y_PADDING_WIDTH*2)/each) * self.monthArr.count < distance ? distance : (((kWidth-Y_PADDING_WIDTH*2)/each) * self.monthArr.count);
    
    backView = [[BackgroundView alloc] initWithFrame:CGRectMake(0, 0, point_x, superHeight)];
    
    backView.backgroundColor = [UIColor clearColor];
    
    backView.dataArr = self.dataArr;
    backView.xArr = self.monthArr;
    backView.dataArrWithNoShadow = self.dataArrWithNoShadow;
    
    [backView addLabels];
    
    [self addSubview:scrollView];
    [scrollView addSubview:backView];
    
    [tdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-25);
        make.width.mas_equalTo(Y_PADDING_WIDTH);
    }];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-25);
        make.width.mas_equalTo(Y_PADDING_WIDTH);
    }];
    
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(Y_PADDING_WIDTH);
        make.right.equalTo(self).offset(-Y_PADDING_WIDTH);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
//    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(scrollView.mas_left);
//        make.top.equalTo(self);
//        make.right.equalTo(self);
//        make.bottom.equalTo(self);
//    }];
    
    
    
}











/*
#pragma mark 设置曲线阴影动画
- (void)setLineShadowAnimationWithLayer:(CAShapeLayer *)shapeLayer Time:(CGFloat)time {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(self.xGap, 0, 0, self.monthDistance * self.dataArr.count);
    
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:138/255.0 green:198/255.0 blue:19/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:138/255.0 green:198/255.0 blue:19/255.0 alpha:1.0].CGColor];
//    gradientLayer.locations = @[@(0.5f)];
    
    if (baseLayer) {
        [baseLayer removeFromSuperlayer];
    }
    baseLayer = [CALayer layer];
    [baseLayer addSublayer:gradientLayer];
    [baseLayer setMask:shapeLayer];
    [self.layer addSublayer:baseLayer];
    
    CABasicAnimation *animo = [CABasicAnimation animation];
    animo.keyPath = @"bounds";
    animo.duration = time;
    animo.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.xGap + self.monthDistance * self.monthArr.count, self.yGap + self.dataHeight - 5)];
    animo.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animo.fillMode = kCAFillModeForwards;
    animo.autoreverses = NO;
    animo.removedOnCompletion = NO;
    [gradientLayer addAnimation:animo forKey:@"bounds"];
    
}
*/


@end
