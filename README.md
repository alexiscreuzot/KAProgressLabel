#KAProgressLabel

Minimal circular progress label for iOS

![KAProgressLabel](http://i.imgur.com/NHlXx10.png)

##Install

###Lame install

* Copy the `KAProgressLabel/KAProgressLabel` folder into your project.
* Import KAProgressLabel.h from your .pch file

###Cool install

Using [cocoapods](http://cocoapods.org), just drop this line in your Podfile :
    pod 'KAProgressLabel'


##Usage

###Display

Have a look at the necessary code to display a progress label such as the one on top.

####Color

```objective-c
[_myProgressLabel setProgressColor:[UIColor blackColor]]; // black progress bar
[_myProgressLabel setTrackColor:[UIColor lightGrayColor]]; // gray track bar
[_myProgressLabel setFillColor:[UIColor clearColor]]; // transparent fill color
```

####BorderWidth

```objective-c
[_myProgressLabel setBorderWidth:5]; // 5px border
```

###Progress

####Set progress

```objective-c
// Progress must be between 0 and 1
[_myProgressLabel setText:@"50%"];
[_myProgressLabel setProgress:(50/100)];
```

####Set progress animated
A delegate method is provided in order for you to change the content of the label according to your needs

```objective-c
- (void)viewDidLoad
{
	[_myProgressLabel setDelegate:self];
	[_myProgressLabel setProgress:(50/100)
	                withAnimation:TPPropertyAnimationTimingEaseOut
	                     duration:1
	                   afterDelay:0];
}

#pragma mark - delegate

- (void)progressLabel:(KAProgressLabel *)label progressChanged:(CGFloat)progress
{
  [label setText:[NSString stringWithFormat:@"%.0f%%", (progress*100)]];
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



