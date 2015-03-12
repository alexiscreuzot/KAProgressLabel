//
//  ViewController.m
//  KAProgressLabel
//
//  Created by Alex on 09/06/13.
//  Copyright (c) 2013 Alexis Creuzot. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak,nonatomic) IBOutlet KAProgressLabel * pLabel;

@property (weak,nonatomic) IBOutlet UISwitch * clockSwitch;
@property (weak, nonatomic) IBOutlet UISwitch * rectangleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch * roundedSwitch;

@property (weak,nonatomic) IBOutlet UISlider * startSlider;
@property (weak,nonatomic) IBOutlet UISlider * endSlider;
@property (weak,nonatomic) IBOutlet UISlider * backBorderSlider;
@property (weak,nonatomic) IBOutlet UISlider * frontBorderSlider;

@property (weak,nonatomic) IBOutlet UISlider * progressSlider;
@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];

    self.pLabel.backgroundColor = [UIColor clearColor];
    self.pLabel.progressLabelVCBlock = ^(KAProgressLabel *label, CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [label setText:[NSString stringWithFormat:@"%.0f%%", (progress*100)]];
        });
    };

    [self.pLabel setBackBorderWidth: 2.0];
    [self.pLabel setFrontBorderWidth: 4];
    [self.pLabel setColorTable: @{
            NSStringFromProgressLabelColorTableKey(ProgressLabelTrackColor):self.startSlider.tintColor,
            NSStringFromProgressLabelColorTableKey(ProgressLabelProgressColor):[UIColor greenColor]
    }];
    
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
    [self.pLabel setBackBorderWidth:sender.value];
}

-(IBAction) frontBorderSliderValueChanged:(UISlider *)sender {
    [self.pLabel setFrontBorderWidth:sender.value];
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

-(IBAction)selectAnimateTo50:(id)sender {
    
    [self.pLabel setProgress:.5 timing:TPPropertyAnimationTimingEaseInEaseOut duration:1 delay:0];
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
