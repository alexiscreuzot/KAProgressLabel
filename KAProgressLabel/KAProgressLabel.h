//
//  KAProgressLabel.h
//  KAProgressLabel
//
//  Created by Alex on 09/06/13.
//  Copyright (c) 2013 Alexis Creuzot. All rights reserved.
//

#import "TPPropertyAnimation.h"

@class KAProgressLabel;

typedef void(^labelValueChangedCompletion)(KAProgressLabel *label);
typedef NS_ENUM(NSUInteger, ProgressLableType) {
    ProgressLabelCircle,
    ProgressLabelRect
};

@interface KAProgressLabel : UILabel

@property (nonatomic, copy) labelValueChangedCompletion labelVCBlock;

// Style
@property (nonatomic, assign) CGFloat backBorderWidth;
@property (nonatomic, assign) CGFloat frontBorderWidth;
@property (nonatomic, assign) CGFloat roundedCornerWidth;
@property (nonatomic, copy) UIColor * fillColor;
@property (nonatomic, copy) UIColor * trackColor;
@property (nonatomic, copy) UIColor * progressColor;
@property (nonatomic, assign) ProgressLableType progressType;
@property (nonatomic, assign) BOOL roundedCorners;

// Logic
@property (nonatomic, assign) CGFloat startDegree;
@property (nonatomic, assign) CGFloat endDegree;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) BOOL clockWise;

// Getters
- (float)radius;

// Animations
-(void)setStartDegree:(CGFloat)startDegree
               timing:(TPPropertyAnimationTiming)timing
             duration:(CGFloat)duration
                delay:(CGFloat)delay;

-(void)setEndDegree:(CGFloat)endDegree
             timing:(TPPropertyAnimationTiming)timing
           duration:(CGFloat)duration
              delay:(CGFloat)delay;


-(void)setProgress:(CGFloat)progress
            timing:(TPPropertyAnimationTiming)timing
          duration:(CGFloat)duration
             delay:(CGFloat)delay;

-(void)stopAnimations;
@end
