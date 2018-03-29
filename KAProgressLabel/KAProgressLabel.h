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
@property (nonatomic) IBInspectable BOOL shouldUseLineCap;
@property (nonatomic, copy) IBInspectable UIColor * fillColor;
@property (nonatomic, copy) IBInspectable UIColor * trackColor;
@property (nonatomic, copy) IBInspectable UIColor * progressColor;
@property (nonatomic) IBInspectable BOOL showStartElipse;
@property (nonatomic, copy) IBInspectable UIColor * startElipseFillColor;
@property (nonatomic, copy) IBInspectable UIColor * startElipseBorderColor;
@property (nonatomic) IBInspectable CGFloat startElipseBorderWidth;
@property (nonatomic) IBInspectable BOOL showEndElipse;
@property (nonatomic, copy) IBInspectable UIColor * endElipseFillColor;
@property (nonatomic, copy) IBInspectable UIColor * endElipseBorderColor;
@property (nonatomic) IBInspectable CGFloat endElipseBorderWidth;
@property (nonatomic, strong) UILabel * startLabel;
@property (nonatomic, strong) UILabel * endLabel;


// Logic
@property (nonatomic) IBInspectable CGFloat startDegree;
@property (nonatomic) IBInspectable CGFloat endDegree;
@property (nonatomic) IBInspectable CGFloat progress;

// Interactivity
@property (nonatomic, getter=isStartDegreeUserInteractive) IBInspectable  BOOL startDegreeUserInteractive;
@property (nonatomic, getter=isEndDegreeUserInteractive) IBInspectable  BOOL endDegreeUserInteractive;

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
