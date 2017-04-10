//
//  PublishTitlePageViewController.h
//  Babypai
//
//  Created by ning on 16/5/19.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "BabyBaseVC.h"

@interface PublishTitlePageViewController : BabyBaseVC

@property (nonatomic, strong) NSString *videoPath;
@property (nonatomic, strong) NSString *imagePath;

@property (nonatomic, copy) void(^titlePageSelected) (UIImage *image);

@end
