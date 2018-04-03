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
    self.pLabel1.trackWidth = 22;
    self.pLabel1.progressWidth = 22;
    self.pLabel1.roundedCornersWidth = 22;
    self.pLabel1.trackColor = [[UIColor redColor] colorWithAlphaComponent:.2];
    self.pLabel1.progressColor = [UIColor redColor];
    self.pLabel1.labelVCBlock = ^(KAProgressLabel *label){
        //self.pLabel1.startLabel.text = [NSString stringWithFormat:@"%.f",self.pLabel1.progress*100];
    };
    self.pLabel1.endDegreeUserInteractive = YES;
    self.pLabel1.showStartElipse = YES;
    self.pLabel1.shouldUseLineCap = YES;
    self.pLabel1.startElipseBorderWidth = 3;
    self.pLabel1.startElipseFillColor = [UIColor whiteColor];
    self.pLabel1.startElipseBorderColor = [UIColor magentaColor];
    self.pLabel1.endElipseBorderWidth = 3;
    self.pLabel1.endElipseFillColor = [UIColor whiteColor];
    self.pLabel1.endElipseBorderColor = [UIColor magentaColor];
    
    self.pLabel2.backgroundColor = [UIColor clearColor];
    self.pLabel2.trackWidth = 22;
    self.pLabel2.progressWidth = 22;
    self.pLabel2.roundedCornersWidth = 22;
    self.pLabel2.trackColor = [[UIColor greenColor] colorWithAlphaComponent:.2];
    self.pLabel2.progressColor = [UIColor greenColor];
    self.pLabel2.labelVCBlock = ^(KAProgressLabel *label){
        //self.pLabel2.startLabel.text = [NSString stringWithFormat:@"%.f",self.pLabel2.progress*100];
    };
    [self.pLabel2 setEndDegreeUserInteractive:YES];
    
    self.pLabel3.backgroundColor = [UIColor clearColor];
    self.pLabel3.trackWidth = 22;
    self.pLabel3.progressWidth = 22;
    self.pLabel3.roundedCornersWidth = 22;
    UIColor * col = [UIColor colorWithRed:0.02 green:0.73 blue:0.88 alpha:1];
    self.pLabel3.trackColor = [col colorWithAlphaComponent:.2];
    self.pLabel3.progressColor = col;
    self.pLabel3.labelVCBlock = ^(KAProgressLabel *label){
        //self.pLabel3.startLabel.text = [NSString stringWithFormat:@"%.f",self.pLabel3.progress*100];
    };
    self.pLabel3.endDegreeUserInteractive = YES;
    
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


-(IBAction) trackWidthSliderValueChanged:(UISlider *)sender {
    [self.pLabel1 setTrackWidth:sender.value];
    [self.pLabel2 setTrackWidth:sender.value];
    [self.pLabel3 setTrackWidth:sender.value];
}

-(IBAction) progressWidthSliderValueChanged:(UISlider *)sender {
    [self.pLabel1 setProgressWidth:sender.value];
    [self.pLabel2 setProgressWidth:sender.value];
    [self.pLabel3 setProgressWidth:sender.value];
}

-(IBAction)roundedCornersWidthSliderValueChanged:(UISlider *)sender {
    [self.pLabel1 setRoundedCornersWidth:sender.value];
    [self.pLabel2 setRoundedCornersWidth:sender.value];
    [self.pLabel3 setRoundedCornersWidth:sender.value];
}

@end
