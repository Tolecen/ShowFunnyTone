//
//  BabyTabBar.h
//  Babypai
//
//  Created by ning on 15/4/25.
//  Copyright (c) 2015年 Babypai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BabyTabBar;

@protocol BabyTabBarDelegate <NSObject>

- (void) tabBar:(BabyTabBar *)tabBar selectedFrom:(NSInteger) from to:(NSInteger)to;

@end

@interface BabyTabBar : UIView

@property (nonatomic, weak) id<BabyTabBarDelegate> delegate;

/**
 *  创建按钮
 *
 *  @param image         普通状态下的图片
 *  @param selectedImage 选中状态下的图片
 */
- (void)addButtonWithImage:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index;

- (void)changeViewControllerIndex:(NSInteger)index;

@end
