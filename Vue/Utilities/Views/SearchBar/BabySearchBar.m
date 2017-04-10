//
//  BabySearchBar.m
//  Buole
//
//  Created by ning on 16/7/28.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "BabySearchBar.h"
#import "MacroDefinition.h"

@implementation BabySearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (id)initWithCoder: (NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (id)sharedInit {
    self.backgroundColor = UIColorFromRGB(BABYCOLOR_gray);
    self.placeholder = @"搜索";
    self.keyboardType = UIKeyboardTypeDefault;
    self.showsCancelButton = NO;
    // 删除UISearchBar中的UISearchBarBackground
    [self setBackgroundImage:[[UIImage alloc] init]];
    self.tintColor = UIColorFromRGB(BABYCOLOR_base_color);
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"];
    return self;
}

@end
