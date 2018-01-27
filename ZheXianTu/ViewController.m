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
    
    ZheXianView *zhexianView = [[ZheXianView alloc]initWithFrame:CGRectMake(0, 200, kWidth, 300)];
    zhexianView.dataArr =  @[@"0.0",
                             @"0.0",
                             @"225.0",
                             @"270.0",
                             @"520.0",
                             @"0.0",
                             @"0.0",
                             @"225.0",
                             @"270.0",
                             @"520.0"
                             ];
    //阴影曲线数据
    zhexianView.dataArrWithNoShadow = @[@"1.5",
                                        @"2.1",
                                        @"2.1",
                                        @"5.6",
                                        @"4.4",
                                        @"1.5",
                                        @"2.1",
                                        @"2.1",
                                        @"5.6",
                                        @"4.4"
                                        ];  //无阴影曲线数据
    
    zhexianView.monthArr = @[@6,
                             @7,
                             @8,
                             @9,
                             @10,
                             @6,
                             @7,
                             @8,
                             @9,
                             @10
                             ];  //x轴数值
    [self.view addSubview:zhexianView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
