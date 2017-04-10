//
//  UserViewController.h
//  Babypai
//
//  Created by ning on 15/4/19.
//  Copyright (c) 2015年 Babypai. All rights reserved.
//

#import "DetailsPageView.h"
#import "UserInfomation.h"
#import "UserInfoNoPin.h"
#import "BabyBaseVC.h"

@interface UserViewController : BabyBaseVC

@property (nonatomic, strong) DetailsPageView *detailsPageView;

@property (nonatomic, strong) UserInfomation *userInfomation;

@property (nonatomic, strong) UILabel *navBarTitleLabel;
@property (nonatomic, strong) UIView *navBarView;
@property (nonatomic, strong) UIImageView *navBarBg;

@property (nonatomic, strong) UserInfoNoPin *user;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, assign) long userId;

@end
