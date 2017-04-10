//
//  PublishTitlePageViewController.m
//  Babypai
//
//  Created by ning on 16/5/19.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "PublishTitlePageViewController.h"
#import "VideoTiltePageSelector.h"

@interface PublishTitlePageViewController () <VideoTiltePageSelectorDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) VideoTiltePageSelector *titlePageSelector;


@end

@implementation PublishTitlePageViewController

- (NSString *)title
{
    
    return @"选择封面";
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [MobClick beginLogPageView:[self title]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:[self title]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(BABYCOLOR_bg_publish);
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pressBackButton)];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(pressDoneButton)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _imageView = [[UIImageView alloc]init];
    if (_imagePath != nil) {
        _imageView.image = [UIImage imageWithContentsOfFile:_imagePath];
    }
    
    UILabel *tipLable = [[UILabel alloc]init];
    tipLable.text = @"拖动选择视频封面";
    tipLable.font = kFontSizeNormal;
    tipLable.textColor = UIColorFromRGB(BABYCOLOR_gray);
    tipLable.textAlignment = NSTextAlignmentCenter;
    
    [self.view sd_addSubviews:@[_imageView, tipLable]];
    
    _imageView.sd_layout
    .widthIs(SCREEN_WIDTH)
    .heightIs(SCREEN_WIDTH)
    .topSpaceToView(self.view, TopBar_height)
    .leftEqualToView(self.view);
    
    
    tipLable.sd_layout
    .widthIs(SCREEN_WIDTH)
    .heightIs(36)
    .bottomSpaceToView(self.view, 10)
    .leftEqualToView(self.view);
    
    _titlePageSelector = [[VideoTiltePageSelector alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TopBar_height - 56, SCREEN_WIDTH, 50) videoUrl:[NSURL fileURLWithPath:_videoPath]];
    _titlePageSelector.delegate = self;
    
    [self.view addSubview:_titlePageSelector];
    
}

- (void)pressBackButton
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)pressDoneButton
{
    if (self.titlePageSelected) {
        self.titlePageSelected(_image);
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)videoRange:(VideoTiltePageSelector *)videoRange didChangeLeftPosition:(CGFloat)leftPosition withImage:(UIImage *)image
{
    self.image = image;
    self.imageView.image = image;
}

@end
