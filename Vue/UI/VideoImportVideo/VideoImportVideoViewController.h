//
//  VideoImportVideoViewController.h
//  Babypai
//
//  Created by ning on 16/5/18.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "BabyBaseVC.h"

@interface VideoImportVideoViewController : BabyBaseVC

@property(nonatomic, assign) long tag_id;
@property(nonatomic, strong) NSString *tag;

@property(nonatomic, strong) NSURL *videoPath;

@property(nonatomic, copy) void(^onPublish) ();

@end
