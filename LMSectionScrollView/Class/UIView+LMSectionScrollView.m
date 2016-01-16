//
//  UIView+LMSectionScrollView.m
//  LMSectionScrollView
//
//  Created by Kun Wang on 15/12/19.
//  Copyright © 2015年 luckymore. All rights reserved.
//

#import "UIView+LMSectionScrollView.h"

@implementation UIView (LMSectionScrollView)
- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)right {
    return self.frame.origin.x + self.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
@end
