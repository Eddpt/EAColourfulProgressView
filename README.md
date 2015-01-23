EAColourfulProgressView
=======================
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-objc-brightgreen.svg?style=flat)](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)
[![Issues](https://img.shields.io/github/issues/Eddpt/EAColourfulProgressView.svg?style=flat)](https://github.com/Eddpt/EAColourfulProgressView?state=open)

![](https://raw.githubusercontent.com/Eddpt/EAColourfulProgressView/develop/demo.gif)

EAColourfulProgressView is a custom progress view where the current filling colour is generated between two colours, based on the current value.

It takes advantages of `IBDesignable` and `IBInspectable` so that you can completely customize with without leaving the Interface Builder:

![](https://raw.githubusercontent.com/Eddpt/EAColourfulProgressView/master/IBInspectable.png)

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

**Note:** In order to have Live Rendering working properly, please install the `Cocoapods 0.36.0.beta.1` or newer, and make sure `use_frameworks!` is added to your `Podfile`. More details [here](http://stackoverflow.com/a/28108248/764822).

##Usage
Set the `Custom Class` of a `UIView` to `EAColourfulProgressView` in Interface Builder, customize the available variables and see them being live rendered ;)

##Future improvements

- Any number of segments
- Segment separators (loading like progress view)
- Performance improvements
