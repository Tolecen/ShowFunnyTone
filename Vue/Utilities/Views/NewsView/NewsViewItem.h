//
//  NewsViewItem.h
//  Babypai
//
//  Created by ning on 16/5/26.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewItem : UIView

@property (retain, nonatomic) UILabel *titleLabel;
@property (retain, nonatomic) UILabel *descriptionLabel;

- (void)setViewWithTitle:(NSString *)title description:(NSString *)description;

@end
