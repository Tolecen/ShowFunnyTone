//
//  NewsViewItem.m
//  Babypai
//
//  Created by ning on 16/5/26.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "NewsViewItem.h"
#import "MacroDefinition.h"

@implementation NewsViewItem

@synthesize titleLabel;
@synthesize descriptionLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    titleLabel=[[UILabel alloc] init];
    titleLabel.textColor = UIColorFromRGB(BABYCOLOR_main_text);
    titleLabel.font = kFontSizeNormal;
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLabel.numberOfLines = 1;
    [self addSubview:titleLabel];
    
    descriptionLabel=[[UILabel alloc] init];
    descriptionLabel.textColor = UIColorFromRGB(BABYCOLOR_base_color);
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.font = kFontSizeSmall;
    descriptionLabel.numberOfLines = 1;
    
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.layer.borderColor = UIColorFromRGB(BABYCOLOR_base_color).CGColor;
    descriptionLabel.layer.borderWidth = 1;
    descriptionLabel.backgroundColor = CLEARCOLOR;
    descriptionLabel.layer.cornerRadius = 6;
    descriptionLabel.clipsToBounds = YES;
    
    [self addSubview:descriptionLabel];
    
}

-(void)setViewWithTitle:(NSString *)title description:(NSString *)description{

    [titleLabel setText:title];
    [descriptionLabel setText:description];
    
    CGSize descriptionSize = [description sizeWithAttributes:@{NSFontAttributeName: descriptionLabel.font}];
    
    CGRect desFrame = CGRectMake(0, (self.bounds.size.height - 22) / 2, descriptionSize.width + 10, 22);
    descriptionLabel.frame = desFrame;
    
    CGRect titleFrame = CGRectMake(descriptionLabel.bounds.size.width + 6, 0, self.bounds.size.width - descriptionLabel.bounds.size.width - 6, 30);
    titleLabel.frame = titleFrame;

}

@end
