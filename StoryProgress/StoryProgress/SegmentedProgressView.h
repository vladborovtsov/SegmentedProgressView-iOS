//
//  SegmentedProgressView.h
//  StoryProgress
//
//  Created by Vlad Borovtsov on 15.08.16.
//  Copyright © 2016 Vlad Borovtsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentedProgressView : UIView

@property (nonatomic, assign) CGFloat spacing;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat rightMargin;

@property (nonatomic, readwrite) NSUInteger segmentsCount;
@property (nonatomic, assign) BOOL autoFillPreviousSegments;

@property (nonatomic, strong) UIColor *trackTintColor;
@property (nonatomic, strong) UIColor *progressTintColor;

- (void) setProgress:(CGFloat) progress ForSegment:(NSUInteger) segmentIndex;
- (CGFloat) progressForSegment:(NSUInteger) segmentIndex;
@end
