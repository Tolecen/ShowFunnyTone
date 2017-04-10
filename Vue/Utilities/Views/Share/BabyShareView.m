//
//  BabyShareView.m
//  Babypai
//
//  Created by ning on 15/4/16.
//  Copyright (c) 2015年 Babypai. All rights reserved.
//

#import "BabyShareView.h"
#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "ALDBlurImageProcessor.h"
#import "MacroDefinition.h"

@interface BabyShareView()

@property (nonatomic, strong) ALDBlurImageProcessor *blurImageProcessor;

@end

@implementation BabyShareView

- (instancetype)initWidthPin:pin
{
    
    _pin = pin;
    
    CGRect viewFrame = CGRectMake(0, 0, viewW, viewH);
    self = [super initWithFrame:viewFrame];
    
    if (self) {
        
        _logoImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_logo_basecolor")];
        _bgImageView = [[UIImageView alloc] initWithFrame:viewFrame];
        _bgImageView.layer.cornerRadius = 6;
        [self addSubview:_bgImageView];
        [self addSubview:_logoImageView];
        
        self.weixinButton = [GXCustomButton buttonWithType:UIButtonTypeCustom];
        self.pyqButton = [GXCustomButton buttonWithType:UIButtonTypeCustom];
        self.qqButton = [GXCustomButton buttonWithType:UIButtonTypeCustom];
        self.qzoneButton = [GXCustomButton buttonWithType:UIButtonTypeCustom];
        self.sinaButton = [GXCustomButton buttonWithType:UIButtonTypeCustom];
        self.linkscopyButton = [GXCustomButton buttonWithType:UIButtonTypeCustom];
        
        _closeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_close_nor"]];
        [_closeView setHighlightedImage:ImageNamed(@"icon_close_pre")];
        _closeView.frame = CGRectMake(-10, -10, 26, 26);
        
        _closeView.layer.shadowColor = [UIColor blackColor].CGColor;
        _closeView.layer.shadowOffset = CGSizeZero;
        _closeView.layer.shadowOpacity = 0.3;
        _closeView.layer.shadowRadius = 2.0;
        
//        
//        if ([WeiboSDK isWeiboAppInstalled]) {
//            self.sinaButton.hidden = NO;
//        } else {
//            self.sinaButton.hidden = YES;
//        }
//        
//        if ([WXApi isWXAppInstalled]) {
//            self.weixinButton.hidden = NO;
//            self.pyqButton.hidden = NO;
//        } else {
//            self.weixinButton.hidden = YES;
//            self.pyqButton.hidden = NO;
//        }
//        
//        if ([QQApiInterface isQQInstalled]) {
//            self.qzoneButton.hidden = NO;
//            self.qqButton.hidden = NO;
//        } else {
//            self.qzoneButton.hidden = YES;
//            self.qqButton.hidden = YES;
//        }
        
        [_closeView setContentMode:UIViewContentModeScaleAspectFit];
        
        _closeView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeClick)];
        [_closeView addGestureRecognizer:singleTap];
        
        [self addSubview:_closeView];
        
        [self imgageBackground];
        
        
        [self sd_addSubviews:@[self.weixinButton, self.pyqButton, self.sinaButton, self.qqButton, self.qzoneButton, self.linkscopyButton]];
        
        self.sd_equalWidthSubviews = @[self.qqButton, self.qzoneButton, self.linkscopyButton];
        
        self.logoImageView.sd_layout
        .centerXEqualToView(self)
        .topSpaceToView(self, 20)
        .widthIs(120);
        
        
        self.qqButton.sd_layout
        .leftSpaceToView(self, 0)
        .bottomSpaceToView(self, 10)
        .heightIs(60);
        
        self.qzoneButton.sd_layout
        .leftSpaceToView(self.qqButton, 0)
        .topEqualToView(self.qqButton)
        .heightIs(60);
        
        self.linkscopyButton.sd_layout
        .leftSpaceToView(self.qzoneButton, 0)
        .topEqualToView(self.qzoneButton)
        .rightSpaceToView(self, 0)
        .heightIs(60);
        
        self.weixinButton.sd_layout
        .leftSpaceToView(self, 0)
        .bottomSpaceToView(self.qqButton, 0)
        .rightEqualToView(self.qqButton)
        .heightIs(60);
        
        self.pyqButton.sd_layout
        .leftSpaceToView(self.weixinButton, 0)
        .rightEqualToView(self.qzoneButton)
        .topEqualToView(self.weixinButton)
        .heightIs(60);
        
        self.sinaButton.sd_layout
        .leftSpaceToView(self.pyqButton, 0)
        .topEqualToView(self.pyqButton)
        .rightSpaceToView(self, 0)
        .heightIs(60);
        
        
        [self creatButtonWithNormalName:self.weixinButton andName:@"baby_mlogo2_weixin"andSelectName:@"baby_mlogo2_weixin"andTitle:@"微信"andIndex:SHARE_WEIXIN];
        [self creatButtonWithNormalName:self.pyqButton andName:@"baby_mlogo2_pyq"andSelectName:@"baby_mlogo2_pyq"andTitle:@"朋友圈"andIndex:SHARE_PYQ];
        [self creatButtonWithNormalName:self.qqButton andName:@"baby_mlogo2_qq"andSelectName:@"baby_mlogo2_qq"andTitle:@"QQ好友" andIndex:SHARE_QQ];
        [self creatButtonWithNormalName:self.qzoneButton andName:@"baby_mlogo2_qzone"andSelectName:@"baby_mlogo2_qzone"andTitle:@"QQ空间"andIndex:SHARE_QZONE];
        [self creatButtonWithNormalName:self.sinaButton andName:@"baby_mlogo2_sina"andSelectName:@"baby_mlogo2_sina"andTitle:@"微博"andIndex:SHARE_SINA];
        [self creatButtonWithNormalName:self.linkscopyButton andName:@"baby_mlogo2_to_copy"andSelectName:@"baby_mlogo2_to_copy"andTitle:@"复制链接"andIndex:SHARE_LINK];
        
        
    }
    
    
    return self;
}

- (void)closeClick
{
    self.closeButtonHandler();
}

- (void)setIsUpload:(BOOL)isUpload
{
    if (isUpload) {
        _logoImageView.image = ImageNamed(@"ic_published_basecolor");
    } else {
        _logoImageView.image = ImageNamed(@"ic_logo_basecolor");
    }
}


#pragma mark 创建一个按钮
- (void)creatButtonWithNormalName:(GXCustomButton *)button andName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index
{
    button.tag = index;
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selected] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(BABYCOLOR_main_text) forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    button.imageView.contentMode = UIViewContentModeCenter; // 让图片在按钮内居中
    button.titleLabel.textAlignment = NSTextAlignmentCenter; // 让标题在按钮内居中
    button.titleLabel.font = kFontSizeSmall;// 设置标题的字体大小
    [button setTintColor:UIColorFromRGB(BABYCOLOR_base_color)];
}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(GXCustomButton *)sender
{
    NSString *shareUrl = [NSString stringWithFormat:@"%@/pins/%ld", HOST, _pin.pin_id];
    NSString *shareTitle = [NSString stringWithFormat:@"%@的萌宝拍", _pin.user.username];
    NSString *shareDes;
    
    if (_pin.raw_text.length > 0) {
        shareDes = [NSString stringWithFormat:@"分享%@的萌宝拍“%@”，小伙伴们，快来围观！>> ", _pin.user.username, _pin.raw_text];
    } else {
        shareDes = [NSString stringWithFormat:@"分享%@的萌宝拍，小伙伴们，快来围观！>> ", _pin.user.username];
    }
    
    NSString *shareImageUrl = [Utils getImagePath:_pin.file tagWith:IMAGE_BIG];
    
    if (self.shareViewPin) {
        _shareViewPin([sender tag], shareTitle, shareDes, shareUrl, shareImageUrl, self.bgImage);
    }
}

- (void)imgageBackground
{
    
    [_bgImageView sd_setImageWithURL:[Utils getImagePathURL:_pin.file tagWith:nil] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.bgImage = image;
        _blurImageProcessor = [[ALDBlurImageProcessor alloc] initWithImage: self.bgImageView.image];
        [_blurImageProcessor asyncBlurWithRadius: 10
                                      iterations: 7
                                    successBlock: ^( UIImage *blurredImage) {
                                        self.bgImageView.image = blurredImage;
                                    }
                                      errorBlock: ^( NSNumber *errorCode ) {
                                          NSLog( @"Error code: %d", [errorCode intValue] );
                                      }];
    }];
    
}


@end
