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
@property (weak,nonatomic) IBOutlet UISlider * startSlider;
@property (weak,nonatomic) IBOutlet UISlider * endSlider;
@property (weak,nonatomic) IBOutlet UISlider * borderSlider;
@property (weak,nonatomic) IBOutlet UISwitch * clockSwitch;
@property (weak,nonatomic) IBOutlet UISlider * progressSlider;
@property (weak, nonatomic) IBOutlet UISwitch * rectangle;
@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];

    self.pLabel.progressLabelVCBlock = ^(KAProgressLabel *label, CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [label setText:[NSString stringWithFormat:@"%.0f%%", (progress*100)]];
        });
    };

    [self.pLabel setBackBorderWidth: 10.0];
    [self.pLabel setFrontBorderWidth: 9.8];
    [self.pLabel setColorTable: @{
            NSStringFromProgressLabelColorTableKey(ProgressLabelTrackColor):[UIColor redColor],
            NSStringFromProgressLabelColorTableKey(ProgressLabelProgressColor):[UIColor greenColor]
    }];
}

-(IBAction)startSliderValueChanged:(UISlider *)sender {
    [self.pLabel setText:[NSString stringWithFormat:@"%.0f° - %.0f°", sender.value, self.endSlider.value]];
    [self.pLabel setStartDegree:sender.value];
}

-(IBAction)endSliderValueChanged:(UISlider *)sender {
    [self.pLabel setText:[NSString stringWithFormat:@"%.0f° - %.0f°", self.startSlider.value, sender.value]];
    [self.pLabel setEndDegree:self.endSlider.value];
}

-(IBAction)borderSliderValueChanged:(UISlider *)sender {
    CGFloat bWidth = sender.value;
    [self.pLabel setBackBorderWidth:bWidth];
    [self.pLabel setFrontBorderWidth:bWidth-.2f];
}
-(IBAction)clockSwitchValueChanged:(UISwitch *)sender {
    [self.pLabel setClockWise:sender.on];
}

-(IBAction)progressSliderValueChanged:(UISlider *)sender {
    [self.pLabel setProgress:sender.value];
}

-(IBAction)selectAnimateTo50:(id)sender {
    
    [self.pLabel setEndDegree:180 timing:TPPropertyAnimationTimingEaseInEaseOut duration:1 delay:0];
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
