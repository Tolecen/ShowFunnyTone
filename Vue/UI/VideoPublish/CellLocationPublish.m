//
//  CellLocationPublish.m
//  Babypai
//
//  Created by ning on 16/5/17.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "CellLocationPublish.h"

@interface CellLocationPublish ()

@property (nonatomic, strong) UILabel *poiName;
@property (nonatomic, strong) UILabel *poiAddress;

@end

@implementation CellLocationPublish

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _poiName = [[UILabel alloc]init];
    _poiName.font = kFontSizeNormal;
    _poiName.textColor = UIColorFromRGB(BABYCOLOR_main_text);
    [self.contentView addSubview:_poiName];
    
    _poiAddress = [[UILabel alloc]init];
    _poiAddress.font = kFontSizeSmall;
    _poiAddress.textColor = UIColorFromRGB(BABYCOLOR_comment_text);
    [self.contentView addSubview:_poiAddress];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = UIColorFromRGB(BABYCOLOR_background);
    [self.contentView addSubview:bottomLine];
    
    _poiName.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    
    _poiAddress.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(_poiName, 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    
    bottomLine.sd_layout
    .bottomSpaceToView(self.contentView, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(1);
}

//- (void)setMAMapPOI:(AMapPOI *)mAMapPOI
//{
//    _mAMapPOI = mAMapPOI;
//    
//    _poiName.text = mAMapPOI.name;
//    _poiAddress.text = mAMapPOI.address;
//}

@end
