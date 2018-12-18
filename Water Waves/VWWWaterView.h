//
//  VWWWaterView.h
//  Water Waves
//
//  Created by Veari_mac02 on 14-5-23.
//  Copyright (c) 2014年 Veari. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLWavePathDelegate <NSObject>

- (void)wavePath:(CGMutablePathRef)path;
@end

@interface VWWWaterView : UIView

@property (nonatomic, strong) UIColor *waterColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) CGFloat waterLevelY;
@property (nonatomic, assign) CGFloat a;
@property (nonatomic, assign) CGFloat b;
@property (nonatomic, weak) id<ZLWavePathDelegate> waveDelegate;

- (instancetype)initWithFrame:(CGRect)frame waterColor:(UIColor *)waterColor font:(UIFont *)font waterLevelY:(CGFloat)waterLevelY;

@end
