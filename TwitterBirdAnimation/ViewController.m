//
//  ViewController.m
//  TwitterBirdAnimation
//
//  Created by Nimit on 22/05/15.
//  Copyright (c) 2015 Nimit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.imageView.image = [UIImage imageNamed:@"twitterscreen.png"];
    [self.view addSubview:self.imageView];
    self.mask = [CALayer new];
    self.mask.contents = (__bridge id)([UIImage imageNamed:@"twitter logo mask"].CGImage);
    self.mask.contentsGravity = kCAGravityResizeAspect;
    self.mask.bounds = CGRectMake(0, 0, 100, 100);
    self.mask.anchorPoint = CGPointMake(0.5, 0.5);
    self.mask.position = CGPointMake(self.imageView.frame.size.width/2, self.imageView.frame.size.height/2);

    self.imageView.layer.mask = self.mask;
    [self animateMask];


    // Override point for customization after application launch.
    self.view.backgroundColor = [UIColor purpleColor];
}
-(void) animateMask{
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    keyFrameAnimation.delegate = self;
    keyFrameAnimation.duration = 1;
    keyFrameAnimation.beginTime = CACurrentMediaTime() + 1; // add delay of 1 sec
    NSValue *initalBounds = [NSValue valueWithCGRect:self.mask.bounds];
    NSValue *secondBounds = [NSValue valueWithCGRect:CGRectMake(0, 0, 90, 90)];
    NSValue *finalBounds = [NSValue valueWithCGRect:CGRectMake(0, 0, 1500, 1500)];
    keyFrameAnimation.values = @[initalBounds,secondBounds,finalBounds];
    keyFrameAnimation.keyTimes = @[@0,@0.3,@1];
    
    keyFrameAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.mask addAnimation:keyFrameAnimation forKey:@"bounds"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag{
    self.imageView.layer.mask = nil;//remove mask when animation completes
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
