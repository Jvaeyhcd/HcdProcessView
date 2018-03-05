//
//  ViewController.m
//  HcdProcessViewDemo
//
//  Created by polesapp-hcd on 16/9/10.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

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
    customView.amplitude = self.view.frame.size.width * 0.8 / 8;
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView.contentMode = UIViewContentModeScaleToFill;
    bgImageView.image = [UIImage imageNamed:@"charging_pic_bg"];
    
    [self.view addSubview:bgImageView];
    [self.view addSubview:customView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
