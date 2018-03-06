//
//  ViewController.m
//  HcdProcessViewDemo
//
//  Created by polesapp-hcd on 16/9/10.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#define SCREENWIDTH self.view.frame.size.width

#import "ViewController.h"
#import "HcdProcessView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    HcdProcessView *customView = [[HcdProcessView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.1, 70, self.view.frame.size.width * 0.8, self.view.frame.size.width * 0.8)];
    customView.percent = 0.6;
    customView.showBgLineView = YES;
    customView.waveLength = self.view.frame.size.width;
    customView.amplitude = self.view.frame.size.width * 0.8 / 20;
    customView.showBgLineView = NO;
    customView.waterBgColor = [UIColor colorWithRed:0.718 green:0.890 blue:0.988 alpha:1.00];
    customView.lineBgColor = [UIColor colorWithRed:0.749 green:0.910 blue:0.984 alpha:1.00];
    customView.scaleColor = [UIColor colorWithRed:0.969 green:0.937 blue:0.227 alpha:1.00];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake((SCREENWIDTH - 150) / 2, self.view.frame.size.width * 0.8 + 100, 150, 20)];
    slider.minimumValue = 9;// 设置最小值
    slider.maximumValue = 11;// 设置最大值
    slider.value = (slider.minimumValue + slider.maximumValue) / 2;// 设置初始值
    slider.continuous = YES;// 设置可连续变化
    slider.minimumTrackTintColor = [UIColor greenColor]; //滑轮左边颜色，如果设置了左边的图片就不会显示
    slider.maximumTrackTintColor = [UIColor redColor]; //滑轮右边颜色，如果设置了右边的图片就不会显示
    slider.thumbTintColor = [UIColor redColor];//设置了滑轮的颜色，如果设置了滑轮的样式图片就不会显示
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
    
    self.view.backgroundColor = [UIColor colorWithRed:0.165 green:0.659 blue:0.980 alpha:1.00];
    [self.view addSubview:customView];
    [self.view addSubview:slider];
}

- (void)sliderValueChanged: (UISlider *)slider {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
