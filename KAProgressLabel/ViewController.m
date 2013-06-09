//
//  ViewController.m
//  KAProgressLabel
//
//  Created by Alex on 09/06/13.
//  Copyright (c) 2013 Alexis Creuzot. All rights reserved.
//

#import "ViewController.h"
#import "KAProgressLabel.h"

@interface ViewController ()
@property (weak,nonatomic) IBOutlet KAProgressLabel * pLabel;
@property (weak,nonatomic) IBOutlet UISlider * startSlider;
@property (weak,nonatomic) IBOutlet UISlider * endSlider;
@property (weak,nonatomic) IBOutlet UISlider * borderSlider;
@property (weak,nonatomic) IBOutlet UISwitch * clockSwitch;
@property (weak,nonatomic) IBOutlet UISlider * progressSlider;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_startSlider addTarget:self action:@selector(startSliderValueChanged) forControlEvents:UIControlEventValueChanged];
    [_endSlider addTarget:self action:@selector(endSliderValueChanged) forControlEvents:UIControlEventValueChanged];
    [_borderSlider addTarget:self action:@selector(borderSliderValueChanged) forControlEvents:UIControlEventValueChanged];
    [_clockSwitch addTarget:self action:@selector(clockSwitchValueChanged) forControlEvents:UIControlEventValueChanged];
    [_progressSlider addTarget:self action:@selector(progressSliderValueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void) startSliderValueChanged
{
    [_pLabel setText:[NSString stringWithFormat:@"%.0f° - %.0f°",_startSlider.value, _endSlider.value]];
    [_pLabel setStartDegree:_startSlider.value];
}

- (void) endSliderValueChanged
{
    [_pLabel setText:[NSString stringWithFormat:@"%.0f° - %.0f°",_startSlider.value, _endSlider.value]];
    [_pLabel setEndDegree:_endSlider.value];
}

- (void) borderSliderValueChanged
{
    [_pLabel setBorderWidth:_borderSlider.value];
}
- (void) clockSwitchValueChanged
{
    [_pLabel setClockWise:_clockSwitch.on];
}

- (void) progressSliderValueChanged
{
    [_pLabel setText:[NSString stringWithFormat:@"%.0f%%",_progressSlider.value*100]];
    [_pLabel setProgress:_progressSlider.value];
}


@end
