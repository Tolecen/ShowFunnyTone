//
//  VideoTiltePageSelector.h
//  Babypai
//
//  Created by ning on 16/5/19.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>


@protocol VideoTiltePageSelectorDelegate;

@interface VideoTiltePageSelector : UIView


@property (nonatomic, weak) id <VideoTiltePageSelectorDelegate> delegate;
@property (nonatomic) CGFloat leftPosition;

- (id)initWithFrame:(CGRect)frame videoUrl:(NSURL *)videoUrl;


@end


@protocol VideoTiltePageSelectorDelegate <NSObject>

@optional

- (void)videoRange:(VideoTiltePageSelector *)videoRange didChangeLeftPosition:(CGFloat)leftPosition withImage:(UIImage *)image;

@end
