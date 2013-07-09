//
//  KAProgressLabel.m
//  KAProgressLabel
//
//  Created by Alex on 09/06/13.
//  Copyright (c) 2013 Alexis Creuzot. All rights reserved.
//

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#import <QuartzCore/QuartzCore.h>
#import "KAProgressLabel.h"

@interface KAProgressLabel ()
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic) CGFloat startDegree;
@property (nonatomic) CGFloat endDegree;
@property (nonatomic) BOOL clockWise;
@property (strong,nonatomic) UIColor * progressColor;
@property (strong,nonatomic) UIColor * trackColor;
@property (strong,nonatomic) UIColor * fillColor;
@property (nonatomic) CGFloat progress;
@end


@implementation KAProgressLabel


#pragma mark - Public API

- (void) setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    [self setNeedsDisplay];
}

- (void) setStartDegree:(CGFloat)startDegree
{
    _startDegree = startDegree - 90;
    [self setNeedsDisplay];
}

- (void) setEndDegree:(CGFloat)endDegree
{
    _endDegree = endDegree - 90;
    _progress = endDegree/360;
    [self setNeedsDisplay];
}

- (void) setProgressColor:(UIColor *)color
{
    _progressColor = color;
    [self setNeedsDisplay];
}

- (void) setTrackColor:(UIColor *)color
{
    _trackColor = color;
    [self setNeedsDisplay];
}

- (void) setFillColor:(UIColor *)color
{
    _fillColor = color;
    [self setNeedsDisplay];
}

- (void) setClockWise:(BOOL)clockWise
{
    _clockWise = clockWise;
    [self setNeedsDisplay];
}

- (void) setProgress:(CGFloat)progress
{
    _progress = progress;
    float angle = progress*360;
    
    [self setStartDegree:0];
    [self setEndDegree:angle];
    
    
    // Call delegate
    if(_delegate &&
       [_delegate respondsToSelector:@selector(progressLabel:progressChanged:)]){
        [_delegate progressLabel:self progressChanged:progress];
    }
}

- (void) setProgress:(CGFloat)progress withAnimation:(TPPropertyAnimationTiming) anim duration:(CGFloat) duration afterDelay:(CGFloat) delay
{
    TPPropertyAnimation *animation = [TPPropertyAnimation propertyAnimationWithKeyPath:@"progress"];
    animation.fromValue = @(_progress);
    animation.toValue = @(progress);
    animation.duration =duration;
    animation.startDelay = delay;
    animation.timing = anim;
    [animation beginWithTarget:self];
}

#pragma mark - Core

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initProperties];
    }
    return self;
}


- (void)awakeFromNib
{
    [self initProperties];
}

- (void)initProperties
{
    // Init
    _borderWidth = 5 ;
    _startDegree = -90;
    _endDegree = -90;
    _progress = 0;
    _clockWise = YES;
    _progressColor = [UIColor blackColor];
    _trackColor = [UIColor lightGrayColor];
    _fillColor = [UIColor clearColor];

    
    // Set square frame
    CGRect rect = self.frame;
    rect.size.height = self.frame.size.width;
    self.frame = rect;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGFloat d = rect.size.width - _borderWidth;
    CGFloat clockWise;
    if(_clockWise){
        clockWise = 0;
    }else{
        clockWise = 1;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Circle
    CGContextAddEllipseInRect(context, rect);
    CGContextSetFillColor(context, CGColorGetComponents(_fillColor.CGColor));
    CGContextFillPath(context);
    
    CGContextSetLineWidth(context, _borderWidth);
    
    // Back border
    CGContextSetStrokeColorWithColor(context, _trackColor.CGColor);
    CGContextAddArc(context, rect.size.width/2,rect.size.height/2, d/2, DEGREES_TO_RADIANS(0), DEGREES_TO_RADIANS(360), 1);
    CGContextStrokePath(context);
    
    // Top Border
    CGContextSetStrokeColorWithColor(context, _progressColor.CGColor);
    CGContextAddArc(context, rect.size.width/2,rect.size.height/2, d/2, DEGREES_TO_RADIANS(_startDegree), DEGREES_TO_RADIANS(_endDegree), clockWise);
    CGContextStrokePath(context);
    
    
    [super drawRect:rect];
}





@end
