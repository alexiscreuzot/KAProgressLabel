//
//  KAProgressLabel.m
//  KAProgressLabel
//
//  Created by Alex on 09/06/13.
//  Copyright (c) 2013 Alexis Creuzot. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KAProgressLabel.h"

#define KADegreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )
#define KARadiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

@implementation KAProgressLabel {
    __unsafe_unretained TPPropertyAnimation *_currentAnimation;
}

@synthesize startDegree = _startDegree;
@synthesize endDegree = _endDegree;

#pragma mark Core

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self baseInit];
    }
    return self;
}

-(void)baseInit
{
    // We need a square view
    // For now, we resize  and center the view
    if(self.frame.size.width != self.frame.size.height){
        CGRect frame = self.frame;
        float delta = ABS(self.frame.size.width-self.frame.size.height)/2;
        if(self.frame.size.width > self.frame.size.height){
            frame.origin.x += delta;
            frame.size.width = self.frame.size.height;
            self.frame = frame;
        }else{
            frame.origin.y += delta;
            frame.size.height = self.frame.size.width;
            self.frame = frame;
        }
    }

    // Style
    self.progressType       = ProgressLabelCircle;
    self.trackWidth    = 5.0;
    self.progressWidth   = 5.0;
    self.fillColor          = [UIColor clearColor];
    self.trackColor         = [UIColor lightGrayColor];
    self.progressColor      = [UIColor blackColor];
    self.roundedCorners     = YES;
    
    // Logic
    self.startDegree        = 0;
    self.endDegree          = 0;
    self.progress           = 0;
    self.clockWise          = YES;
    
    // KVO
    [self addObserver:self forKeyPath:@"progressType" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"trackWidth" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"progressWidth" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"fillColor" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"trackColor" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"progressColor" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"roundedCorners" options:NSKeyValueObservingOptionNew context:nil];
    
    [self addObserver:self forKeyPath:@"startDegree" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"endDegree" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"clockWise" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"roundedCornerWidth" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)drawRect:(CGRect)rect
{
    if (_progressType == ProgressLabelCircle) {
        [self drawProgressLabelCircleInRect:rect];
    }else {
        [self drawProgressLabelRectInRect:rect];
    }
    [super drawTextInRect:rect];
}

#pragma mark - Getters

- (float) radius
{
    return MIN(self.frame.size.width,self.frame.size.height)/2;
}

- (CGFloat)startDegree
{
    return _startDegree +90;
}

- (CGFloat)endDegree
{
    return _endDegree +90;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    [self setNeedsDisplay] ;
}


#pragma mark Logic

-(void)setStartDegree:(CGFloat)startDegree
{
    _startDegree = startDegree - 90;
    
    KAProgressLabel *__unsafe_unretained weakSelf = self;
    if(self.labelVCBlock) {
        self.labelVCBlock(weakSelf);
    }
}

-(void)setEndDegree:(CGFloat)endDegree
{
    _endDegree = endDegree - 90;
    _progress = endDegree/360;
    
    KAProgressLabel *__unsafe_unretained weakSelf = self;
    if(self.labelVCBlock) {
        self.labelVCBlock(weakSelf);
    }
}

-(void)setProgress:(CGFloat)progress
{
    if(_progress != progress) {
        
        _progress = progress;
        
        [self setStartDegree:0];
        [self setEndDegree:progress*360];
        
        KAProgressLabel *__unsafe_unretained weakSelf = self;
        if(self.labelVCBlock) {
            self.labelVCBlock(weakSelf);
        }
    }
}

#pragma mark Animations

-(void)setStartDegree:(CGFloat)startDegree timing:(TPPropertyAnimationTiming)timing duration:(CGFloat)duration delay:(CGFloat)delay
{
    TPPropertyAnimation *animation = [TPPropertyAnimation propertyAnimationWithKeyPath:@"startDegree"];
    animation.fromValue = @(_startDegree+90);
    animation.toValue = @(startDegree);
    animation.duration = duration;
    animation.startDelay = delay;
    animation.timing = timing;
    [animation beginWithTarget:self];
    
    [self setStartDegree:startDegree];
    _currentAnimation = animation;
}

-(void)setEndDegree:(CGFloat)endDegree timing:(TPPropertyAnimationTiming)timing duration:(CGFloat)duration delay:(CGFloat)delay
{
    TPPropertyAnimation *animation = [TPPropertyAnimation propertyAnimationWithKeyPath:@"endDegree"];
    animation.fromValue = @(_endDegree+90);
    animation.toValue = @(endDegree);
    animation.duration = duration;
    animation.startDelay = delay;
    animation.timing = timing;
    [animation beginWithTarget:self];
    
    [self setEndDegree:endDegree];
    _currentAnimation = animation;
}

-(void)setProgress:(CGFloat)progress timing:(TPPropertyAnimationTiming)timing duration:(CGFloat)duration delay:(CGFloat)delay
{
    TPPropertyAnimation *animation = [TPPropertyAnimation propertyAnimationWithKeyPath:@"progress"];
    animation.fromValue = @(_progress);
    animation.toValue = @(progress);
    animation.duration = duration;
    animation.startDelay = delay;
    animation.timing = timing;
    
    [animation beginWithTarget:self];
    _currentAnimation = animation;
}

- (void) stopAnimations
{
    if (_currentAnimation != nil) {
        [_currentAnimation cancel];
    }
}

#pragma mark - Drawing

-(void)drawProgressLabelRectInRect:(CGRect)rect
{
    int clockWise = (_clockWise) ? 0 : 1;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // The background rectangle, filled for now
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGContextFillRect(context, rect);
    
    // Back unfilled rectangle
    CGContextSetStrokeColorWithColor(context, self.trackColor.CGColor);
    CGContextSetLineWidth(context, _trackWidth);
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);

    // foreground rectangle
    CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
    
    CGRect insideRect = rect;
    insideRect.origin.x += _trackWidth / 2;
    insideRect.origin.y += _trackWidth / 2;
    insideRect.size.width -= _trackWidth;
    insideRect.size.height -= _trackWidth;
    insideRect.size.height *= _progress;
    if (!clockWise){
        insideRect.origin.y += rect.size.height - insideRect.size.height - _trackWidth;
    }
    CGContextFillRect(context, insideRect);
}

-(void)drawProgressLabelCircleInRect:(CGRect)rect
{
    CGRect circleRect= [self rectForCircle:rect];
    CGFloat archXPos = rect.size.width/2 + rect.origin.x;
    CGFloat archYPos = rect.size.height/2 + rect.origin.y;
    CGFloat archRadius = (circleRect.size.width) / 2.0;
    int clockWise = (_clockWise) ? 0 : 1;

    CGFloat trackStartAngle = KADegreesToRadians(0);
    CGFloat trackEndAngle = KADegreesToRadians(360);
    CGFloat progressStartAngle = KADegreesToRadians(_startDegree);
    CGFloat progressEndAngle = KADegreesToRadians(_endDegree);

    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Circle
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGContextSetLineWidth(context, _trackWidth);
    CGContextFillEllipseInRect(context, circleRect);
    CGContextStrokePath(context);

    // Track
    CGContextSetStrokeColorWithColor(context, self.trackColor.CGColor);
    CGContextSetLineWidth(context, _trackWidth);
    CGContextAddArc(context, archXPos,archYPos, archRadius, trackStartAngle, trackEndAngle, 1);
    CGContextStrokePath(context);

    // Progress
    CGContextSetStrokeColorWithColor(context, self.progressColor.CGColor);
    CGContextSetLineWidth(context, _progressWidth);
    CGContextAddArc(context, archXPos,archYPos, archRadius, progressStartAngle, progressEndAngle, clockWise);
    CGContextStrokePath(context);
    
    // Rounded corners
    if(_progressWidth >2 && _roundedCorners){
        float cornerWidth = (_roundedCornerWidth)? _roundedCornerWidth/2 : _progressWidth/2;
        CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
        CGContextAddArc(context, [self xPosRoundForAngle:_startDegree],[self yPosRoundForAngle:_startDegree],cornerWidth,0.0,M_PI*2,YES);
        CGContextAddArc(context, [self xPosRoundForAngle:_endDegree],[self yPosRoundForAngle:_endDegree],cornerWidth,0.0,M_PI*2,YES);
        CGContextFillPath(context);
    }
}

#pragma mark - Helpers

- (float) xPosRoundForAngle:(float) degree
{
    return cosf(KADegreesToRadians(degree))* [self radius]
    + self.frame.size.width/2
    - cosf(KADegreesToRadians(degree))* [self borderDelta];
}
- (float) yPosRoundForAngle:(float) degree
{
    return sinf(KADegreesToRadians(degree))* [self radius]
    + self.frame.size.height/2
    - sinf(KADegreesToRadians(degree))* [self borderDelta];
}

- (float) borderDelta
{
    return MAX(_trackWidth,_progressWidth)/2;
}

-(CGRect)rectForCircle:(CGRect)rect
{
    CGFloat minDim = MIN(self.bounds.size.width, self.bounds.size.height);
    CGFloat circleRadius = (minDim / 2) - [self borderDelta];
    CGPoint circleCenter = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    return CGRectMake(circleCenter.x - circleRadius, circleCenter.y - circleRadius, 2 * circleRadius, 2 * circleRadius);
}

@end
