//
//  BabyShareView.h
//  Babypai
//
//  Created by ning on 15/4/16.
//  Copyright (c) 2015年 Babypai. All rights reserved.
//

#define viewW 280
#define viewH 280

#import "GXCustomButton.h"
#import "Pin.h"

@class Pin;

@interface BabyShareView : UIView

- (instancetype) initWidthPin:(Pin *) pin;

@property (nonatomic, assign) BOOL isUpload;

@property (nonatomic, strong) Pin *pin;

@property (nonatomic, strong) GXCustomButton *weixinButton;

@property (nonatomic, strong) GXCustomButton *pyqButton;

@property (nonatomic, strong) GXCustomButton *qqButton;

@property (nonatomic, strong) GXCustomButton *qzoneButton;

@property (nonatomic, strong) GXCustomButton *sinaButton;

@property (nonatomic, strong) GXCustomButton *linkscopyButton;

@property (nonatomic, strong) UIImageView *closeView;

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIImage *bgImage;

@property (nonatomic,strong)void(^closeButtonHandler)();

@property (nonatomic, copy)void(^shareViewPin) (NSInteger shareTo, NSString *shareTitle, NSString *shareDes, NSString *shareUrl, NSString *shareImageUrl, UIImage *shareImage);

@end
