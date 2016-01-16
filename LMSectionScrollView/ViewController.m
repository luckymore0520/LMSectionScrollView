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
@property (nonatomic,strong) LMSectionScrollView *sectionScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *firstView = [self mockViewWithText:@"page 1"];
    UIView *secondView = [self mockViewWithText:@"page 2"];
    UIView *thirdView = [self mockViewWithText:@"page 3"];
    LMSectionScrollView *sectionScrollView = [[LMSectionScrollView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 200, [UIScreen mainScreen].bounds.size.width, 200)];
    [sectionScrollView buildViewWithViews:@[firstView,secondView,thirdView] sectionNameArray:@[@"page 1",@"page 2",@"page 3"]];
    	
    [self.view addSubview: sectionScrollView];
    self.sectionScrollView = sectionScrollView;
    // Do any additional setup after loading the view, typically from a nib.
}


- (UIView *)mockViewWithText:(NSString *)text {
    UIView *mockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    mockView.backgroundColor = [UIColor colorWithRed:187/255.0	 green:1 blue:1 alpha:1.0];
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    [mockView addSubview:label];
    label.center = mockView.center;
    return mockView;
}

- (IBAction)onChangeUnselectedColorButtonClicked:(id)sender {
    [self.sectionScrollView setSectionUnselectedColor:[self randomColor]];
}

- (IBAction)onChangeSelectedColorButtonClicked:(id)sender {
    [self.sectionScrollView setSectionSelectedColor:[self randomColor]];
}

- (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random() % 255 / 255.0
                           green:arc4random() % 255 / 255.0
                            blue:arc4random() % 255 / 255.0
                           alpha:arc4random() % 255 / 255.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
