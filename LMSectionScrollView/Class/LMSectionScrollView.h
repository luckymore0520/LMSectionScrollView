//
//  HWSectionScrollView.h
//  HWSectionScrollView
//
//  Created by Kun Wang on 15/12/19.
//  Copyright © 2015年 luckymore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LMSectionScrollView : UIView
/**
 *  the index of the section which is selected and shown
 */
@property (nonatomic, assign) NSUInteger selectedIndex;
/**
 *  the color of the section button when selected
 */
@property (nonatomic, strong) UIColor *sectionSelectedColor;
/**
 *  the color of the section button when unselected
 */
@property (nonatomic, strong) UIColor *sectionUnselectedColor;
/**
 *  the width of sectionView you prefer
 */
@property (nonatomic, assign) CGFloat sectionViewWidth;
/**
 *  build the sectionScrollView by views
 *
 *  @param views     views
 *  @param nameArray sectionNames
 */
- (void)buildViewWithViews:(NSArray *)views sectionNameArray:(NSArray *)nameArray;

/**
 *  build the secionScrollView by nib
 *
 *  @param viewNibNames nibNames
 *  @param nameArray    sectionNames
 */
- (void)buildViewWithNibNames:(NSArray *)viewNibNames sectionNameArray:(NSArray *)nameArray;
@end
