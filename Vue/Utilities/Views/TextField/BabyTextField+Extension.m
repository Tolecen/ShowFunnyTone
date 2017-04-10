//
//  BabyTextField+Extension.m
//  Babypai
//
//  Created by ning on 16/4/22.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "BabyTextField+Extension.h"
#import "MacroDefinition.h"

@implementation BabyTextField (Extension)

+ (BabyTextField *)createTextFieldWithPlaceholder:(NSString *)placeholder
                                      leftImage:(NSString *)leftImage {
    BabyTextField *textField = [[BabyTextField alloc] initWithFrame:CGRectZero];
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:15];
    UIImage *image = [UIImage imageNamed:@"textfield_background"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    textField.background = image;
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftImage]];
    textField.leftView = leftImageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textField setValue:UIColorFromRGB(BABYCOLOR_comment_text) forKeyPath:@"_placeholderLabel.textColor"];
    return textField;
}
@end
