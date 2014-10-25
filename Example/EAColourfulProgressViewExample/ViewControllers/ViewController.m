//
//  ViewController.m
//  EAColourfulProgressViewExample
//
//  Created by Eddpt on 25/10/2014.
//  Copyright (c) 2014 xpto. All rights reserved.
//

#import "ViewController.h"
#import "EAColourfulProgressView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet EAColourfulProgressView *progressView;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ViewController


#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5f
                                                target:self
                                              selector:@selector(updateProgressView:)
                                              userInfo:nil
                                               repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
  self.timer = nil;
  
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
  
  [self.progressView updateFillingWithCurrentValue:newCurrentValue];
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

@end
