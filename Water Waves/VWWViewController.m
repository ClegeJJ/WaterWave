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

@interface VWWViewController ()

@property (strong, nonatomic) VWWWaterView *wview;

@property (nonatomic) UIFont *font;
@property (nonatomic) CTFontRef fontRef;
@end

@implementation VWWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fontRef = CTFontCreateWithName((__bridge CFStringRef)_font.fontName, _font.pointSize, NULL);
    [self customWaterWave];
    
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    //choose some text
    NSString *text = @"abc";
    
    //set layer text
    textLayer.string = text;
    
    
    
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, 100, 100);
    view.backgroundColor = [UIColor redColor];
    view.layer.sublayers = nil;
    [view.layer addSublayer:textLayer];
    
    textLayer.frame = view.bounds;
    textLayer.alignmentMode = kCAAlignmentCenter;
    
    [self.view addSubview:view];
    
}

- (void)customWaterWave {
    self.wview = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 200, 50, 50) waterColor:[UIColor blueColor] font:[UIFont systemFontOfSize:15] waterLevelY:0.5];
//    self.wview.font = [UIFont systemFontOfSize:15];
//    self.wview.waterColor = [UIColor blueColor];
//    self.wview.waterLevelY = 0.5;
    
    [self.view addSubview:self.wview];
}

 
@end
