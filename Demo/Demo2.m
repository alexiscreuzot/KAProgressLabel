//
//  Demo2.m
//  KAProgressLabel
//
//  Created by Alexis Creuzot on 13/03/2015.
//  Copyright (c) 2015 Alexis Creuzot. All rights reserved.
//

#import "Demo2.h"
#import "KAProgressLabel.h"

@interface Demo2 ()
@property (weak,nonatomic) IBOutlet KAProgressLabel * pLabel1;
@property (weak,nonatomic) IBOutlet KAProgressLabel * pLabel2;
@property (weak,nonatomic) IBOutlet KAProgressLabel * pLabel3;
@end

@implementation Demo2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pLabel1.backgroundColor = [UIColor clearColor];
    self.pLabel1.roundedCorners = YES;
    self.pLabel1.trackWidth = 23;
    self.pLabel1.progressWidth = 3;
    self.pLabel1.roundedCornersWidth = 23;
    self.pLabel1.trackColor = [[UIColor clearColor] colorWithAlphaComponent:.3];
    self.pLabel1.progressColor = [UIColor redColor];
    
    self.pLabel2.backgroundColor = [UIColor clearColor];
    self.pLabel2.roundedCorners = YES;
    self.pLabel2.trackWidth = 23;
    self.pLabel2.progressWidth = 3;
    self.pLabel2.roundedCornersWidth = 23;
    self.pLabel2.trackColor = [[UIColor clearColor] colorWithAlphaComponent:.3];
    self.pLabel2.progressColor = [UIColor greenColor];
    
    self.pLabel3.backgroundColor = [UIColor clearColor];
    self.pLabel3.roundedCorners = YES;
    self.pLabel3.trackWidth = 23;
    self.pLabel3.progressWidth = 3;
    self.pLabel3.roundedCornersWidth = 23;
    self.pLabel3.trackColor = [[UIColor clearColor] colorWithAlphaComponent:.3];
    self.pLabel3.progressColor = [UIColor blueColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self selectAnimate:nil];
}

- (IBAction)selectAnimate:(id)sender
{
    self.pLabel1.progress = 0;
    self.pLabel2.progress = 0;
    self.pLabel3.progress = 0;
    
    [self.pLabel1 setProgress:(arc4random() % 100)*0.01 timing:TPPropertyAnimationTimingEaseInEaseOut duration:1 delay:.2];
    [self.pLabel2 setProgress:(arc4random() % 100)*0.01 timing:TPPropertyAnimationTimingEaseInEaseOut duration:1 delay:.2];
    [self.pLabel3 setProgress:(arc4random() % 100)*0.01 timing:TPPropertyAnimationTimingEaseInEaseOut duration:1 delay:.2];
}

@end
