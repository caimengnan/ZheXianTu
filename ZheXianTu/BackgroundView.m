//
//  BackgroundView.m
//  ZheXianTu
//
//  Created by caimengnan on 2018/1/24.
//  Copyright © 2018年 frameworkdemo. All rights reserved.
//

#import "BackgroundView.h"
#import <Masonry.h>

//y坐标轴的宽度，也是标注的宽度
#define Y_PADDING_WIDTH 50

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth [UIScreen mainScreen].bounds.size.width

//x轴 整个frame.size.width 分成几份
#define each 8

//y轴 分成几份
#define eachY 5

@implementation BackgroundView
{
    CALayer *baseLayer;
    CGFloat max;
    CGFloat otherMax;
    
    CGFloat min;
    CGFloat otherMin;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
//        [self setDetaultValues];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
//        [self setDetaultValues];
    }

    return self;
}



- (void)addLabels {
    
    self.xGap = (kWidth - Y_PADDING_WIDTH * 2) / each;
    self.yGap = 0;

    self.dataHeight = self.frame.size.height - 40;
    self.monthDistance = self.dataHeight /eachY;
    
    //x轴标注
    for (int i = 0; i < self.xArr.count; i++) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = [NSString stringWithFormat:@"%@",self.xArr[i]];
        lab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        lab.font = [UIFont systemFontOfSize:10.0];
        [self addSubview:lab];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-10);
            make.left.equalTo(self).offset(i * self.xGap);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(self.xGap);
        }];
        
    }
    
    //找出有阴影曲线数组中的最大最小值
    NSMutableArray *newArray = [NSMutableArray array];
    for (int i = 0; i < self.dataArr.count; i++) {
        NSString *stringValue = [NSString stringWithFormat:@"%@",self.dataArr[i]];
        CGFloat value = [stringValue floatValue];
        [newArray addObject:[NSNumber numberWithFloat:value]];
    }
    
    //找出最大值 最小值
    CGFloat maxValue = [[newArray valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat minValue = [[newArray valueForKeyPath:@"@min.floatValue"] floatValue];
    max = maxValue;
    min = minValue;
    
    //找出非阴影曲线数组中的最大值和最小值
    NSMutableArray *newArrayOther = [NSMutableArray array];
    for (int i = 0; i < self.dataArrWithNoShadow.count; i++) {
        NSString *stringValue = [NSString stringWithFormat:@"%@",self.dataArrWithNoShadow[i]];
        CGFloat value = [stringValue floatValue];
        [newArrayOther addObject:[NSNumber numberWithFloat:value]];
    }
    
    CGFloat otherMaxValue = [[newArrayOther valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat otherMinValue = [[newArrayOther valueForKeyPath:@"@min.floatValue"] floatValue];
    otherMax = otherMaxValue;
    otherMin = otherMinValue;
    
}




#pragma mark 画图 x轴
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取画图工具
    UIGraphicsPushContext(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0].CGColor); //填充颜色
    CGContextSetLineWidth(ctx, 1);
    
    //画坐标轴
    //x轴
//    CGPoint pointx = CGPointMake(0, self.dataHeight);
//    CGPoint pointx2 = CGPointMake(self.xArr.count * self.xGap, self.dataHeight);
//    CGContextMoveToPoint(ctx, pointx.x, pointx.y);
//    CGContextAddLineToPoint(ctx, pointx2.x, pointx2.y);
//    CGContextStrokePath(ctx);
    
    
    //画x轴上的分割点
    for (int i = 0; i < self.xArr.count + 1; i++) {
        CGContextAddArc(ctx,i*self.xGap, self.dataHeight, 1.5, 0, M_PI*2, 0);
        CGContextSetRGBFillColor(ctx, 0, 0, 1, 0.5);
        CGContextDrawPath(ctx, kCGPathEOFillStroke);
    }
    
    self.minY = self.dataHeight;
    self.maxY = self.minY - 4 * self.monthDistance;
    
    
    //添加折线
    [self setStackZheXian];
}

#pragma mark 设置阴影曲线
- (void)setStackZheXian {
    
    self.pointArray = [NSMutableArray arrayWithCapacity:0];
    self.pointArray2 = [NSMutableArray arrayWithCapacity:0];
    
    //先画阴影曲线
    //先往数组中添加起始点，阴影区域的起点应在x轴右边，这样对应其上方的点连接成的曲线图形才能封闭。
    [self.pointArray addObject:NSStringFromCGPoint(CGPointMake((_dataArr.count - 1) * self.xGap + self.xGap/2, self.minY))];
    //再往数组中添加“原点”坐标，即xy轴的起始点坐标。
    [self.pointArray addObject:NSStringFromCGPoint(CGPointMake(0, self.minY))];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext(); //获取画图工具
    UIGraphicsPushContext(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.5].CGColor); //填充颜色
    CGContextSetLineWidth(ctx, 1); //设置线宽
    CGPoint nextPoint = CGPointMake(0,self.dataHeight);
    
    //坐标内的点 阴影曲线
    for (int i = 0; i < _dataArr.count; i++) {
        
        CGFloat yValue = [_dataArr[i] floatValue];
        
        CGFloat innerGrade = self.minY - (self.minY - self.maxY)*((yValue-min)/(max - min));
        
        nextPoint = CGPointMake(self.xGap / 2.0 + i * self.xGap, innerGrade);
        
        [self.pointArray addObject:NSStringFromCGPoint(nextPoint)];
        
    }
    
    
    //连接坐标内的点，并填充颜色
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointFromString(_pointArray[0])];
    
    [path addLineToPoint:CGPointMake(0, self.dataHeight)];
    
    for (int i = 1; i < _pointArray.count; i++) {
        if (i != 1) {
            CGPoint nowPoint = CGPointFromString(_pointArray[i]);
            CGPoint oldPoint = CGPointFromString(_pointArray[i-1]);
            [path addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+oldPoint.x)/2.0, oldPoint.y) controlPoint2:CGPointMake((nowPoint.x+oldPoint.x)/2.0, nowPoint.y)];
        }
    }
    
    //添加阴影
    CAShapeLayer *lineLay = [CAShapeLayer new];
    lineLay.path = path.CGPath;
    lineLay.lineWidth = 1;
    lineLay.lineJoin = kCALineJoinRound;
    lineLay.lineJoin = kCALineCapRound;
    lineLay.strokeColor = [UIColor colorWithRed:138/255.0 green:198/255.0 blue:19/255.0 alpha:1.0].CGColor;
    
    lineLay.fillColor = [UIColor colorWithRed:138/255.0 green:198/255.0 blue:19/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:lineLay];
    
    //设置阴影动画
    //    [self setLineShadowAnimationWithLayer:lineLay Time:4.0];
    
    //画每条横线
    for (int i = 1; i < 5; i++) {
        //左边y轴上的点
        CGPoint point = CGPointMake(0, self.dataHeight - i * self.monthDistance);
        
        //右边y轴上的点
        CGPoint point2 = CGPointMake(self.xGap * self.xArr.count, point.y);
        
        CGContextMoveToPoint(ctx, point.x, point.y);
        CGContextAddLineToPoint(ctx, point2.x, point2.y);
        CGContextStrokePath(ctx);
        CGContextSetLineWidth(ctx, 1);
    }
    
    [self setOtherLine];
}

#pragma mark 设置无阴影曲线
- (void)setOtherLine {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetLineWidth(ctx, 1);
    CGPoint nextPoint = CGPointMake(0,self.dataHeight);
    
    //坐标内的点
    for (int i = 0; i < _dataArrWithNoShadow.count; i++) {
        CGFloat yValue = [_dataArrWithNoShadow[i] floatValue];
        CGFloat innerGrade = self.minY - (self.minY - self.maxY)*((yValue-otherMin)/(otherMax - otherMin));  //相对值
        nextPoint = CGPointMake(self.xGap / 2.0 + i * self.xGap, innerGrade);
        
        [self.pointArray2 addObject:NSStringFromCGPoint(nextPoint)];
    }
    
    
    //连接点
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.dataHeight)];
    
    for (int i = 0; i < self.pointArray2.count; i++) {
        if (i != 0) {
            CGPoint nowPoint = CGPointFromString(self.pointArray2[i]);
            CGPoint oldPoint = CGPointFromString(self.pointArray2[i-1]);
            [path addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+oldPoint.x)/2.0, oldPoint.y) controlPoint2:CGPointMake((nowPoint.x+oldPoint.x)/2.0, nowPoint.y)];
        }
    }
    
    CAShapeLayer *lineLay = [CAShapeLayer new];
    lineLay.path = path.CGPath;
    lineLay.lineWidth = 1;
    lineLay.strokeColor = [UIColor redColor].CGColor;
    lineLay.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:lineLay];
    
    
    [self setAnimationWithShapeLay:lineLay Time:2.0];
    
}

#pragma mark 设置曲线动画
- (void)setAnimationWithShapeLay:(CAShapeLayer *)layer Time:(CGFloat)duration {
    //给layer添加动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    pathAnimation.duration = duration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    [layer addAnimation:pathAnimation forKey:nil];
}


@end
