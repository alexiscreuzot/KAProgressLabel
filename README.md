#KAProgressLabel

Minimal circular & rectangle progress label for iOS.

####Demo1
![KAProgressLabel](http://i.imgur.com/GOeKip7.gif)

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

###Style

####Display Type

You can shoose between 2 types of display, circle and rectangle. For now rectangle is very basic and may very well be dropped in the future.

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
[_myProgressLabel setTrackWidth: 2.0];
[_myProgressLabel setProgressWidth: 4];
```

####Rounded corners
Rounded corners width can be edited separatly from the other widths.

```objective-c
[_myProgressLabel setRoundedCorners:YES];
[_myProgressLabel setRoundedCornersWidth:10]; // By default, roundedCornersWidth = progressWidth
```

####Start and End labels
A (very) small text can be display at the start and end of the progress arc, via 2 dedicated labels.
You can style this label any way you want. 

```objective-c
_myProgressLabel.startLabel.text = @"S";
_myProgressLabel.endLabel.text = @"E";
```

###Progress

####Set progress
Helper function to use this component easily when it comes to progress.

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

###User Interaction
You can allow the user to interact with both startDegree and endDegree. By default, user interaction is disabled.

```objective-c
// Activate User Interaction on both sides
[_myProgressLabel  setIsStartDegreeUserInteractive:YES]];
[_myProgressLabel  setIsEndDegreeUserInteractive:YES]];
```

##Advanced Usage

You may want to fine-tune yourself what arc to display or which way to draw it.
Yo can use these methods to do so.

```objective-c
- (void) setStartDegree:(CGFloat)startDegree;
- (void) setEndDegree:(CGFloat)endDegree;
- (void) setClockWise:(BOOL)clockWise;
```
