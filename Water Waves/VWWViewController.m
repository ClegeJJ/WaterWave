//
//  VWWViewController.m
//  Water Waves
//
//  Created by Veari_mac02 on 14-5-23.
//  Copyright (c) 2014年 Veari. All rights reserved.
//

#import "VWWViewController.h"
#import "VWWWaterView.h"
#import <CoreText/CoreText.h>

@interface VWWViewController ()<ZLWavePathDelegate>

@property (weak, nonatomic) IBOutlet VWWWaterView *wview;

@property (nonatomic) UIFont *font;
@property (nonatomic) UIView *labelView;
@property (nonatomic) CAShapeLayer * maskLayer;
@property (nonatomic) CTFontRef fontRef;
@end

@implementation VWWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fontRef = CTFontCreateWithName((__bridge CFStringRef)_font.fontName, _font.pointSize, NULL);
    [self customWaterWave];
    [self customLables];
    self.wview.waveDelegate = self;
}

- (void)customWaterWave {
    self.wview.waterColor = [UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1];
    self.wview.waterLevelY = 50.f;
}

- (void)customLables {
    _font = [UIFont systemFontOfSize:100.];
    _labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    [self.wview addSubview:_labelView];
}

#pragma mark - Update Text Layer
- (void)updateMaskLayer:(CGMutablePathRef)p {
    CATextLayer * text1 = [self createTextLayer:@"hello"];
    CATextLayer * text2 = [self createTextLayer:@"hello"];
    [text1 setForegroundColor:self.wview.waterColor.CGColor];
    [text1 addSublayer:text2];
    
    self.maskLayer = [[CAShapeLayer alloc] init];
    self.maskLayer.path = p;
    text2.mask = self.maskLayer;
    
    self.labelView.layer.sublayers = nil;
    [self.labelView.layer addSublayer:text1];
}

- (CATextLayer*)createTextLayer:(NSString*)content {
    CATextLayer *text = [CATextLayer layer];
    CGRect bound = _labelView.bounds;
    bound.origin.y = bound.origin.y;
    [text setFrame:bound];
    [text setString:(id)content];
    [text setFont:self.fontRef];
    [text setFontSize:_font.pointSize];
    
    [text setForegroundColor:[UIColor whiteColor].CGColor];
    [text setContentsScale:[[UIScreen mainScreen] scale]];
    [text setBackgroundColor:[UIColor clearColor].CGColor];
    return text;
}

#pragma mark ZLWavePathDelegate
- (void)wavePath:(CGMutablePathRef)path {
    [self updateMaskLayer:path];
}
@end
