//
//  ViewController.m
//  ZheXianTu
//
//  Created by caimengnan on 2018/1/22.
//  Copyright © 2018年 frameworkdemo. All rights reserved.
//

#import "ViewController.h"
#import "ZheXianView.h"

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZheXianView *zhexianView = [[ZheXianView alloc]initWithFrame:CGRectMake(0, 200, kWidth, kHeight/4 - 20)];
    zhexianView.dataArr =  @[@"0.0",
                             @"0.0",
                             @"225.0",
                             @"270.0",
                             @"520.0",
                             @"596.0",
                             @"558.0",
                             @"619.0",
                             @"505.0",
                             @"343.0",
                             @"184.0",
                             @"137.0",
                             @"113.0",
                             @"113.0"];
    //无阴影曲线数据 
    zhexianView.dataArrWithNoShadow = @[@"0.0",
                                        @"0.0",
                                        @"0.0",
                                        @"0.1",
                                        @"0.3",
                                        @"0.7",
                                        @"1.1",
                                        @"1.5",
                                        @"1.9",
                                        @"2.1",
                                        @"2.1",
                                        @"2.2",
                                        @"2.2",
                                        @"2.2",];  //无阴影曲线数据
    
    zhexianView.monthArr = @[@6,
                             @7,
                             @8,
                             @9,
                             @10,
                             @11,
                             @12,
                             @13,
                             @14,
                             @15,
                             @16,
                             @17,
                             @18,
                             @19];  //x轴数值
    [self.view addSubview:zhexianView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
