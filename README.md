EAColourfulProgressView
=======================

![](https://raw.githubusercontent.com/Eddpt/EAColourfulProgressView/develop/demo.gif)

EAColourfulProgressView is a custom progress view where the current filling colour is generated between two colours, based on the current value.

It takes advantages of `IBDesignable` and `IBInspectable` so that you can completely customize with without leaving the Interface Builder.

It gives you the possibility to update the current value by calling:
```objective-c
/**
 *  This method updates the current value to the given one. It can
 *  animate the progress view filling size, as well as the background
 *  color change, if 'animated' is YES.
 *
 *  @param currentValue The new current value to be used.
 *  @param animated BOOL with YES if the update should be animated, NO otherwise.
 */
- (void)updateToCurrentValue:(NSInteger)currentValue animated:(BOOL)animated;
```

##Installation Cocoapods

Add this in your Podfile
```
pod 'EAColourfulProgressView', '~> 0.1.0'
```

##Future improvements

- Any number of segments
- Segment separators (loading like progress view)
- Performance improvements
