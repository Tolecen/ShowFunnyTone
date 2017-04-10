//
//  CellBoard.m
//  Babypai
//
//  Created by ning on 16/4/25.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "CellBoard.h"
#import "Pin.h"
#import "UIImageView+WebCache.h"

@interface CellBoard()

@property(nonatomic, strong) UIImageView *boardImage;
@property(nonatomic, strong) UILabel *boardName;
@property(nonatomic, strong) UILabel *pinsCount;

@end

@implementation CellBoard

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
    _boardImage = [[UIImageView alloc]initWithImage:ImageNamed(@"baby_set_icn_combo")];
    _boardImage.backgroundColor = UIColorFromRGB(BABYCOLOR_background);
    _boardName = [[UILabel alloc]init];
    _boardName.font = kFontSizeNormal;
    _boardName.textColor = UIColorFromRGB(BABYCOLOR_main_text);
    
    _pinsCount = [[UILabel alloc]init];
    _pinsCount.font = kFontSizeNormal;
    _pinsCount.textColor = UIColorFromRGB(BABYCOLOR_comment_text);
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = UIColorFromRGB(BABYCOLOR_background);
    
    [self.contentView sd_addSubviews:@[_boardImage, _boardName, _pinsCount, bottomLine]];
    
    _boardImage.sd_layout
    .widthIs(60)
    .heightIs(60)
    .leftSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.contentView);
    
    _pinsCount.sd_layout
    .widthIs(200)
    .heightIs(36)
    .leftSpaceToView(_boardImage, 10)
    .topSpaceToView(_boardName, 10);
    
    _boardName.sd_layout
    .leftSpaceToView(_boardImage, 10)
    .topEqualToView(_boardImage)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(26)
    .centerYEqualToView(self.contentView);
    
    bottomLine.sd_layout
    .bottomSpaceToView(self.contentView, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(1);
    
}

- (void)setBoard:(Board *)board
{
    _board = board;
    
    if ([board.pins count] > 0) {
        Pin *pin = board.pins[0];
        [_boardImage sd_setImageWithURL:[Utils getImagePathURL:pin.file tagWith:IMAGE_NOR] placeholderImage:ImageNamed(@"baby_set_icn_combo")];
    } else {
        _boardImage = [[UIImageView alloc]initWithImage:ImageNamed(@"baby_set_icn_combo")];
    }
    _boardName.text = board.title;
    _pinsCount.text = [NSString stringWithFormat:@"%ld条动态", board.pin_count];

}

@end
