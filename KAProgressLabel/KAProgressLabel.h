//
//  KAProgressLabel.h
//  KAProgressLabel
//
//  Created by Alex on 09/06/13.
//  Copyright (c) 2013 Alexis Creuzot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KAProgressLabel : UILabel

- (void) setBorderWidth:(CGFloat)borderWidth;
- (void) setStartDegree:(CGFloat)startDegree;
- (void) setEndDegree:(CGFloat)endDegree;
- (void) setColor:(UIColor *)color;
- (void) setClockWise:(BOOL)clockWise;
// Progress is a float between 0 and 1
- (void) setProgress:(CGFloat)progress;
@end
