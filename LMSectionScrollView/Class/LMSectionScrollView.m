//
//  HWSectionScrollView.m
//  HWSectionScrollView
//
//  Created by Kun Wang on 15/12/19.
//  Copyright © 2015年 luckymore. All rights reserved.
//

#import "LMSectionScrollView.h"
#import "UIView+LMSectionScrollView.h"
#import "UILabel+LMSectionScrollView.h"


#define kSectionButtonTag 1218

const CGFloat kSectionScrollViewHeight = 60;
const CGFloat kSectionScrollViewBottomMargin = 20;
const CGFloat kSectionButtonPadding = 0;

@interface LMSectionScrollView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *rootScrollView;
@property (nonatomic, strong) UIScrollView *sectionScrollView;
@property (nonatomic, strong) NSArray *sectionButtonArray;
@property (nonatomic, strong) NSArray *rootViewArray;
@end

@implementation LMSectionScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sectionSelectedColor = [UIColor blackColor];
        self.sectionUnselectedColor = [UIColor lightGrayColor];
        self.sectionViewWidth = [UIScreen mainScreen].bounds.size.width / 1.5;
        self.selectedIndex = 2;
        [self initView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _rootScrollView.frame = self.bounds;
    _sectionScrollView.frame = CGRectMake((self.width - _sectionViewWidth) / 2.0, self.height - kSectionScrollViewHeight - kSectionScrollViewBottomMargin, _sectionViewWidth , kSectionScrollViewHeight);
    for (int i = 0 ; i < self.rootViewArray.count; i++) {
        CGRect rootViewFrame = CGRectMake(_rootScrollView.width * i, 0, _rootScrollView.width, _rootScrollView.height);
        [self.rootViewArray[i] setFrame:rootViewFrame];
        UIButton *currentButton = self.sectionButtonArray[i];
        UILabel *titleLabel = currentButton.titleLabel;
        CGFloat buttonWidth = MAX([titleLabel getMinWidth] + kSectionButtonPadding, self.sectionViewWidth / 3.0);
        CGRect buttonFrame;
        if (i == 0) {
            buttonFrame = CGRectMake(0, 0, buttonWidth, kSectionScrollViewHeight);
        } else {
            UIButton *lastButton = self.sectionButtonArray[i-1];
            buttonFrame = CGRectMake(lastButton.right, 0, buttonWidth, kSectionScrollViewHeight);
        }
        [self.sectionButtonArray[i] setFrame:buttonFrame];
    }
    _rootScrollView.contentSize = CGSizeMake(_rootScrollView.width * self.rootViewArray.count, _rootScrollView.height);
    [self setSelectedIndex:_selectedIndex animated:NO];
}


- (void)initView {
    _rootScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:_rootScrollView];
    
    _sectionScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((self.width - _sectionViewWidth) / 2.0 , self.height - kSectionScrollViewHeight, _sectionViewWidth, kSectionScrollViewHeight)];
    _sectionScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:_sectionScrollView];
}

- (void)buildViewWithNibNames:(NSArray *)viewNibNames sectionNameArray:(NSArray *)nameArray {
    NSMutableArray *viewsArray = [[NSMutableArray alloc] initWithCapacity:viewNibNames.count];
    for (NSString *name in viewNibNames) {
        [viewsArray addObject:[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil][0]];
    }
    [self buildViewWithViews:viewsArray sectionNameArray:nameArray];
}

- (void)buildViewWithViews:(NSArray *)views sectionNameArray:(NSArray *)nameArray {
    self.rootViewArray = views;
    NSMutableArray *buttonArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < views.count; i++) {
        UIView *view = views[i];
        [_rootScrollView addSubview:view];
        UIButton *button = [self createButtonWithName:nameArray[i]];
        button.clipsToBounds = NO;
        button.tag = kSectionButtonTag + i;
        [_sectionScrollView addSubview:button];
        [buttonArray addObject:button];
    }
    self.sectionButtonArray = buttonArray;
    _rootScrollView.contentSize = CGSizeMake(_rootScrollView.width * views.count, _rootScrollView.height);
    _sectionScrollView.contentSize = CGSizeMake(_sectionScrollView.width * views.count / 3.0, _sectionScrollView.height);
    [self layoutSubviews];
}

- (UIButton *)createButtonWithName:(NSString *)buttonName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:buttonName forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button setTitleColor:self.sectionSelectedColor forState:UIControlStateNormal];
    [button setTitleColor:self.sectionUnselectedColor forState:UIControlStateSelected];
    [button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self setSelectedIndex:selectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated {
    _selectedIndex = selectedIndex;
    for (UIButton *button in self.sectionButtonArray) {
        [button setSelected:NO];
    }
    [_rootScrollView setContentOffset:CGPointMake(self.rootScrollView.width * self.selectedIndex, 0) animated:animated];
    UIButton *selectedButton = self.sectionButtonArray[self.selectedIndex];
    [selectedButton setSelected:YES];
    [_sectionScrollView setContentOffset:CGPointMake( selectedButton.center.x - _sectionViewWidth / 2.0  , 0) animated:animated];
}

- (void)onButtonClicked:(UIButton *)button {
    if (button.selected) {
        return;
    }
    [self setSelectedIndex:button.tag - kSectionButtonTag animated:YES];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    NSInteger targetSelectedIndex = (scrollView.contentOffset.x / scrollView.width);
    UIButton *selectedButton = self.sectionButtonArray[self.selectedIndex];
    UIButton *targetSelectedButton;
    if (targetSelectedIndex == self.selectedIndex && self.selectedIndex + 1 < self.sectionButtonArray.count) {
        //drag right
        targetSelectedButton = self.sectionButtonArray[self.selectedIndex + 1];
        NSLog(@"drag right");
        CGFloat contentOffsetXOffset = contentOffsetX - scrollView.width * self.selectedIndex;
        CGFloat percent = contentOffsetXOffset / scrollView.width;
        CGFloat totalOffset = targetSelectedButton.center.x - selectedButton.center.x;
        [_sectionScrollView setContentOffset:CGPointMake(selectedButton.center.x - _sectionViewWidth / 2.0 + totalOffset * percent, 0) animated:NO];
    } else if (self.selectedIndex > 0){
        //drag left
        targetSelectedButton = self.sectionButtonArray[self.selectedIndex - 1];
        NSLog(@"drag left");
        CGFloat contentOffsetXOffset = contentOffsetX - scrollView.width * self.selectedIndex;
        CGFloat percent = contentOffsetXOffset / scrollView.width;
        CGFloat totalOffset = targetSelectedButton.center.x - selectedButton.center.x;
        [_sectionScrollView setContentOffset:CGPointMake(selectedButton.center.x - _sectionViewWidth / 2.0 - totalOffset * percent, 0) animated:NO];
    } else {
        return;
    }
  
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger selectedIndex = (scrollView.contentOffset.x / scrollView.width);
    [self setSelectedIndex:selectedIndex animated:NO];
}




@end
