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


@interface KAProgressLabel : UILabel

@property (nonatomic, copy) labelValueChangedCompletion labelVCBlock;

// Style
@property (nonatomic) CGFloat trackWidth; 
@property (nonatomic) CGFloat progressWidth;
@property (nonatomic) CGFloat roundedCornersWidth;
@property (nonatomic, copy) UIColor * fillColor;
@property (nonatomic, copy) UIColor * trackColor;
@property (nonatomic, copy) UIColor * progressColor;
@property (nonatomic, strong) UILabel * startLabel;
@property (nonatomic, strong) UILabel * endLabel;

// Logic
@property (nonatomic) CGFloat startDegree;
@property (nonatomic) CGFloat endDegree;
@property (nonatomic) CGFloat progress;

// Interactivity
@property (nonatomic) BOOL isStartDegreeUserInteractive;
@property (nonatomic) BOOL isEndDegreeUserInteractive;

// Getters
- (float)radius;

// Animations
- (void)setStartDegree:(CGFloat)startDegree
               timing:(TPPropertyAnimationTiming)timing
             duration:(CGFloat)duration
                delay:(CGFloat)delay;

- (void)setEndDegree:(CGFloat)endDegree
             timing:(TPPropertyAnimationTiming)timing
           duration:(CGFloat)duration
              delay:(CGFloat)delay;

- (void)setProgress:(CGFloat)progress
            timing:(TPPropertyAnimationTiming)timing
          duration:(CGFloat)duration
             delay:(CGFloat)delay;

- (void)stopAnimations;
@end
