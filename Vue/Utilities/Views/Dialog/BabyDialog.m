//
//  BabyDialog.m
//  Babypai
//
//  Created by ning on 16/4/24.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "BabyDialog.h"
#import "UIButton+Extension.h"
#import "UIView+SDAutoLayout.h"
#import "MLLinkLabel.h"
#import "NSAttributedString+MLLabel.h"

@implementation BabyDialog

- (id)initWithTitle:(NSString *)title whitCancelText:(NSString *)cancel withSubmitText:(NSString *)submit withContentText:(NSString *)content isFlip:(bool) flip
{
    CGRect frame = CGRectMake(0, 0, dialogW, dialogH);
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupWithTitle:title whitCancelText:cancel withSubmitText:submit withContentText:content isFlip:flip];
    }
    
    return self;
}

- (void)setupWithTitle:(NSString *)title whitCancelText:(NSString *)cancel withSubmitText:(NSString *)submit withContentText:(NSString *)content isFlip:(bool) flip
{
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:.9];
    self.layer.cornerRadius = 6;
    
    UILabel *contentText = [[UILabel class]new];
    
    contentText.font = kFontSizeNormal;
    contentText.text = content;
    contentText.numberOfLines = 0;
    contentText.lineBreakMode = NSLineBreakByWordWrapping;
    contentText.textColor = UIColorFromRGB(BABYCOLOR_main_text);
    
    UILabel *titleText = [[UILabel class] new];
    titleText.text = title;
    titleText.font = kFontSizeBig;
    titleText.textAlignment = NSTextAlignmentCenter;
    titleText.textColor = UIColorFromRGB(BABYCOLOR_main_text);
    
    UIButton *submitBtn = nil;
    UIButton *cancelBtn = nil;
    if (flip) {
        submitBtn = [UIButton createButtonWithTitle:submit target:self action:@selector(submitClick) type:BUTTON_TYPE_WHITE];
        cancelBtn = [UIButton createButtonWithTitle:cancel target:self action:@selector(cancelClick) type:BUTTON_TYPE_RED];
    } else {
        submitBtn = [UIButton createButtonWithTitle:submit target:self action:@selector(submitClick) type:BUTTON_TYPE_RED];
        cancelBtn = [UIButton createButtonWithTitle:cancel target:self action:@selector(cancelClick) type:BUTTON_TYPE_WHITE];
    }
    
    [self sd_addSubviews:@[titleText, contentText, submitBtn, cancelBtn]];
    
    titleText.sd_layout
    .widthIs(240)
    .heightIs(36)
    .topSpaceToView(self, 20)
    .centerXEqualToView(self);
    
    contentText.sd_layout
    .leftSpaceToView(self, 20)
    .rightSpaceToView(self, 20)
    .maxHeightIs(dialogH - 100)
    .topSpaceToView(titleText, 0);
    
    submitBtn.sd_layout
    .widthIs(120)
    .heightIs(36)
    .leftSpaceToView(self, 20)
    .bottomSpaceToView(self, 20);
    
    cancelBtn.sd_layout
    .widthIs(90)
    .heightIs(36)
    .rightSpaceToView(self, 20)
    .bottomSpaceToView(self, 20);
    
}

- (void)submitClick
{
    if (self.onSubmtClick) {
        self.onSubmtClick();
    }
}

- (void)cancelClick
{
    if (self.onCancelClick) {
        self.onCancelClick();
    }
}

@end
