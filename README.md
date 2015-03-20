# KAProgressLabel

Minimal circular progress label for iOS.

#### Demo 1
![KAProgressLabel](http://zippy.gfycat.com/ThriftyAdolescentAruanas.gif)

#### Demo 2
Endless possibilities!
![KAProgressLabel](http://i.imgur.com/XtfKAjs.png)


## Installing

### Lame install

* Copy the `KAProgressLabel/KAProgressLabel` folder into your project.
* Import KAProgressLabel.h from your .pch file

### Using [CocoaPods](http://cocoapods.org)

Add this line to your Podfile:
```
pod 'KAProgressLabel'
```


## Usage

### Style

#### Colors

```objective-c
self.myProgressLabel.fillColor = [UIColor blackColor];
self.myProgressLabel.trackColor = [UIColor redColor];
self.myProgressLabel.progressColor = [UIColor greenColor];
```

#### Widths

```objective-c
self.myProgressLabel.trackWidth = 2.0;         // Defaults to 5.0
self.myProgressLabel.progressWidth = 4;        // Defaults to 5.0
self.myProgressLabel.roundedCornersWidth = 10; // Defaults to 0
```

#### Start and end labels
A (very) small text can be display at the start and end of the progress arc, via 2 dedicated labels.
You can style this label any way you want.

```objective-c
self.myProgressLabel.startLabel.text = @"S";
self.myProgressLabel.endLabel.text = @"E";
```

### Progress

#### Set progress
Helper function to use this component easily when it comes to progress.

```objective-c
// Progress must be between 0 and 1
self.myProgressLabel.progress = 0.5;
```

#### Set progress (animated)
A block is provided in order for you to change the content of the label according to your needs.

```objective-c
- (void)viewDidLoad {
    self.myProgressLabel.labelVCBlock = ^(KAProgressLabel *label) {
        label.text:[NSString stringWithFormat:@"%.0f%%", (label.progress * 100)];
    };

    [self.myProgressLabel setProgress:0.5
                               timing:TPPropertyAnimationTimingEaseOut
                             duration:1.0
                                delay:0.0];
}
```

### User interaction
You can allow the user to interact with both `startDegree` and `endDegree`. By default, user interaction is disabled.

```objective-c
// Activate user interaction on both sides
self.myProgressLabel.isStartDegreeUserInteractive = YES;
self.myProgressLabel.isEndDegreeUserInteractive = YES;
```


## Advanced usage
If you need fine-tune yourself the arc to display.

```objective-c
- (void)setStartDegree:(CGFloat)startDegree;
- (void)setEndDegree:(CGFloat)endDegree;
```
