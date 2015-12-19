//
//  ViewController.m
//  LMSectionScrollView
//
//  Created by Kun Wang on 15/12/19.
//  Copyright © 2015年 luckymore. All rights reserved.
//

#import "ViewController.h"
#import "LMSectionScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *firstView = [[UIView alloc] init];
    firstView.backgroundColor = [UIColor greenColor];
    
    
    UIView *secondView = [[UIView alloc] init];
    secondView.backgroundColor = [UIColor redColor];
    
    UIView *thirdView = [[UIView alloc] init];
    thirdView.backgroundColor = [UIColor purpleColor];
    
    LMSectionScrollView *sectionScrollView = [[LMSectionScrollView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 200, [UIScreen mainScreen].bounds.size.width, 200)];
    [sectionScrollView buildViewWithViews:@[firstView,secondView,thirdView] sectionNameArray:@[@"1",@"22",@"333"]];
    [self.view addSubview: sectionScrollView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
