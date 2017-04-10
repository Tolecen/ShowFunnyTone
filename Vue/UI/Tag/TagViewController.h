//
//  TagViewController.h
//  Babypai
//
//  Created by ning on 16/4/12.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "BabyBaseVC.h"
#import "DetailsPageView.h"
#import "Tag.h"
#import "Pins.h"

@interface TagViewController : BabyBaseVC

@property (nonatomic, strong) DetailsPageView *detailsPageView;

@property (nonatomic, strong) UILabel *navBarTitleLabel;
@property (nonatomic, strong) UIView *navBarView;
@property (nonatomic, strong) UIImageView *navBarBg;

@property (nonatomic, strong) Tag *tag;
@property (nonatomic, strong) Pins *pins;
@property (nonatomic, strong) NSString *tagString;
@property (nonatomic, assign) long tag_id;


@end
