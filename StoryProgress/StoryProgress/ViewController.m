//
//  ViewController.m
//  StoryProgress
//
//  Created by Vlad Borovtsov on 15.08.16.
//  Copyright © 2016 Vlad Borovtsov. All rights reserved.
//

#import "ViewController.h"
#import "SegmentedProgressView.h"

@interface ViewController ()
@property (nonatomic, strong) IBOutlet SegmentedProgressView *progress;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor blackColor];
  // Do any additional setup after loading the view, typically from a nib.
  
  //self.progress = [[SegmentedProgressView alloc] init];
  //self.progress.frame = CGRectMake(0, 100, self.view.bounds.size.width, 50);
  self.progress.segmentsCount = 2;
  //[self.view addSubview:self.progress];
  self.progress.leftMargin = 5.0f;
  self.progress.rightMargin = 5.0f; 
 

  /*
  self.progress = [[SegmentedProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
  
  
  [self.progress setTrackTintColor:[UIColor darkGrayColor]];
  [self.progress setProgressTintColor:[UIColor whiteColor]];
  
  [self.progress setFrame:CGRectMake(10, 100, 100,50)];
  
  self.progress.progress = 0;
  
  self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(prog) userInfo:nil repeats:YES];
   */
}

- (void) prog1_tick {
  self.progress.autoFillPreviousSegments = YES; 
  for (int i=0; i<self.progress.segmentsCount;i++) {
    if ([self.progress progressForSegment:i] < 1.0f) {
      [self.progress setProgress:[self.progress progressForSegment:i]+0.01 ForSegment:i];
      break;
    }
  }
}

- (void) prog2_tick {
  self.progress.autoFillPreviousSegments = NO;
  NSInteger segment = arc4random() % self.progress.segmentsCount;
  [self.progress setProgress:[self.progress progressForSegment:segment]+0.01 ForSegment:segment];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (IBAction) addSegment {
  self.progress.segmentsCount++;
}

- (IBAction)removeSegment:(id)sender {
  self.progress.segmentsCount--;
}

- (IBAction)prog1:(id)sender {
  [self.timer invalidate];
  self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(prog1_tick) userInfo:nil repeats:YES];
}

- (IBAction)prog2:(id)sender {
  [self.timer invalidate];
  self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(prog2_tick) userInfo:nil repeats:YES];
}

- (IBAction) reset:(id) sender {
  [self.timer invalidate];
  self.progress.segmentsCount = 1;
  [self.progress setProgress:0 ForSegment:0];
}

@end
