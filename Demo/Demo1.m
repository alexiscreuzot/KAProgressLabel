//
//  ViewController.m
//  KAProgressLabel
//
//  Created by Alex on 09/06/13.
//  Copyright (c) 2013 Alexis Creuzot. All rights reserved.
//

#import "Demo1.h"


@interface Demo1 ()
@property (weak,nonatomic) IBOutlet KAProgressLabel * pLabel;

@property (weak,nonatomic) IBOutlet UISwitch * clockSwitch;
@property (weak, nonatomic) IBOutlet UISwitch * rectangleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch * roundedSwitch;

@property (weak,nonatomic) IBOutlet UISlider * startSlider;
@property (weak,nonatomic) IBOutlet UISlider * endSlider;
@property (weak,nonatomic) IBOutlet UISlider * backBorderSlider;
@property (weak,nonatomic) IBOutlet UISlider * frontBorderSlider;
@property (weak,nonatomic) IBOutlet UISlider * roundedCornersSlider;

@property (weak,nonatomic) IBOutlet UISlider * progressSlider;
@end

@implementation Demo1

-(void)viewDidLoad {
    [super viewDidLoad];

    self.pLabel.backgroundColor = [UIColor clearColor];
    
    __unsafe_unretained Demo1 * weakSelf = self;
    self.pLabel.labelVCBlock = ^(KAProgressLabel *label) {
        weakSelf.pLabel.startLabel.text = [NSString stringWithFormat:@"%.f",weakSelf.pLabel.startDegree];
        weakSelf.pLabel.endLabel.text = [NSString stringWithFormat:@"%.f",weakSelf.pLabel.endDegree];
        
        float delta =label.endDegree-label.startDegree;
        if( delta<0){
            [label setText:[NSString stringWithFormat:@"%.0f%%",(delta+360)/3.6]];
        }else{
            [label setText:[NSString stringWithFormat:@"%.0f%%",(delta)/3.6]];
        }
        weakSelf.startSlider.value = label.startDegree;
        weakSelf.endSlider.value = label.endDegree;
    };

    [self.pLabel setTrackWidth: 2.0];
    [self.pLabel setProgressWidth: 4];
    self.pLabel.fillColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.3];
    self.pLabel.trackColor = self.startSlider.tintColor;
    self.pLabel.progressColor = [UIColor greenColor];
    self.pLabel.isStartDegreeUserInteractive = YES;
    self.pLabel.isEndDegreeUserInteractive = YES;
    
    // Inits
    [self startSliderValueChanged:self.startSlider];
    [self endSliderValueChanged:self.endSlider];
    [self backBorderSliderValueChanged:self.backBorderSlider];
    [self frontBorderSliderValueChanged:self.frontBorderSlider];
    [self clockSwitchValueChanged:self.clockSwitch];
    [self roundedSwitch:self.roundedSwitch];
    [self progressSliderValueChanged:self.progressSlider];
    [self rectangleValueChanged:self.rectangleSwitch];
}

-(IBAction)startSliderValueChanged:(UISlider *)sender {
    [self.pLabel setText:[NSString stringWithFormat:@"%.0f° - %.0f°", sender.value, self.endSlider.value]];
    [self.pLabel setStartDegree:sender.value];
}

-(IBAction)endSliderValueChanged:(UISlider *)sender {
    [self.pLabel setText:[NSString stringWithFormat:@"%.0f° - %.0f°", self.startSlider.value, sender.value]];
    [self.pLabel setEndDegree:self.endSlider.value];
}

-(IBAction) backBorderSliderValueChanged:(UISlider *)sender {
    [self.pLabel setTrackWidth:sender.value];
}

-(IBAction) frontBorderSliderValueChanged:(UISlider *)sender {
    [self.pLabel setProgressWidth:sender.value];
}

-(IBAction)clockSwitchValueChanged:(UISwitch *)sender {
    [self.pLabel setClockWise:sender.on];
}

-(IBAction)roundedSwitch:(UISwitch *)sender {
    [self.pLabel setRoundedCorners:sender.on];
}

-(IBAction)progressSliderValueChanged:(UISlider *)sender {
    [self.pLabel setProgress:sender.value/100];
}

-(IBAction)roundedCornersSliderValueChanged:(UISlider *)sender {
    [self.pLabel setRoundedCornersWidth:sender.value];
}

-(IBAction)selectAnimate:(id)sender {
    float rndValue =  arc4random() % 360;
    float rndValue2 =  arc4random() % 360;
    [self.pLabel setStartDegree:rndValue timing:TPPropertyAnimationTimingEaseInEaseOut duration:1 delay:0];
    [self.pLabel setEndDegree:rndValue2 timing:TPPropertyAnimationTimingEaseInEaseOut duration:1 delay:0];
}

-(IBAction)rectangleValueChanged:(UISwitch *)sender {
    if (sender.on) {
        [self.pLabel setProgressType:ProgressLabelRect];
    }
    else {
        [self.pLabel setProgressType:ProgressLabelCircle];
    }
}

- (IBAction)selectStop:(id)sender{
    [self.pLabel stopAnimations];
}
@end
