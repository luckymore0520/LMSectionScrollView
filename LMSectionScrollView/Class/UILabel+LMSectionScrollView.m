//
//  UILabel+LMSectionScrollView.m
//  LMSectionScrollView
//
//  Created by Kun Wang on 15/12/19.
//  Copyright © 2015年 luckymore. All rights reserved.
//

#import "UILabel+LMSectionScrollView.h"


@implementation UILabel (LMSectionScrollView)
-(CGFloat)getMinWidth {
    CGSize maximumLabelSize = CGSizeMake(CGFLOAT_MAX, self.frame.size.height);
    CGSize expectedLabelSize = [self.text boundingRectWithSize:maximumLabelSize
                                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                    attributes:@{NSFontAttributeName:self.font}
                                                       context:nil].size;
    return expectedLabelSize.width;
}
@end
