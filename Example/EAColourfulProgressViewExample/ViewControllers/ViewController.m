//
//  ViewController.m
//  EAColourfulProgressViewExample
//
//  Created by Eddpt on 25/10/2014.
//  Copyright (c) 2014 xpto. All rights reserved.
//

#import "ViewController.h"
#import "EAColourfulProgressView.h"

@import CoreGraphics;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet EAColourfulProgressView *progressView;
@property (weak, nonatomic) IBOutlet EAColourfulProgressView *tinyProgressView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timer2;
@end

@implementation ViewController


#pragma mark - Lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  CAGradientLayer *gradientLayer = [CAGradientLayer layer];
  gradientLayer.colors = @[(id)[UIColor colorWithRed:0 green:150/255.0f blue:53/255.0f alpha:0.6f].CGColor,
                           (id)[UIColor colorWithRed:0 green:116/255.0 blue:94/255.0f alpha:0.6f].CGColor,
                           (id)[UIColor colorWithRed:0 green:76/255.0f blue:58/255.0f alpha:0.6f].CGColor];
  CAGradientLayer *backgroundLayer = gradientLayer;
  backgroundLayer.frame = self.view.bounds;
  [self.view.layer insertSublayer:backgroundLayer atIndex:0];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5f
                                                target:self
                                              selector:@selector(updateProgressView:)
                                              userInfo:nil
                                               repeats:YES];
  self.timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                 target:self
                                               selector:@selector(updateTinyProgressView:)
                                               userInfo:nil
                                                repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
  self.timer = self.timer2 = nil;
  
  [super viewWillDisappear:animated];
}


#pragma mark - Helpers

- (void)updateProgressView:(NSTimer *)timer
{
  NSInteger newCurrentValue;
  
  if (self.progressView.currentValue == 0) {
    newCurrentValue = self.progressView.maximumValue;
  } else {
    newCurrentValue = self.progressView.currentValue - 1;
  }
  
  [self.progressView updateToCurrentValue:newCurrentValue animated:YES];
}

- (void)updateTinyProgressView:(NSTimer *)timer
{
  NSInteger newCurrentValue;
  
  if (self.tinyProgressView.currentValue == 0) {
    newCurrentValue = self.tinyProgressView.maximumValue;
  } else {
    newCurrentValue = self.tinyProgressView.currentValue - 1;
  }
  
  [self.tinyProgressView updateToCurrentValue:newCurrentValue animated:YES];
}

#pragma mark - Getters & Setters

- (void)setTimer:(NSTimer *)timer
{
  if (timer == _timer) {
    return;
  }
  
  [_timer invalidate];
  _timer = timer;
}

- (void)setTimer2:(NSTimer *)timer2
{
  if (timer2 == _timer2) {
    return;
  }
  
  [_timer2 invalidate];
  _timer2 = timer2;
}

@end
