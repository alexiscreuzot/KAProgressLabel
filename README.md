#KAProgressLabel

Minimal circular & rectangle progress label for iOS.

####Demo1
![KAProgressLabel](http://zippy.gfycat.com/ThriftyAdolescentAruanas.gif)

####Demo 2
Endless possibilities !
![KAProgressLabel](http://i.imgur.com/XtfKAjs.png)

##Install

###Lame install

* Copy the `KAProgressLabel/KAProgressLabel` folder into your project.
* Import KAProgressLabel.h from your .pch file

###Using [cocoapods](http://cocoapods.org)

add this line to your Podfile : 
`pod 'KAProgressLabel'`

##Usage

###Style

####Colors

```objective-c
[_myProgressLabel setFillColor:[UIColor blackColor]];
[_myProgressLabel setTrackColor:[UIColor redColor]];
[_myProgressLabel setProgressColor:[UIColor greenColor]];
```

####Widths

```objective-c
[_myProgressLabel setTrackWidth: 2.0]; // Default to 5.0
[_myProgressLabel setProgressWidth: 4]; // Default to 5.0
[_myProgressLabel setRoundedCornersWidth:10]; // Default to 0
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
	_myProgressLabel.labelVCBlock = ^(KAProgressLabel * label) {
        [label setText:[NSString stringWithFormat:@"%.0f%%", (label.progress*100)]];
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
If you need fine-tune yourself the arc to display.

```objective-c
- (void) setStartDegree:(CGFloat)startDegree;
- (void) setEndDegree:(CGFloat)endDegree;
```
