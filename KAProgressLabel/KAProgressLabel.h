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
typedef CGFloat(^radiansFromDegreesCompletion)(CGFloat degrees);

typedef NS_ENUM(NSUInteger, ProgressLabelColorTable) {
    ProgressLabelFillColor,
    ProgressLabelTrackColor,
    ProgressLabelProgressColor,
};

typedef NS_ENUM(NSUInteger, ProgressLableType) {
    ProgressLabelCircle,
    ProgressLabelRect
};

@interface KAProgressLabel : UILabel

@property (nonatomic, copy) labelValueChangedCompletion labelVCBlock;

@property (nonatomic, assign) CGFloat backBorderWidth;
@property (nonatomic, assign) CGFloat frontBorderWidth;
@property (nonatomic, assign) CGFloat startDegree;
@property (nonatomic, assign) CGFloat endDegree;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) ProgressLableType progressType;

@property (nonatomic, copy) NSDictionary *colorTable;

@property (nonatomic, assign) BOOL clockWise;
@property (nonatomic, assign) BOOL roundedCorners;

#ifdef __cplusplus
extern "C" {
#endif
NSString *NSStringFromProgressLabelColorTableKey(ProgressLabelColorTable tableColor);
UIColor *UIColorDefaultForColorInProgressLabelColorTableKey(ProgressLabelColorTable tableColor);
#ifdef __cplusplus
}
#endif

-(float) radius;
-(void)setStartDegree:(CGFloat)startDegree timing:(TPPropertyAnimationTiming)timing duration:(CGFloat)duration delay:(CGFloat)delay;
-(void)setEndDegree:(CGFloat)endDegree timing:(TPPropertyAnimationTiming)timing duration:(CGFloat)duration delay:(CGFloat)delay;

// Progress is a float between 0.0 and 1.0
-(void)setProgress:(CGFloat)progress;
-(void)setProgress:(CGFloat)progress timing:(TPPropertyAnimationTiming)timing duration:(CGFloat) duration delay:(CGFloat)delay;
-(void)stopAnimations;
@end
