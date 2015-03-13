#KAProgressLabel

Minimal circular & rectangle progress label for iOS.

####Demo1
![KAProgressLabel](http://zippy.gfycat.com/DeficientPitifulIndri.gif)

####Demo 2
![KAProgressLabel](http://zippy.gfycat.com/PreciousGraveGannet.gif)

##Install

###Lame install

* Copy the `KAProgressLabel/KAProgressLabel` folder into your project.
* Import KAProgressLabel.h from your .pch file

###Using [cocoapods](http://cocoapods.org)

add this line to your Podfile : 
`pod 'KAProgressLabel'`


##Usage

####Display

You can shoose between 2 types of display :

```objective-c
[_myProgressLabel setProgressType:ProgressLabelRect];
// or
[_myProgressLabel setProgressType:ProgressLabelCircle];
```

####Color

```objective-c
[_myProgressLabel setFillColor:[UIColor blackColor]];
[_myProgressLabel setTrackColor:[UIColor redColor]];
[_myProgressLabel setProgressColor:[UIColor greenColor]];
```

####BorderWidth

```objective-c
[_myProgressLabel setBackBorderWidth: 2.0];
[_myProgressLabel setFrontBorderWidth: 4];
```

####Rounded corners

```objective-c
[_myProgressLabel setRoundedCorners:YES];
[_myProgressLabel setRoundedCornersWidth:10]; // By default, roundedCornersWidth = progressWidth
```

###Progress

####Set progress

```objective-c
// Progress must be between 0 and 1
[_myProgressLabel setProgress:0.5];
```

####Set progress animated
A block is provided in order for you to change the content of the label according to your needs

```objective-c
- (void)viewDidLoad
{

	_myProgressLabel.labelVCBlock = ^(KAProgressLabel *label) {
        [label setText:[NSString stringWithFormat:@"%.0f%%", (progress*100)]];
    };

	[_myProgressLabel setProgress:0.5
                      timing:TPPropertyAnimationTimingEaseOut
                    duration:1.0
                       delay:0.0];
}
```

##Advanced Usage

You may want to fine-tune yourself what arc to display or which way to draw it.
Yo can use these methods to do so.

```objective-c
- (void) setStartDegree:(CGFloat)startDegree;
- (void) setEndDegree:(CGFloat)endDegree;
- (void) setClockWise:(BOOL)clockWise;
```

##Roadmap
- User interaction
