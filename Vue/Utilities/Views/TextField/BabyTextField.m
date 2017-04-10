//
//  BabyTextField.m
//  Babypai
//
//  Created by ning on 16/4/22.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "BabyTextField.h"

@implementation BabyTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(5, (bounds.size.height - 24) / 2, 24, 24);
    return inset;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect newBounds = CGRectMake(CGRectGetMinX(bounds) + 8, CGRectGetMinY(bounds), CGRectGetWidth(bounds) - 8, CGRectGetHeight(bounds));
    return CGRectInset( newBounds , 24 , 0 );
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect newBounds = CGRectMake(CGRectGetMinX(bounds) + 8, CGRectGetMinY(bounds), CGRectGetWidth(bounds) - 8, CGRectGetHeight(bounds));
    return CGRectInset( newBounds , 24 , 0 );
}

@end
