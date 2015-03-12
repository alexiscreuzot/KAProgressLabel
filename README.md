#KAProgressLabel

Minimal circular & rectangle progress label for iOS.

![KAProgressLabel](http://fat.gfycat.com/DimReliableGorilla.gif)

##Install

###Lame install

* Copy the `KAProgressLabel/KAProgressLabel` folder into your project.
* Import KAProgressLabel.h from your .pch file

###Using [cocoapods](http://cocoapods.org)

add this line to your Podfile : 
`pod 'KAProgressLabel'`


##Usage

###Display

Have a look at the necessary code to display a progress label such as the one on top.

####Color

```objective-c
[_myProgressLabel setColorTable: @{
		NSStringFromProgressLabelColorTableKey(ProgressLabelFillColor):[UIColor clearColor],
        NSStringFromProgressLabelColorTableKey(ProgressLabelTrackColor):[UIColor redColor],
        NSStringFromProgressLabelColorTableKey(ProgressLabelProgressColor):[UIColor greenColor]
    }];
```

####BorderWidth

```objective-c
[_myProgressLabel setBackBorderWidth: 2.0];
[_myProgressLabel setFrontBorderWidth: 4];
```

###Progress

####Set progress

```objective-c
// Progress must be between 0 and 1
[_myProgressLabel setText:@"50%"];
[_myProgressLabel setProgress:0.5];
```

####Set progress animated
A block is provided in order for you to change the content of the label according to your needs

```objective-c
- (void)viewDidLoad
{
	//Using delegation
	[_myProgressLabel setDelegate:self]; 

	//Using block
	_myProgressLabel.progressLabelVCBlock = ^(KAProgressLabel *label, CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [label setText:[NSString stringWithFormat:@"%.0f%%", (progress*100)]];
        });
    };

	[_myProgressLabel setProgress:0.5
                      timing:TPPropertyAnimationTimingEaseOut
                    duration:1.0
                       delay:0.0];
}

##Advanced Usage

You may want to fine-tune yourself what arc to display or which way to draw it.
Yo can use these methods to do so.

```objective-c
- (void) setStartDegree:(CGFloat)startDegree;
- (void) setEndDegree:(CGFloat)endDegree;
- (void) setClockWise:(BOOL)clockWise;
```

##Roadmap
- Rounded bounds
- User interaction
