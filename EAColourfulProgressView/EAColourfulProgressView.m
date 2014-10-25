//
//  EAColourfulProgressView.m
//  EAColourfulProgressViewExample
//
//  Created by Eddpt on 25/10/2014.
//  Copyright (c) 2014 xpto. All rights reserved.
//

#import "EAColourfulProgressView.h"

typedef NS_ENUM(NSInteger, EAColourfulProgressViewType) {
  EAColourfulProgressViewType0to33 = 33,
  EAColourfulProgressViewType33to66 = 66,
  EAColourfulProgressViewType66to100 = 100
};

static NSUInteger const EAColourfulProgressViewLabelTopMargin = 5;
static NSUInteger const EAColourfulProgressViewNumberOfSegments = 3;

@interface EAColourfulProgressView ()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *fillingView;
@property (nonatomic, strong) UILabel *initialLabel;
@property (nonatomic, strong) UILabel *finalLabel;

@property (nonatomic, strong) NSLayoutConstraint *fillingWidthConstraint;
@end

@implementation EAColourfulProgressView


#pragma mark - Lifecycle

- (void)awakeFromNib
{
  [super awakeFromNib];
  
  [self setupView];
}


#pragma mark - IB Live Rendering Preparation

- (void)prepareForInterfaceBuilder
{
  [super prepareForInterfaceBuilder];
  
  [self setupView];
}


#pragma mark - Setup Methods

- (void)setupView
{
  [self setupBackgroundView];
  [self setupFillingView];
  [self setupInitialLabel];
  [self setupFinalLabel];
}

- (void)setupBackgroundView
{
  CGFloat height = ceilf((self.showLabels ? 0.65f : 1.0f) * self.bounds.size.height);
  self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, height)];
  self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
  self.backgroundView.backgroundColor = self.containerColor;
  
  [self addSubview:self.backgroundView];
  
  NSString *visualFormatString = [NSString stringWithFormat:@"V:|-0-[_backgroundView(%@)]->=0-|", @(height)];
  [self addConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:visualFormatString
                        options:0 metrics:nil
                        views:NSDictionaryOfVariableBindings(_backgroundView)]];
  [self addConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-0-[_backgroundView]-0-|"
                        options:0 metrics:nil
                        views:NSDictionaryOfVariableBindings(_backgroundView)]];
  
  self.backgroundView.layer.cornerRadius = self.cornerRadius;
  self.backgroundView.layer.masksToBounds = YES;
}

- (void)setupFillingView
{
  CGFloat borders = 2 * self.borderLineWidth;
  CGFloat width = ceilf((self.backgroundView.bounds.size.width - borders) * self.fractionLeft);
  CGFloat height = (self.backgroundView.bounds.size.height - borders);
  NSString *borderString = @(self.borderLineWidth).stringValue;
  
  self.fillingView = [[UIView alloc] initWithFrame:CGRectMake(self.borderLineWidth, self.borderLineWidth,
                                                              width, height)];
  self.fillingView.translatesAutoresizingMaskIntoConstraints = NO;
  self.fillingView.backgroundColor = self.fillingColor;
  
  [self.backgroundView addSubview:self.fillingView];
  
  NSString *visualFormatString = [NSString stringWithFormat:@"V:|-%@-[_fillingView(%@)]->=%@-|", borderString, @(height), borderString];
  [self.backgroundView addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:visualFormatString
                                       options:0 metrics:nil
                                       views:NSDictionaryOfVariableBindings(_fillingView)]];
  visualFormatString = [NSString stringWithFormat:@"H:|-%@-[_fillingView]->=%@-|", borderString, borderString];
  [self.backgroundView addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:visualFormatString
                                       options:0 metrics:nil
                                       views:NSDictionaryOfVariableBindings(_fillingView)]];
  
  self.fillingWidthConstraint = [NSLayoutConstraint constraintWithItem:self.fillingView
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:0
                                                            multiplier:1
                                                              constant:width];
  [self.fillingView addConstraint:self.fillingWidthConstraint];

  
  self.fillingView.layer.cornerRadius = (width > self.cornerRadius) ? self.cornerRadius : 0;
  self.fillingView.layer.masksToBounds = YES;
}

- (void)setupInitialLabel
{
  if (!self.showLabels) {
    return;
  }
  
  self.initialLabel = [[UILabel alloc] init];
  self.initialLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.initialLabel.text = @"0";
  self.initialLabel.textColor = self.labelTextColor;
  self.initialLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
  self.initialLabel.textAlignment = NSTextAlignmentLeft;
  [self addSubview:self.initialLabel];
  
  NSString *visualFormatString = [NSString stringWithFormat:@"V:|[_backgroundView]-%@-[_initialLabel]|", @(EAColourfulProgressViewLabelTopMargin)];
  [self addConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:visualFormatString
                        options:0 metrics:nil
                        views:NSDictionaryOfVariableBindings(_backgroundView, _initialLabel)]];
  [self addConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-0-[_initialLabel]->=0-|"
                        options:0 metrics:nil
                        views:NSDictionaryOfVariableBindings(_initialLabel)]];
}

- (void)setupFinalLabel
{
  if (!self.showLabels) {
    return;
  }
  
  self.finalLabel = [[UILabel alloc] init];
  self.finalLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.finalLabel.text = [NSString stringWithFormat:@"%zd", self.maximumValue];
  self.finalLabel.textColor = self.labelTextColor;
  self.finalLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
  self.finalLabel.textAlignment = NSTextAlignmentRight;
  [self addSubview:self.finalLabel];
  
  NSString *visualFormatString = [NSString stringWithFormat:@"V:|[_backgroundView]-%@-[_finalLabel]|", @(EAColourfulProgressViewLabelTopMargin)];
  [self addConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:visualFormatString
                        options:0
                        metrics:nil
                        views:NSDictionaryOfVariableBindings(_backgroundView, _finalLabel)]];
  [self addConstraints:[NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-0-[_initialLabel]->=0-[_finalLabel]-0-|"
                        options:0
                        metrics:nil
                        views:NSDictionaryOfVariableBindings(_initialLabel, _finalLabel)]];
}


#pragma mark - Update Filling View

- (void)updateToCurrentValue:(NSInteger)currentValue animated:(BOOL)animated
{
  self.currentValue = currentValue;
  
  CGFloat borders = 2 * self.borderLineWidth;
  CGFloat width = ceilf((self.backgroundView.bounds.size.width - borders) * self.fractionLeft);
  
  self.fillingWidthConstraint.constant = width;
  
  if (animated) {
    [UIView animateWithDuration:0.4f animations:^{
      [self.fillingView layoutIfNeeded];
      self.fillingView.backgroundColor = self.fillingColor;
    }];
  } else {
    self.fillingView.backgroundColor = self.fillingColor;
  }
}


#pragma mark - Private Helpers

- (UIColor *)fillingColor
{
  EAColourfulProgressViewType segmentType = self.segmentTypeForCurrentValue;
  UIColor *initialSegmentColor = [self initialSegmentColorForSegmentType:segmentType];
  UIColor *finalSegmentColor = [self finalSegmentColorForSegmentType:segmentType];
  CGFloat initialRed, initialGreen, initialBlue;
  CGFloat finalRed, finalGreen, finalBlue;
  float segmentFractionLeft = self.segmentFractionLeft;
  
  [initialSegmentColor getRed:&initialRed green:&initialGreen blue:&initialBlue alpha:nil];
  [finalSegmentColor getRed:&finalRed green:&finalGreen blue:&finalBlue alpha:nil];
  
  finalRed = initialRed - (initialRed - finalRed) * segmentFractionLeft;
  finalGreen = initialGreen - (initialGreen - finalGreen) * segmentFractionLeft;
  finalBlue = initialBlue - (initialBlue - finalBlue) * segmentFractionLeft;
  
  return [UIColor colorWithRed:finalRed green:finalGreen blue:finalBlue alpha:0.8f];
}

- (EAColourfulProgressViewType)segmentTypeForCurrentValue
{
  float currentPercentage = self.fractionLeft * 100;
  float segmentFloatSize = ((float)self.maximumValue) / EAColourfulProgressViewNumberOfSegments;
  float segmentIntegerSize = ((NSInteger)self.maximumValue) / ((NSUInteger)EAColourfulProgressViewNumberOfSegments);
  float remainder = segmentFloatSize - segmentIntegerSize;
  
  if (currentPercentage < (EAColourfulProgressViewType0to33 + remainder)) {
    return EAColourfulProgressViewType0to33;
  }
  
  if (currentPercentage < (EAColourfulProgressViewType33to66 + 2 * remainder)) {
    return EAColourfulProgressViewType33to66;
  }
  
  return EAColourfulProgressViewType66to100;
}


- (float)fractionLeft
{
  return [self fractionLeftWithCurrentValueIncluded:YES];
}

- (float)fractionLeftWithCurrentValueIncluded:(BOOL)shouldIncludeCurrentValue
{
  float maximumValue = (float)self.maximumValue;
  maximumValue = ((maximumValue > 0) ? maximumValue : 1);
  
  if (self.currentValue <= 0) {
    return 1;
  }
  
  if (self.currentValue > (maximumValue + 1)) {
    return 0;
  }
  
  return ((maximumValue - (self.currentValue - ((shouldIncludeCurrentValue) ? 1 : 0))) / maximumValue);
}

- (float)segmentFractionLeft
{
  float maximumValue = ((float)self.maximumValue) / EAColourfulProgressViewNumberOfSegments;
  maximumValue = ((maximumValue > 0) ? maximumValue : 1);
  
  float segmentValue = self.currentValue - 1;
  while (segmentValue > maximumValue) {
    segmentValue = segmentValue - maximumValue;
  }
  return ((maximumValue - segmentValue) / maximumValue);
}


#pragma mark - Color choosing

- (UIColor *)finalSegmentColorForSegmentType:(EAColourfulProgressViewType)segmentType
{
  switch (segmentType) {
    case EAColourfulProgressViewType0to33:
      return [self initialSegmentColorForSegmentType:EAColourfulProgressViewType33to66];
      
    case EAColourfulProgressViewType33to66:
      return [self initialSegmentColorForSegmentType:EAColourfulProgressViewType66to100];
      
    case EAColourfulProgressViewType66to100:
      return self.finalFillColor;
  }
  
  return nil;
}

- (UIColor *)initialSegmentColorForSegmentType:(EAColourfulProgressViewType)segmentType
{
  switch (segmentType) {
    case EAColourfulProgressViewType0to33:
      return self.initialFillColor;
      
    case EAColourfulProgressViewType33to66:
      return self.oneThirdFillColor;
      
    case EAColourfulProgressViewType66to100:
      return self.twoThirdsFillColor;
  }
  
  return nil;
}

@end
