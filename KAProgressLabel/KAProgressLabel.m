//
//  KAProgressLabel.m
//  KAProgressLabel
//
//  Created by Alex on 09/06/13.
//  Copyright (c) 2013 Alexis Creuzot. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KAProgressLabel.h"

#define KADegreesToRadians(degrees) ((degrees)/180.0*M_PI)
#define KARadiansToDegrees(radians) ((radians)*180.0/M_PI)

@implementation KAProgressLabel {
    __unsafe_unretained TPPropertyAnimation *_currentAnimation;
}

@synthesize startDegree = _startDegree;
@synthesize endDegree = _endDegree;
@synthesize progress = _progress;

#pragma mark Core

-(void)dealloc
{
    // KVO
    [self removeObserver:self forKeyPath:@"trackWidth"];
    [self removeObserver:self forKeyPath:@"progressWidth"];
    [self removeObserver:self forKeyPath:@"fillColor"];
    [self removeObserver:self forKeyPath:@"trackColor"];
    [self removeObserver:self forKeyPath:@"progressColor"];
    [self removeObserver:self forKeyPath:@"startDegree"];
    [self removeObserver:self forKeyPath:@"endDegree"];
    [self removeObserver:self forKeyPath:@"roundedCornersWidth"];

    [self.startLabel removeObserver:self forKeyPath:@"text"];
    [self.endLabel removeObserver:self forKeyPath:@"text"];
}

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
    [self setUserInteractionEnabled:YES];
    
    // Style
    self.textAlignment = NSTextAlignmentCenter;
    self.trackWidth             = 5.0;
    self.progressWidth          = 5.0;
    self.roundedCornersWidth    = 0.0;
    self.fillColor              = [UIColor clearColor];
    self.trackColor             = [UIColor lightGrayColor];
    self.progressColor          = [UIColor blackColor];
    
    self.startLabel = [[UILabel  alloc] initWithFrame:CGRectZero];
    self.startLabel.textAlignment = NSTextAlignmentCenter;
    self.startLabel.adjustsFontSizeToFitWidth = YES;
    self.startLabel.minimumScaleFactor = .1;
    self.startLabel.clipsToBounds = YES;
    
    self.endLabel = [[UILabel  alloc] initWithFrame:CGRectZero];
    self.endLabel.textAlignment = NSTextAlignmentCenter;
    self.endLabel.adjustsFontSizeToFitWidth = YES;
    self.endLabel.minimumScaleFactor = .1;
    self.endLabel.clipsToBounds = YES;
    
    [self addSubview:self.startLabel];
    [self addSubview:self.endLabel];
    
    // Logic
    self.startDegree        = 0;
    self.endDegree          = 0;
    self.progress           = 0;
    
    // KVO
    [self addObserver:self forKeyPath:@"trackWidth"             options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"progressWidth"          options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"fillColor"              options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"trackColor"             options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"progressColor"          options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"startDegree"            options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"endDegree"              options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"roundedCornersWidth"    options:NSKeyValueObservingOptionNew context:nil];
    
    [self.startLabel addObserver:self forKeyPath:@"text"   options:NSKeyValueObservingOptionNew context:nil];
    [self.endLabel addObserver:self forKeyPath:@"text"    options:NSKeyValueObservingOptionNew context:nil];
}

-(void)drawRect:(CGRect)rect
{
    [self drawProgressLabelCircleInRect:rect];
    [super drawTextInRect:rect];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    [self setNeedsDisplay] ;
    
    if([keyPath isEqualToString:@"startDegree"] ||
       [keyPath isEqualToString:@"endDegree"]){
        
        KAProgressLabel *__unsafe_unretained weakSelf = self;
        if(self.labelVCBlock) {
            self.labelVCBlock(weakSelf);
        }
    }
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

- (CGFloat)progress
{
    return self.endDegree/360;
}

#pragma mark - Setters

-(void)setStartDegree:(CGFloat)startDegree
{
    _startDegree = startDegree - 90;
}

-(void)setEndDegree:(CGFloat)endDegree
{
    _endDegree = endDegree - 90;
}

-(void)setProgress:(CGFloat)progress
{
    if(self.startDegree != 0){
        [self setStartDegree:0];
    }
    [self setEndDegree:progress*360];
}

#pragma mark - Animations

-(void)setStartDegree:(CGFloat)startDegree timing:(TPPropertyAnimationTiming)timing duration:(CGFloat)duration delay:(CGFloat)delay
{
    TPPropertyAnimation *animation = [TPPropertyAnimation propertyAnimationWithKeyPath:@"startDegree"];
    animation.fromValue = @(_startDegree+90);
    animation.toValue = @(startDegree);
    animation.duration = duration;
    animation.startDelay = delay;
    animation.timing = timing;
    [animation beginWithTarget:self];
    
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
    
    _currentAnimation = animation;
}

-(void)setProgress:(CGFloat)progress timing:(TPPropertyAnimationTiming)timing duration:(CGFloat)duration delay:(CGFloat)delay
{
    [self setEndDegree:(progress*360) timing:timing duration:duration delay:delay];
}

- (void) stopAnimations
{
    if (_currentAnimation != nil) {
        [_currentAnimation cancel];
    }
}

#pragma mark - Touch Interaction

// Limit touch to actual disc surface
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIBezierPath *p = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    return  ([p containsPoint:point])? self : nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self moveBasedOnTouches:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self moveBasedOnTouches:touches withEvent:event];
}

- (void)moveBasedOnTouches:(NSSet *)touches withEvent:(UIEvent *)event
{
    // No interaction enabled
    if(!self.isStartDegreeUserInteractive &&
       !self.isEndDegreeUserInteractive){
        return;
    }
    
    UITouch * touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    // Coordinates to polar
    float x = touchLocation.x - self.frame.size.width/2;
    float y = touchLocation.y - self.frame.size.height/2;
    int angle = KARadiansToDegrees(atan(y/x));
    angle += (x>=0)?  90 : 270;

    // Interact
    if(!self.isStartDegreeUserInteractive) // Only End
    {
        [self setEndDegree:angle];
    }
    else if(!self.isEndDegreeUserInteractive) // Only Start
    {
        [self setStartDegree:angle];
    }
    else // All,hence move nearest knob
    {
        float startDelta = sqrt(pow(self.startLabel.center.x-touchLocation.x,2) + pow(self.startLabel.center.y- touchLocation.y,2));
        float endDelta = sqrt(pow(self.endLabel.center.x-touchLocation.x,2) + pow(self.endLabel.center.y - touchLocation.y,2));
        if(startDelta<endDelta){
            [self setStartDegree:angle];
        }else{
            [self setEndDegree:angle];
        }
    }
}

#pragma mark - Drawing

-(void)drawProgressLabelCircleInRect:(CGRect)rect
{
    CGRect circleRect= [self rectForCircle:rect];
    CGFloat archXPos = rect.size.width/2 + rect.origin.x;
    CGFloat archYPos = rect.size.height/2 + rect.origin.y;
    CGFloat archRadius = (circleRect.size.width) / 2.0;
    
    CGFloat trackStartAngle = KADegreesToRadians(0);
    CGFloat trackEndAngle = KADegreesToRadians(360);
    CGFloat progressStartAngle = KADegreesToRadians(_startDegree);
    CGFloat progressEndAngle = KADegreesToRadians(_endDegree);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Circle
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(rect.origin.x+1, rect.origin.y+1, rect.size.width-2, rect.size.height-2));
    CGContextStrokePath(context);
    
    // Track
    CGContextSetStrokeColorWithColor(context, self.trackColor.CGColor);
    CGContextSetLineWidth(context, _trackWidth);
    CGContextAddArc(context, archXPos,archYPos, archRadius, trackStartAngle, trackEndAngle, 1);
    CGContextStrokePath(context);
    
    // Progress
    CGContextSetStrokeColorWithColor(context, self.progressColor.CGColor);
    CGContextSetLineWidth(context, _progressWidth);
    CGContextAddArc(context, archXPos,archYPos, archRadius, progressStartAngle, progressEndAngle, 0);
    CGContextStrokePath(context);
    
    // Rounded corners
    if(_roundedCornersWidth > 0){
        CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
        CGContextAddEllipseInRect(context, [self rectForDegree:_startDegree andRect:rect]);
        CGContextAddEllipseInRect(context, [self rectForDegree:_endDegree andRect:rect]);
        CGContextFillPath(context);
    }
    
    self.startLabel.frame =  [self rectForDegree:_startDegree andRect:rect];
    self.endLabel.frame =  [self rectForDegree:_endDegree andRect:rect];
    self.startLabel.layer.cornerRadius = [self borderDelta];
    self.endLabel.layer.cornerRadius = [self borderDelta];
}

#pragma mark - Helpers

- (CGRect) rectForDegree:(float) degree andRect:(CGRect) rect 
{
    float x = [self xPosRoundForAngle:degree andRect:rect] - _roundedCornersWidth/2;
    float y = [self yPosRoundForAngle:degree andRect:rect] - _roundedCornersWidth/2;
    return CGRectMake(x, y, _roundedCornersWidth, _roundedCornersWidth);
}

- (float) xPosRoundForAngle:(float) degree andRect:(CGRect) rect
{
    return cosf(KADegreesToRadians(degree))* [self radius]
    - cosf(KADegreesToRadians(degree)) * [self borderDelta]
    + rect.size.width/2;
}

- (float) yPosRoundForAngle:(float) degree andRect:(CGRect) rect
{
    return sinf(KADegreesToRadians(degree))* [self radius]
    - sinf(KADegreesToRadians(degree)) * [self borderDelta]
    + rect.size.height/2;
}

- (float) borderDelta
{
    return MAX(MAX(_trackWidth,_progressWidth),_roundedCornersWidth)/2;
}

-(CGRect)rectForCircle:(CGRect)rect
{
    CGFloat minDim = MIN(self.bounds.size.width, self.bounds.size.height);
    CGFloat circleRadius = (minDim / 2) - [self borderDelta];
    CGPoint circleCenter = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    return CGRectMake(circleCenter.x - circleRadius, circleCenter.y - circleRadius, 2 * circleRadius, 2 * circleRadius);
}

@end
