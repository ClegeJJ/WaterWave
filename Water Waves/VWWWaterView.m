//
//  VWWWaterView.m
//  Water Waves
//
//  Created by Veari_mac02 on 14-5-23.
//  Copyright (c) 2014年 Veari. All rights reserved.
//

#import "VWWWaterView.h"

#import <CoreText/CoreText.h>

@interface VWWWaterView ()
{
    float a;
    float b;
    BOOL jia;
}
@end


@implementation VWWWaterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self setBackgroundColor:[UIColor clearColor]];
    a = 1.5;
    b = 0;
    jia = NO;
    [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
}

-(void)animateWave
{
    if (jia) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    
    if (a<=1) {
        jia = YES;
    }
    
    if (a>=1.5) {
        jia = NO;
    }
    
    b+=0.1;
    
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [self.waterColor CGColor]);
    
    float y = self.waterLevelY;
    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x = 0; x <= 320; x++) {
        y = a * sin(x/180*M_PI + 4*b/M_PI) * 5 + self.waterLevelY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, 320, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.waterLevelY);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    [self.waveDelegate wavePath:path];
    
    CGPathRelease(path);
    //    CGContextRelease(context);
}
@end
