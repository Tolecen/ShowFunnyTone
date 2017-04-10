//
//  BabyTabBar.m
//  Babypai
//
//  Created by ning on 15/4/25.
//  Copyright (c) 2015年 Babypai. All rights reserved.
//

#import "BabyTabBar.h"
#import "GXCustomButton.h"
#import "MacroDefinition.h"

@interface BabyTabBar ()

@property (nonatomic, weak) GXCustomButton *selectedBtn;

@property (nonatomic, weak) GXCustomButton *previousBtn; //记录前一次选中的按钮

@property (nonatomic, assign) int TabbarItemNums;

@end

@implementation BabyTabBar

- (void)addButtonWithImage:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index
{
    
    
    [self creatButtonWithNormalName:normal andSelectName:selected andTitle:title andIndex:index];
//    
//    UIButton *btn = [[UIButton alloc] init];
//    
//    [btn setImage:image forState:UIControlStateNormal];
//    [btn setImage:selectedImage forState:UIControlStateSelected];
//    
//    [self addSubview:btn];
//    
//    //带参数的监听方法记得加"冒号"
//    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //如果是第一个按钮, 则选中(按顺序一个个添加)
//    if (self.subviews.count == 1) {
//        [self clickBtn:btn];
//    }
}

/**专门用来布局子视图, 别忘了调用super方法*/
- (void)layoutSubviews {
    [super layoutSubviews];
//    NSLog(@"layoutSubviews---------------------------");
//    int count = (int)self.subviews.count;
//    for (int i = 0; i < count; i++) {
//        //取得按钮
//        UIButton *btn = self.subviews[i];
//        
//        CGFloat x = i * self.bounds.size.width / count;
//        CGFloat y = 0;
//        CGFloat width = self.bounds.size.width / count;
//        CGFloat height = self.bounds.size.height;
//        btn.frame = CGRectMake(x, y, width, height);
//    }
}


#pragma mark 创建一个按钮
- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index
{
    /*
     GXCustomButton是自定义的一个继承自UIButton的类，自定义该类的目的是因为系统自带的Button可以设置image和title属性，但是默认的image是在title的左边，若想想上面图片中那样，将image放在title的上面，就需要自定义Button，设置一些东西。（具体GXCustomButton设置了什么，放在下面讲）
     */
    
    CGFloat buttonW = self.bounds.size.width / 5;
    CGFloat buttonH = self.bounds.size.height;
    
    CGRect buttonFrame = CGRectMake(buttonW *index, 0, buttonW, buttonH);
    
    if (title == nil) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index;
        button.frame = buttonFrame;
        button.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:50.0f];
        [button setTintColor:[UIColor redColor]];
        button.titleLabel.textColor = [UIColor whiteColor];
        [button setImage:ImageNamed(@"action_new_cam") forState:UIControlStateNormal];
        [button setImage:ImageNamed(@"action_new_cam_highlighted") forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
        button.userInteractionEnabled = YES;
        [self addSubview:button];
        
        return;
    }
    
    GXCustomButton *button = [GXCustomButton buttonWithType:UIButtonTypeCustom];
    button.tag = index;
    
    button.frame = buttonFrame;
    
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
    [button setTitle:title forState:UIControlStateNormal];
    
    
    [button setTitleColor:UIColorFromRGB(BABYCOLOR_light_gray) forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(BABYCOLOR_base_color) forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    button.imageView.contentMode = UIViewContentModeCenter; // 让图片在按钮内居中
    button.titleLabel.textAlignment = NSTextAlignmentCenter; // 让标题在按钮内居中
    button.titleLabel.font = kFontSizeSmall;// 设置标题的字体大小
    [button setTintColor:UIColorFromRGB(BABYCOLOR_base_color)];
    button.userInteractionEnabled = YES;
    [self addSubview:button];
    
    //如果是第一个按钮, 则选中(按顺序一个个添加)
    if (self.subviews.count == 1) {
        [self changeViewController:button];
    }
    
}

- (void)changeViewControllerIndex:(NSInteger)index
{
    GXCustomButton *button = [self viewWithTag:index];
    [self changeViewController:button];
}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(GXCustomButton *)sender
{
    
    NSLog(@"sender.tag = %ld", (long)sender.tag);
    
    if (sender.tag != 2) {
        //1.先将之前选中的按钮设置为未选中
        self.selectedBtn.enabled = YES;
        //2.再将当前按钮设置为选中
        sender.enabled = NO;
        //3.最后把当前按钮赋值为之前选中的按钮
        self.selectedBtn = sender;
    }
    
    //却换视图控制器的事情,应该交给controller来做
    //最好这样写, 先判断该代理方法是否实现
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag to:sender.tag];
    }
    
}

@end
