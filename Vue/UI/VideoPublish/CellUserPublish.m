//
//  CellUserPublish.m
//  Babypai
//
//  Created by ning on 16/5/10.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "CellUserPublish.h"
#import "UIImageView+WebCache.h"

@interface CellUserPublish()

@property(nonatomic, strong) UIImageView *avatar;
@property(nonatomic, strong) UILabel *userName;
@property(nonatomic, strong) UIButton *addFollow;

@end

@implementation CellUserPublish

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setup];
    }
    
    return self;
    
}

- (void)setup
{
    _avatar = [[UIImageView alloc]initWithImage:ImageNamed(@"avatar")];
    
    _userName = [[UILabel alloc]init];
    _userName.font = kFontSizeNormal;
    _userName.textColor = UIColorFromRGB(BABYCOLOR_main_text);
    
    _addFollow = [[UIButton alloc]init];
    [_addFollow setImage:ImageNamed(@"baby_list_checkbox") forState:UIControlStateNormal];
    [_addFollow setImage:ImageNamed(@"baby_list_checkbox_ok") forState:UIControlStateSelected];
    [_addFollow addTarget:self action:@selector(pressAddButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = UIColorFromRGB(BABYCOLOR_background);
    
    [self.contentView sd_addSubviews:@[_avatar, _userName, _addFollow, bottomLine]];
    
    _avatar.sd_layout
    .widthIs(40)
    .heightIs(40)
    .leftSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.contentView);
    _avatar.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    _addFollow.sd_layout
    .widthIs(30)
    .heightIs(30)
    .rightSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.contentView);
    
    _userName.sd_layout
    .leftSpaceToView(_avatar, 10)
    .rightSpaceToView(_addFollow, 10)
    .heightIs(36)
    .centerYEqualToView(self.contentView);
    
    bottomLine.sd_layout
    .bottomSpaceToView(self.contentView, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(1);
    
}

- (void)pressAddButton
{
    if (self.followClicked) {
        self.followClicked(_cellIndex, _userInfo);
    }
}

- (void)setUserInfo:(UserInfo *)userInfo
{
    _userInfo = userInfo;
    [_avatar sd_setImageWithURL:[Utils getImagePathURL:userInfo.avatar tagWith:IMAGE_NOR] placeholderImage:ImageNamed(@"avatar")];
    
    _userName.text = userInfo.username;
    DLog(@"_isSelected ---- %d", _isSelected);
    _addFollow.selected = _isSelected;
    DLog(@"_addFollow.selected ---- %d", _addFollow.selected);
    
}

@end
