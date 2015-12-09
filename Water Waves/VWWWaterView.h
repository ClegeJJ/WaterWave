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

@property (nonatomic) UIColor *waterColor;
@property (nonatomic) float waterLevelY;
@property (nonatomic, weak) id<ZLWavePathDelegate> waveDelegate;
@end
