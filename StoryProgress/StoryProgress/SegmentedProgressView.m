//
//  SegmentedProgressView.m
//  StoryProgress
//
//  Created by Vlad Borovtsov on 15.08.16.
//  Copyright © 2016 Vlad Borovtsov. All rights reserved.
//

#import "SegmentedProgressView.h"

@implementation SegmentedProgressView {
  NSMutableArray <UIProgressView *> *_progressViews;
}

- (void) awakeFromNib {
  [super awakeFromNib];
  [self commonInit];
}

- (instancetype) initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void) commonInit {
  self.backgroundColor = [UIColor clearColor];
  self.autoFillPreviousSegments = YES;
  self.trackTintColor = [UIColor darkGrayColor];
  self.progressTintColor = [UIColor whiteColor];
  self.leftMargin = 0.0f;
  self.rightMargin = 0.0f;
  self.spacing = 3.0f;
  _progressViews = [NSMutableArray array];
}

- (NSUInteger) segmentsCount {
  return _progressViews.count;
}

- (void) setSegmentsCount:(NSUInteger)segmentsCount {
  while (self.segmentsCount != segmentsCount) {
    if (segmentsCount > self.segmentsCount) {
      [_progressViews addObject:[self newProgressView]];
      [self addSubview:[_progressViews lastObject]];
    }
    else {
      [[_progressViews lastObject] removeFromSuperview];
      [_progressViews removeLastObject];
    }
  }
}

- (void) setProgressTintColor:(UIColor *)progressTintColor {
  _progressTintColor = progressTintColor;
  for (UIProgressView *p in _progressViews) {
    p.progressTintColor = progressTintColor;
  }
}

- (void) setTrackTintColor:(UIColor *)trackTintColor {
  _trackTintColor = trackTintColor;
  for (UIProgressView *p in _progressViews) {
    p.trackTintColor = trackTintColor;
  }
}

- (UIProgressView *) newProgressView {
  UIProgressView *result = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
  result.trackTintColor = self.trackTintColor;
  result.progressTintColor = self.progressTintColor;
  return result;
}

- (void) setProgress:(CGFloat)progress ForSegment:(NSUInteger)segmentIndex {
  if (self.autoFillPreviousSegments) {
    for (int i=0; i<_progressViews.count;i++) {
      if (i < segmentIndex) {
        [[_progressViews objectAtIndex:i] setProgress:1.0f];
      }
      else if (i == segmentIndex) {
        [[_progressViews objectAtIndex:i] setProgress:progress];
      }
      else {
        break;
      }
    }
  }
  else {
    [[_progressViews objectAtIndex:segmentIndex] setProgress:progress];
  }
}

- (CGFloat) progressForSegment:(NSUInteger)segmentIndex {
  return [[_progressViews objectAtIndex:segmentIndex] progress];
}

- (void) layoutSubviews {
  [super layoutSubviews];
  
  CGFloat progressW = (self.frame.size.width - self.leftMargin - self.rightMargin - ([self segmentsCount]-1)*self.spacing) / self.segmentsCount;
  for (int i=0; i<self.segmentsCount;i++) {
    CGRect f = (CGRect){
      self.leftMargin + (progressW+self.spacing)*i,
      0,
      progressW,
      self.frame.size.height
    };
    [[_progressViews objectAtIndex:i] setFrame:f];
  }
}

- (void) setLeftMargin:(CGFloat)leftMargin {
  _leftMargin = leftMargin;
  [self setNeedsLayout];
}

- (void) setRightMargin:(CGFloat)rightMargin {
  _rightMargin = rightMargin;
  [self setNeedsLayout];
}

- (void) setSpacing:(CGFloat)spacing {
  _spacing = spacing;
  [self setNeedsLayout];
}

@end
