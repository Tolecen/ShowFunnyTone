//
//  PublishUserViewController.h
//  Babypai
//
//  Created by ning on 16/5/10.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "BabyBaseVC.h"

@interface PublishUserViewController : BabyBaseVC

@property(nonatomic, copy) void(^userSelected) (NSMutableArray *users);

@end
