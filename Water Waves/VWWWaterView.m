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

@property (nonatomic) CTFontRef fontRef;

@property (nonatomic, assign) BOOL jia;

@property (nonatomic, strong) CADisplayLink *disPlayLink;

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@property (nonatomic, strong) CATextLayer *textLayer;

@property (nonatomic, strong) CATextLayer *textLayer2;

@end

@implementation VWWWaterView

- (instancetype)initWithFrame:(CGRect)frame waterColor:(UIColor *)waterColor font:(UIFont *)font waterLevelY:(CGFloat)waterLevelY
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _waterColor = waterColor;
        _font = font;
        _waterLevelY = waterLevelY;
        
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
    
    self.textLayer = [self createTextLayer:@"小棋神" color:self.waterColor];
    self.textLayer2 = [self createTextLayer:@"小棋神" color:UIColor.whiteColor];
    [self.textLayer addSublayer:self.textLayer2];
    self.textLayer2.mask = self.maskLayer;
    [self.layer addSublayer:self.textLayer];
    
    
    _font = [UIFont systemFontOfSize:100.];
    _a = 1.5;
    _b = 0;
    _jia = NO;
    self.disPlayLink.paused = NO;
    self.fontRef = CTFontCreateWithName((__bridge CFStringRef)_font.fontName, _font.pointSize, NULL);
}

-(void)updateWave
{
    if (_jia) {
        _a += 0.01;
    }else{
        _a -= 0.01;
    }
    
    if (_a<=1) {
        _jia = YES;
    }
    
    if (_a>=1.5) {
        _jia = NO;
    }
    
    _b+=0.1;
    
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
    
    CGFloat waterLevelY = self.waterLevelY * self.bounds.size.height;
    float y = waterLevelY;
    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x = 0; x <= self.bounds.size.width; x++) {
        y = _a * sin(x/180*M_PI + 4*_b/M_PI) * 5 + waterLevelY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, self.bounds.size.width, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, waterLevelY);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    [self updateMaskLayer:path];
    
    CGPathRelease(path);
    //    CGContextRelease(context);
}

- (void)updateMaskLayer:(CGMutablePathRef)p {
//    CATextLayer * text1 = [self createTextLayer:@"小棋神" color:self.waterColor];
//    CATextLayer * text2 = [self createTextLayer:@"小棋神" color:UIColor.whiteColor];
//    [text1 setForegroundColor:self.waterColor.CGColor];
//    [text1 addSublayer:text2];
//
//    self.maskLayer = [[CAShapeLayer alloc] init];
    self.maskLayer.path = p;
//    text2.mask = self.maskLayer;
    
//    self.layer.sublayers = nil;
//    [self.layer addSublayer:text1];
}

- (CATextLayer*)createTextLayer:(NSString*)content color:(UIColor *)color {
    CATextLayer *text = [CATextLayer layer];
    CGRect bound = self.bounds;
    [text setFrame:bound];
    [text setContentsScale:[[UIScreen mainScreen] scale]];
    text.alignmentMode = kCAAlignmentCenter;
    [text setFont:self.fontRef];
    [text setFontSize:_font.pointSize];
    CGFloat textH = [content boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil].size.height;
    CGFloat margin = (self.bounds.size.height - textH) / 2;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraph,NSBaselineOffsetAttributeName:@(-margin)}];
    [attributedStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, content.length)];
    [text setString:attributedStr];
    
    [text setBackgroundColor:[UIColor clearColor].CGColor];
    return text;
}

#pragma mark - setter
- (CADisplayLink *)disPlayLink {
    if (!_disPlayLink) {
        _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave)];
        [_disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _disPlayLink;
}
@end
