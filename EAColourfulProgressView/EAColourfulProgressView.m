//
//  EAColourfulProgressView.m
//  EAColourfulProgressViewExample
//
//  Created by Eddpt on 25/10/2014.
//  Copyright (c) 2014 xpto. All rights reserved.
//

#import "EAColourfulProgressView.h"

static NSUInteger const EAColourfulProgressViewTopMargin = 5;
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
  [self addSubview:self.backgroundView];
  
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[backgroundView(bvHeight)]->=0-|"
                                                               options:0 metrics:self.viewMetrics views:self.viewsDictionary]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[backgroundView]-0-|"
                                                               options:0 metrics:nil views:self.viewsDictionary]];
  
  self.backgroundView.layer.cornerRadius = self.cornerRadius;
  self.backgroundView.layer.masksToBounds = YES;
}

- (void)setupFillingView
{
  [self.backgroundView addSubview:self.fillingView];
  
  [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-bPadding-[fillingView(fvHeight)]->=bPadding-|"
                                                                              options:0 metrics:self.viewMetrics views:self.viewsDictionary]];
  [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-bPadding-[fillingView]->=bPadding-|"
                                                                              options:0 metrics:self.viewMetrics views:self.viewsDictionary]];
  
  self.fillingWidthConstraint = [NSLayoutConstraint constraintWithItem:self.fillingView
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual toItem:nil attribute:0
                                                            multiplier:1 constant:self.fillingViewWidth];
  [self.fillingView addConstraint:self.fillingWidthConstraint];
  
  
  self.fillingView.layer.cornerRadius = (self.fillingViewWidth > self.cornerRadius) ? self.cornerRadius : 0;
  self.fillingView.layer.masksToBounds = YES;
}

- (void)setupInitialLabel
{
  if (!self.showLabels) {
    return;
  }
  
  [self addSubview:self.initialLabel];
  
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundView]-mPadding-[initialLabel]|"
                                                               options:0 metrics:self.viewMetrics views:self.viewsDictionary]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[initialLabel]->=0-|"
                                                               options:0 metrics:nil views:self.viewsDictionary]];
}

- (void)setupFinalLabel
{
  if (!self.showLabels) {
    return;
  }
  
  [self addSubview:self.finalLabel];
  
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundView]-mPadding-[finalLabel]|"
                                                               options:0 metrics:self.viewMetrics views:self.viewsDictionary]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[initialLabel]->=0-[finalLabel]-0-|"
                                                               options:0 metrics:nil views:self.viewsDictionary]];
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
  float maximumValue = (float)self.maximumValue;
  maximumValue = ((maximumValue > 0) ? maximumValue : 1);
  
  if (self.currentValue <= 0) {
    return 1;
  }
  
  if (self.currentValue > (maximumValue + 1)) {
    return 0;
  }
  
  return ((maximumValue - (self.currentValue - 1))) / maximumValue;
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


#pragma mark - Auto Layout Helpers

- (NSDictionary *)viewsDictionary
{
  NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(self.backgroundView, self.fillingView, self.initialLabel, self.finalLabel);
  NSMutableDictionary *viewsMutableDictionary = [NSMutableDictionary dictionary];
  
  [viewsDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
    NSString *strippedKey = [key stringByReplacingOccurrencesOfString:@"self." withString:@""];
    viewsMutableDictionary[strippedKey] = obj;
  }];
  
  return viewsMutableDictionary.copy;
}

- (NSDictionary *)viewMetrics
{
  return @{ @"bPadding" : @(self.borderLineWidth), @"mPadding" : @(EAColourfulProgressViewTopMargin),
            @"bvHeight" : @(self.backgroundViewHeight), @"fvHeight" : @(self.fillingViewHeight) };
}

- (CGFloat)backgroundViewHeight
{
  return ceilf((self.showLabels ? 0.65f : 1.0f) * self.bounds.size.height);
}

- (CGFloat)fillingViewHeight
{
  return (self.backgroundView.bounds.size.height - self.borders);
}

- (CGFloat)fillingViewWidth
{
  return ceilf((self.backgroundView.bounds.size.width - self.borders) * self.fractionLeft);
}

- (CGFloat)borders
{
  return 2 * self.borderLineWidth;
}


#pragma mark - Lazy Initializers

- (UIView *)backgroundView
{
  if (!_backgroundView) {
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.backgroundViewHeight)];
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundView.backgroundColor = self.containerColor;
  }
  
  return _backgroundView;
}

- (UIView *)fillingView
{
  if (!_fillingView) {
    self.fillingView = [[UIView alloc] initWithFrame:CGRectMake(self.borderLineWidth, self.borderLineWidth,
                                                                self.fillingViewWidth, self.fillingViewHeight)];
    self.fillingView.translatesAutoresizingMaskIntoConstraints = NO;
    self.fillingView.backgroundColor = self.fillingColor;
  }
  
  return _fillingView;
}

- (UILabel *)initialLabel
{
  if (!_initialLabel) {
    self.initialLabel = [[UILabel alloc] init];
    self.initialLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.initialLabel.text = @"0";
    self.initialLabel.textColor = self.labelTextColor;
    self.initialLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    self.initialLabel.textAlignment = NSTextAlignmentLeft;
  }
  
  return _initialLabel;
}

- (UILabel *)finalLabel
{
  if (!_finalLabel) {
    self.finalLabel = [[UILabel alloc] init];
    self.finalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.finalLabel.text = [NSString stringWithFormat:@"%zd", self.maximumValue];
    self.finalLabel.textColor = self.labelTextColor;
    self.finalLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    self.finalLabel.textAlignment = NSTextAlignmentRight;
  }
  
  return _finalLabel;
}


#pragma mark - Color choosing

- (UIColor *)finalSegmentColorForSegmentType:(EAColourfulProgressViewType)segmentType
{
  switch (segmentType) {
    case EAColourfulProgressViewType0to33:
      return [self initialSegmentColorForSegmentType:EAColourfulProgressViewType33to66];
      
    case EAColourfulProgressViewType33to66:
      return [self initialSegmentColorForSegmentType:EAColourfulProgressViewType66to100];
      
    case EAColourfulProgressViewType66to100: return self.finalFillColor;
  }
  
  return nil;
}

- (UIColor *)initialSegmentColorForSegmentType:(EAColourfulProgressViewType)segmentType
{
  switch (segmentType) {
    case EAColourfulProgressViewType0to33: return self.initialFillColor;
    case EAColourfulProgressViewType33to66: return self.oneThirdFillColor;
    case EAColourfulProgressViewType66to100: return self.twoThirdsFillColor;
  }
  
  return nil;
}

@end
