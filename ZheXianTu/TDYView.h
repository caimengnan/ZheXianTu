//
//  TDYView.h
//  ZheXianTu
//
//  Created by caimengnan on 2018/1/24.
//  Copyright © 2018年 frameworkdemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDYView : UIView

//Y轴数据数组
@property (nonatomic,strong) NSArray *dataArray;  //接收曲线数据(传入阴影数据显示的就是对应的y轴标注，传入非阴影数据显示的就是非阴影数据对应y轴标注)
- (void)addLabel;
@end
