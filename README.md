# KAProgressLabel

Circular progress label for iOS with styling, animations, interaction and more.

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
```ruby
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

### Arc

#### Progress
If you only want to show a progress, it's straightforward.

```objective-c
// Progress must be between 0 and 1
self.myProgressLabel.progress = 0.5;
```

#### Specific start/end degrees

```objective-c
- (void)setStartDegree:(CGFloat)startDegree;
- (void)setEndDegree:(CGFloat)endDegree;
```

### User interaction
You can allow the user to interact with both `startDegree` and `endDegree`. By default, user interaction is disabled.

```objective-c
// Activate user interaction on both sides
self.myProgressLabel.isStartDegreeUserInteractive = YES;
self.myProgressLabel.isEndDegreeUserInteractive = YES;
```

### Animations 
You can animate `startDegree`, `endDegree` and `progress`.

```objective-c
- (void)setStartDegree:(CGFloat)startDegree
               timing:(TPPropertyAnimationTiming)timing
             duration:(CGFloat)duration
                delay:(CGFloat)delay;

- (void)setEndDegree:(CGFloat)endDegree
             timing:(TPPropertyAnimationTiming)timing
           duration:(CGFloat)duration
              delay:(CGFloat)delay;

- (void)setProgress:(CGFloat)progress
            timing:(TPPropertyAnimationTiming)timing
          duration:(CGFloat)duration
             delay:(CGFloat)delay;
```

It's possible to stop an already started animation.

```objective-c
- (void)stopAnimations;
```

You can also add some custom logic at the end of an animation using the `labelAnimCompleteBlock` block.

```objective-c
self.myProgressLabel.labelAnimCompleteBlock = ^(KAProgressLabel *label) {
    NSLog(@"Animation complete !");
};
```
