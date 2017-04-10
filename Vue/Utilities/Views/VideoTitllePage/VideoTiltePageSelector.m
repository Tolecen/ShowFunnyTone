//
//  VideoTiltePageSelector.m
//  Babypai
//
//  Created by ning on 16/5/19.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "VideoTiltePageSelector.h"
#import "MacroDefinition.h"

@interface VideoTiltePageSelector ()

@property (nonatomic, strong) AVAssetImageGenerator *imageGenerator;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *silderView;
@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic) CGFloat frame_width;
@property (nonatomic) Float64 durationSeconds;

@end

@implementation VideoTiltePageSelector

#define BG_VIEW_BORDERS_SIZE 1.0f


- (id)initWithFrame:(CGRect)frame videoUrl:(NSURL *)videoUrl{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _frame_width = frame.size.width;
        NSLog(@"_frame_width : %f", _frame_width);
        
        _bgView = [[UIControl alloc] initWithFrame:CGRectMake(BG_VIEW_BORDERS_SIZE, 0, _frame_width - BG_VIEW_BORDERS_SIZE * 2, frame.size.height)];
        _bgView.layer.borderColor = [UIColor whiteColor].CGColor;
        _bgView.layer.borderWidth = BG_VIEW_BORDERS_SIZE;
        [self addSubview:_bgView];
        
        _silderView = [[UIControl alloc] initWithFrame:CGRectMake(BG_VIEW_BORDERS_SIZE, 0, frame.size.height - BG_VIEW_BORDERS_SIZE * 2, frame.size.height)];
        _silderView.layer.borderColor = [UIColor redColor].CGColor;
        _silderView.layer.borderWidth = BG_VIEW_BORDERS_SIZE * 2;
        
        [self addSubview:_silderView];
        
        _videoUrl = videoUrl;
        
        _leftPosition = 0;
        
        UIPanGestureRecognizer *centerPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleCenterPan:)];
        [_silderView addGestureRecognizer:centerPan];
        
        [self getMovieFrame];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)delegateNotification
{
    if ([_delegate respondsToSelector:@selector(videoRange:didChangeLeftPosition:withImage:)]){
        
        CMTime timeFrame = CMTimeMakeWithSeconds([self leftPosition], 600);
        self.imageGenerator.maximumSize = CGSizeZero;
        NSError *error;
        CMTime actualTime;
        CGImageRef halfWayImage = [self.imageGenerator copyCGImageAtTime:timeFrame actualTime:&actualTime error:&error];
        
        UIImage *videoScreen = nil;
        if (error == nil) {
            if (isRetina){
                videoScreen = [[UIImage alloc] initWithCGImage:halfWayImage scale:2.0 orientation:UIImageOrientationUp];
            } else {
                videoScreen = [[UIImage alloc] initWithCGImage:halfWayImage];
            }
        }
        
        
        
        [_delegate videoRange:self didChangeLeftPosition:self.leftPosition withImage:videoScreen];
    }
    
}




#pragma mark - Gestures

- (void)handleCenterPan:(UIPanGestureRecognizer *)gesture
{
    
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [gesture translationInView:self];
        
        _leftPosition += translation.x;
        
        if ((_leftPosition + self.bounds.size.height) > _frame_width || _leftPosition < 0){
            _leftPosition -= translation.x;
        }
        
        
        [gesture setTranslation:CGPointZero inView:self];
        
        [self setNeedsLayout];
        
        [self delegateNotification];
        
    }
    
}


- (void)layoutSubviews
{
    
    _silderView.center = CGPointMake(_leftPosition + self.bounds.size.height / 2, self.bounds.size.height / 2);
    
}




#pragma mark - Video

-(void)getMovieFrame{
    
    AVAsset *myAsset = [[AVURLAsset alloc] initWithURL:_videoUrl options:nil];
    self.imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:myAsset];
    
    if (isRetina){
        self.imageGenerator.maximumSize = CGSizeMake(_bgView.frame.size.height*2, _bgView.frame.size.height*2);
    } else {
        self.imageGenerator.maximumSize = CGSizeMake(_bgView.frame.size.height, _bgView.frame.size.height);
    }
    
    int picWidth = self.bounds.size.height;
    
    // First image
    NSError *error;
    CMTime actualTime;
    CGImageRef halfWayImage = [self.imageGenerator copyCGImageAtTime:kCMTimeZero actualTime:&actualTime error:&error];
    if (halfWayImage != NULL) {
        UIImage *videoScreen;
        if (isRetina){
            videoScreen = [[UIImage alloc] initWithCGImage:halfWayImage scale:2.0 orientation:UIImageOrientationUp];
        } else {
            videoScreen = [[UIImage alloc] initWithCGImage:halfWayImage];
        }
        UIImageView *tmp = [[UIImageView alloc] initWithImage:videoScreen];
        CGRect rect=tmp.frame;
        rect.size.width=picWidth;
        tmp.frame=rect;
        [_bgView addSubview:tmp];
        picWidth = tmp.frame.size.width;
        CGImageRelease(halfWayImage);
    }
    
    
    _durationSeconds = CMTimeGetSeconds([myAsset duration]);
    
    int picsCnt = ceil(_bgView.frame.size.width / picWidth);
    
    NSMutableArray *allTimes = [[NSMutableArray alloc] init];
    
    int time4Pic = 0;
    
    // Bug iOS7 - generateCGImagesAsynchronouslyForTimes
    int prefreWidth=0;
    for (int i=1, ii=1; i<picsCnt; i++){
        time4Pic = i*picWidth;
        
        CMTime timeFrame = CMTimeMakeWithSeconds(_durationSeconds*time4Pic/_bgView.frame.size.width, 600);
        
        [allTimes addObject:[NSValue valueWithCMTime:timeFrame]];
        
        
        CGImageRef halfWayImage = [self.imageGenerator copyCGImageAtTime:timeFrame actualTime:&actualTime error:&error];
        
        UIImage *videoScreen;
        if (isRetina){
            videoScreen = [[UIImage alloc] initWithCGImage:halfWayImage scale:2.0 orientation:UIImageOrientationUp];
        } else {
            videoScreen = [[UIImage alloc] initWithCGImage:halfWayImage];
        }
        
        
        
        UIImageView *tmp = [[UIImageView alloc] initWithImage:videoScreen];
        
        
        
        CGRect currentFrame = tmp.frame;
        currentFrame.origin.x = ii*picWidth;
        
        currentFrame.size.width=picWidth;
        prefreWidth+=currentFrame.size.width;
        
        if( i == picsCnt-1){
            currentFrame.size.width-=6;
        }
        tmp.frame = currentFrame;
        int all = (ii+1)*tmp.frame.size.width;
        
        if (all > _bgView.frame.size.width){
            int delta = all - _bgView.frame.size.width;
            currentFrame.size.width -= delta;
        }
        
        ii++;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_bgView addSubview:tmp];
        });
        
        
        
        
        CGImageRelease(halfWayImage);
        
    }
    
    [self delegateNotification];

}




#pragma mark - Properties

- (CGFloat)leftPosition
{
    return _leftPosition * _durationSeconds / _frame_width;
}




#pragma mark - Helpers

- (NSString *)timeToStr:(CGFloat)time
{
    // time - seconds
    NSInteger min = floor(time / 60);
    NSInteger sec = floor(time - min * 60);
    NSString *minStr = [NSString stringWithFormat:min >= 10 ? @"%ld" : @"0%ld", min];
    NSString *secStr = [NSString stringWithFormat:sec >= 10 ? @"%ld" : @"0%ld", sec];
    return [NSString stringWithFormat:@"%@:%@", minStr, secStr];
}

@end
