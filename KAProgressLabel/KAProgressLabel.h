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
typedef void(^labelAnimationCompletion)(KAProgressLabel *label);



IB_DESIGNABLE
@interface KAProgressLabel : UILabel

@property (nonatomic, copy) labelValueChangedCompletion labelVCBlock;
@property (nonatomic, copy) labelAnimationCompletion labelAnimCompleteBlock;

// Style
@property (nonatomic) IBInspectable CGFloat trackWidth; 
@property (nonatomic) IBInspectable CGFloat progressWidth;
@property (nonatomic) IBInspectable CGFloat roundedCornersWidth;
@property (nonatomic, copy) IBInspectable UIColor * fillColor;
@property (nonatomic, copy) IBInspectable UIColor * trackColor;
@property (nonatomic, copy) IBInspectable UIColor * progressColor;
@property (nonatomic, strong) UILabel * startLabel;
@property (nonatomic, strong) UILabel * endLabel;

// Logic
@property (nonatomic) IBInspectable CGFloat startDegree;
@property (nonatomic) IBInspectable CGFloat endDegree;
@property (nonatomic) IBInspectable CGFloat progress;

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
