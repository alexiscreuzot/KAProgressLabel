//
//  TPPropertyAnimation.m
//  Property Animation http://atastypixel.com/blog/key-path-based-property-animation
//
//  Created by Michael Tyson on 13/08/2010.
//  Copyright 2010 A Tasty Pixel. All rights reserved.
//

#import "TPPropertyAnimation.h"
#import <QuartzCore/QuartzCore.h>

#define kRefreshRate 1.0/30.0

// Storage for singleton manager
@class TPPropertyAnimationManager;
static TPPropertyAnimationManager *__manager = nil;

// Manager declaration
@class TPPropertyAnimation;
@interface TPPropertyAnimationManager : NSObject {
    id timer;
    NSMutableArray *animations;
}
+ (TPPropertyAnimationManager*)manager;
- (NSArray*)allPropertyAnimationsForTarget:(id)target;
- (void)update:(id)sender;
- (void)addAnimation:(TPPropertyAnimation*)animation;
- (void)removeAnimation:(TPPropertyAnimation*)animation;
@end

@interface TPPropertyAnimation ()
@property (nonatomic, readonly) NSTimeInterval startTime;
@end

// Main class
@implementation TPPropertyAnimation
@synthesize target, delegate, keyPath, duration, timing, fromValue, toValue, chainedAnimation, startTime, startDelay;

- (id)initWithKeyPath:(NSString*)theKeyPath {
    if ( !(self = [super init]) ) return nil;
    keyPath = theKeyPath ;
    timing = TPPropertyAnimationTimingEaseInEaseOut;
    duration = 0.5;
    startDelay = 0.0;
    return self;
}

+ (TPPropertyAnimation*)propertyAnimationWithKeyPath:(NSString*)keyPath {
    return [[TPPropertyAnimation alloc] initWithKeyPath:keyPath] ;
}

+ (NSArray*)allPropertyAnimationsForTarget:(id)target {
    return [[TPPropertyAnimationManager manager] allPropertyAnimationsForTarget:target];
}

- (void)begin {
    startTime = [NSDate timeIntervalSinceReferenceDate];
    
    if ( !fromValue ) {
        self.fromValue = [target valueForKey:keyPath];
    }
    
    [[TPPropertyAnimationManager manager] addAnimation:self];
}

- (void)beginWithTarget:(id)theTarget {
    self.target = theTarget;
    [self begin];
}

- (void)cancel {
    [[TPPropertyAnimationManager manager] removeAnimation:self];
}



@end


#pragma mark -
#pragma mark Timing

static inline CGFloat funcQuad(CGFloat ft, CGFloat f0, CGFloat f1) {
	return f0 + (f1 - f0) * ft * ft;
}

static inline CGFloat funcQuadInOut(CGFloat ft, CGFloat f0, CGFloat f1) {
    CGFloat a = ((f1 - f0)/2.0);
    if ( ft < 0.5 ) {
        return f0 + a * (2*ft)*(2*ft);
    } else {
        CGFloat b = ((2*ft) - 2);
        return f0 + a + ( a * (1 - (b*b)) );
    }
}

static inline CGFloat funcQuadOut(CGFloat ft, CGFloat f0, CGFloat f1) {
	return f0 + (f1 - f0) * (1.0 - (ft-1.0)*(ft-1.0));
}


#pragma mark -
#pragma mark Manager


@implementation TPPropertyAnimationManager

+ (TPPropertyAnimationManager*)manager {
    if ( !__manager ) {
        __manager = [[TPPropertyAnimationManager alloc] init];
    }
    return __manager;
}

- (NSArray*)allPropertyAnimationsForTarget:(id)target {
    NSMutableArray *result = [NSMutableArray array];
    if ( animations ) {
        for ( TPPropertyAnimation* animation in animations ) {
            if ( animation.target == target ) [result addObject:animation];
        }
    }
    return result;
}

- (void)addAnimation:(TPPropertyAnimation *)animation {
    
    if ( !animations ) {
        animations = [[NSMutableArray alloc] init];
    }
    
    [animations addObject:animation];
    
    if ( !timer ) {
        if ( NSClassFromString(@"CADisplayLink") != NULL ) {
            timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
            [timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        } else {
            timer = [NSTimer scheduledTimerWithTimeInterval:kRefreshRate target:self selector:@selector(update:) userInfo:nil repeats:YES];
        }
    }
}

- (void)removeAnimation:(TPPropertyAnimation *)animation {
    [animations removeObject:animation];
    
    if ( [animations count] == 0 ) {
        [timer invalidate]; timer = nil;
        __manager = nil;
    }
}

- (void)dealloc {
    if ( timer ) [timer invalidate];
}

- (void)update:(id)sender {
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    for ( TPPropertyAnimation *animation in [animations copy] ) {
        
        if ( now < animation.startTime + animation.startDelay ) continue; // Animation hasn't started yet
        
        // Calculate proportion of time through animation, and the corresponding position given the timing function
        NSTimeInterval time = (now - (animation.startTime+animation.startDelay)) / animation.duration;
        if ( time > 1.0 ) time = 1.0;
        
        CGFloat position = time;
        switch ( animation.timing ) {
            case TPPropertyAnimationTimingEaseIn:
                position = funcQuad(time, 0.0, 1.0);
                break;
            case TPPropertyAnimationTimingEaseOut:
                position = funcQuadOut(time, 0.0, 1.0);
                break;
            case TPPropertyAnimationTimingEaseInEaseOut:
                position = funcQuadInOut(time, 0.0, 1.0);
                break;                
            case TPPropertyAnimationTimingLinear:
            default:
                break;
        }
        
        // Determine interpolation between values given position
        id value = nil;
        if ( [animation.fromValue isKindOfClass:[NSNumber class]] ) {
            value = [NSNumber numberWithDouble:[animation.fromValue doubleValue] + (position*([animation.toValue doubleValue] - [animation.fromValue doubleValue]))];
        } else {
            NSLog(@"Unsupported property type %@", NSStringFromClass([animation.fromValue class]));
        }
        
        // Apply new value
        if ( value ) {
            [animation.target setValue:value forKeyPath:animation.keyPath];
        }
        
        if ( time >= 1.0 ) {
            // Animation has finished. Notify delegate, fire chained animation if there is one, and remove
            if ( animation.delegate ) {
                [animation.delegate propertyAnimationDidFinish:animation];
            }
            if ( animation.chainedAnimation ) {
                [animation.chainedAnimation begin];
            }
            [self removeAnimation:animation];
        }
    }
}
@end
