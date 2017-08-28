//
//  ViewController.m
//  XYXButtonScrollerView
//
//  Created by Teresa on 2017/8/28.
//  Copyright © 2017年 Teresa. All rights reserved.
//

#import "ViewController.h"
#import "XYXButtonScrollerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XYXButtonScrollerView *theView = [XYXButtonScrollerView new];
    [self.view addSubview:theView];
    
    theView.titles = @[@"按钮1按钮1",@"按钮2",@"按钮3按钮3",@"按钮4",@"按钮5",@"按钮6",@"按钮7",@"按钮8",@"按钮9",@"按钮10"];
    theView.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
