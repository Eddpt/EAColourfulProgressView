//
//  EAColourfulProgressView.h
//  EAColourfulProgressViewExample
//
//  Created by Eddpt on 25/10/2014.
//  Copyright (c) 2014 xpto. All rights reserved.
//

@import UIKit;

IB_DESIGNABLE
@interface EAColourfulProgressView : UIView

@property (nonatomic, strong) IBInspectable UIColor *initialFillColor;
@property (nonatomic, strong) IBInspectable UIColor *oneThirdFillColor;
@property (nonatomic, strong) IBInspectable UIColor *twoThirdsFillColor;
@property (nonatomic, strong) IBInspectable UIColor *finalFillColor;

@property (nonatomic, strong) IBInspectable UIColor *containerColor;

@property (nonatomic, strong) IBInspectable UIColor *labelColor;

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic, assign) IBInspectable NSInteger borderLineWidth;

@property (nonatomic, assign) IBInspectable NSInteger currentValue;

@property (nonatomic, assign) IBInspectable NSUInteger maximumValue;

@property (nonatomic, assign) IBInspectable BOOL showLabels;


@end
