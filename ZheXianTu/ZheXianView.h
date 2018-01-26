//
//  ZheXianView.h
//  ZheXianTu
//
//  Created by caimengnan on 2018/1/22.
//  Copyright © 2018年 frameworkdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZheXianView : UIView

@property (nonatomic,strong) NSArray *monthArr;  //月份
@property (nonatomic,strong) NSArray *dataArr;  //数据  坐标轴内的阴影曲线数据

@property (nonatomic,strong) NSArray *dataArrWithNoShadow; //数据  坐标轴内的红色曲线数据

@property (nonatomic,strong) NSMutableArray *pointArray; //阴影曲线点的集合
@property (nonatomic,strong) NSMutableArray *pointArray2; //曲线点的集合

@property (nonatomic,assign) CGFloat monthDistance;
@property (nonatomic,assign) CGFloat dataHeight;
@property (nonatomic,assign) CGFloat xGap;
@property (nonatomic,assign) CGFloat yGap;
@property (nonatomic,assign) CGFloat maxY;
@property (nonatomic,assign) CGFloat minY;

@end
