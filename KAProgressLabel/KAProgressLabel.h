//
//  KAProgressLabel.h
//  KAProgressLabel
//
//  Created by Alex on 09/06/13.
//  Copyright (c) 2013 Alexis Creuzot. All rights reserved.
//

#import "TPPropertyAnimation.h"

@class KAProgressLabel;
@protocol KAProgressLabelDelegate <NSObject>
@optional
- (void) progressLabel:(KAProgressLabel *) label progressChanged:(CGFloat)progress;
@end

@interface KAProgressLabel : UILabel

@property (nonatomic, unsafe_unretained) IBOutlet id <KAProgressLabelDelegate> delegate;

- (void) setBorderWidth:(CGFloat)borderWidth;
- (void) setStartDegree:(CGFloat)startDegree;
- (void) setEndDegree:(CGFloat)endDegree;
- (void) setProgressColor:(UIColor *)color;
- (void) setTrackColor:(UIColor *)color;
- (void) setFillColor:(UIColor *)color;
- (void) setClockWise:(BOOL)clockWise;

// Progress is a float between 0 and 1
- (void) setProgress:(CGFloat)progress;
- (void) setProgress:(CGFloat)progress
       withAnimation:(TPPropertyAnimationTiming) anim
            duration:(CGFloat) duration
          afterDelay:(CGFloat) delay;
@end
