//
//  VideoImportImageViewController.h
//  Babypai
//
//  Created by ning on 16/5/17.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "BabyBaseVC.h"

@interface VideoImportImageViewController : BabyBaseVC

@property(nonatomic, assign) long tag_id;
@property(nonatomic, strong) NSString *tag;

@property(nonatomic, copy) void(^onPublish) ();

@end
