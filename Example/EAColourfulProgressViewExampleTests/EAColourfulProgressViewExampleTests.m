//
//  EAColourfulProgressViewExampleTests.m
//  EAColourfulProgressViewExampleTests
//
//  Created by Eddpt on 25/10/2014.
//  Copyright (c) 2014 xpto. All rights reserved.
//

@import UIKit;
@import XCTest;

#import "EAColourfulProgressView.h"

@interface EAColourfulProgressView (Private)
- (UIColor *)initialSegmentColorForSegmentType:(EAColourfulProgressViewType)segmentType;
- (UIColor *)finalSegmentColorForSegmentType:(EAColourfulProgressViewType)segmentType;

@end

@interface EAColourfulProgressViewExampleTests : XCTestCase
@property (nonatomic, strong) EAColourfulProgressView *progressView;
@end

@implementation EAColourfulProgressViewExampleTests

- (void)setUp
{
  [super setUp];
  self.progressView = [[EAColourfulProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
  self.progressView.borderLineWidth = 4.0f;
  self.progressView.maximumValue = 100;
  self.progressView.currentValue = 10;
}

- (void)tearDown
{
  self.progressView = nil;
  [super tearDown];
}

- (void)testUpdateCurrentValue
{
  NSInteger expectedValue = 12;
  [self.progressView updateToCurrentValue:expectedValue animated:NO];
  NSInteger actualValue = self.progressView.currentValue;
  
  XCTAssert(actualValue == expectedValue, @"Expected the current value to be %zd but got %zd", expectedValue, actualValue);
}

- (void)testInitialAndFinalSegmentColors
{
  UIColor *expectedInitialColor = [UIColor redColor];
  UIColor *expectedOneThirdColor = [UIColor orangeColor];
  UIColor *expectedTwoThirdsColor = [UIColor yellowColor];
  UIColor *expectedFinalColor = [UIColor whiteColor];
  
  self.progressView.initialFillColor = expectedInitialColor;
  self.progressView.oneThirdFillColor = expectedOneThirdColor;
  self.progressView.twoThirdsFillColor = expectedTwoThirdsColor;
  self.progressView.finalFillColor = expectedFinalColor;
  
  UIColor *actualInitialColorSegment0to33 = [self.progressView initialSegmentColorForSegmentType:EAColourfulProgressViewType0to33];
  UIColor *actualInitialColorSegment33to66 = [self.progressView initialSegmentColorForSegmentType:EAColourfulProgressViewType33to66];
  UIColor *actualInitialColorSegment66to100 = [self.progressView initialSegmentColorForSegmentType:EAColourfulProgressViewType66to100];
  
  UIColor *actualFinalColorSegment0to33 = [self.progressView finalSegmentColorForSegmentType:EAColourfulProgressViewType0to33];
  UIColor *actualFinalColorSegment33to66 = [self.progressView finalSegmentColorForSegmentType:EAColourfulProgressViewType33to66];
  UIColor *actualFinalColorSegment66to100 = [self.progressView finalSegmentColorForSegmentType:EAColourfulProgressViewType66to100];
  
  BOOL expectedResultInitialColor = [actualInitialColorSegment0to33 isEqual:expectedInitialColor];
  BOOL expectedResultOneThirdColor = [actualInitialColorSegment33to66 isEqual:expectedOneThirdColor];
  BOOL expectedResultTwoThirdsColor = [actualInitialColorSegment66to100 isEqual:expectedTwoThirdsColor];
  BOOL expectedResultFinalColor = [actualFinalColorSegment66to100 isEqual:expectedFinalColor];

  XCTAssert(expectedResultInitialColor, @"Expected the initial color to be %@ but got %@", expectedInitialColor, actualInitialColorSegment0to33);
  XCTAssert(expectedResultOneThirdColor, @"Expected the one third color to be %@ but got %@", expectedOneThirdColor, actualInitialColorSegment33to66);
  XCTAssert(expectedResultTwoThirdsColor, @"Expected the two thirds color to be %@ but got %@", expectedTwoThirdsColor, actualInitialColorSegment66to100);
  XCTAssert(expectedResultFinalColor, @"Expected the final color to be %@ but got %@", expectedFinalColor, actualFinalColorSegment66to100);

  BOOL expectedOneThirdColorMatch = [actualInitialColorSegment33to66 isEqual:actualFinalColorSegment0to33];
  BOOL expectedTwoThirdColorMatch = [actualInitialColorSegment66to100 isEqual:actualFinalColorSegment33to66];
  
  XCTAssert(expectedOneThirdColorMatch, @"The initial color of segment 33to66 and the final color of segment 0 to 33 should match");
  XCTAssert(expectedTwoThirdColorMatch, @"The initial color of segment 66to100 and the final color of segment 33 to 66 should match");
}

@end
