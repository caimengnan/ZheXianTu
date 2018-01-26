//
//  TDYView.m
//  ZheXianTu
//
//  Created by caimengnan on 2018/1/24.
//  Copyright © 2018年 frameworkdemo. All rights reserved.
//

#import "TDYView.h"
#import <Masonry.h>

@interface TDYView()

@property (nonatomic,assign) CGFloat paddingValue; //间隔值
@property (nonatomic,assign) CGFloat defaultValue; //起始默认值

@end

@implementation TDYView


#pragma mark 初始化
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    //找出曲线数组中的最大最小值
    NSMutableArray *newArray = [NSMutableArray array];
    for (int i = 0; i < _dataArray.count; i++) {
        NSString *stringValue = [NSString stringWithFormat:@"%@",_dataArray[i]];
        CGFloat value = [stringValue floatValue];
        [newArray addObject:[NSNumber numberWithFloat:value]];
    }
    
    //找出最大值 最小值
    CGFloat maxValue = [[newArray valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat minValue = [[newArray valueForKeyPath:@"@min.floatValue"] floatValue];
    
    //标签间的上下间距
    self.paddingValue = (maxValue - minValue)/4.0;
    
    //
    
    //最小值即为默认值
    self.defaultValue = minValue;
    
    
    //y轴标注数据数组
//    NSMutableArray *yDataArr = [NSMutableArray array];
//    for (int i = 0; i < 6; i++) {
//        [yDataArr addObject:[NSNumber numberWithFloat:minValue + 1*self.paddingValue]];
//    }
    
    [self addLabel];
}



#pragma mark 初始化布局 添加Y轴上的标签
- (void)addLabel {
    
    for (int i = 0; i < 5; i++) {
        UILabel *label = [[UILabel alloc] init];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
        label.text = [NSString stringWithFormat:@"%.0f",self.defaultValue];
        label.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:label];
        self.defaultValue+=self.paddingValue;
        
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.mas_equalTo(30);
            make.bottom.equalTo(self).offset(-((i * 18)+25));
        }];
        
        
    }

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
