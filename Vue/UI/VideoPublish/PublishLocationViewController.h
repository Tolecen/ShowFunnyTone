//
//  PublishLocationViewController.h
//  Babypai
//
//  Created by ning on 16/5/17.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "BabyBaseVC.h"

@interface PublishLocationViewController : BabyBaseVC

@property(nonatomic, copy) void(^locationSelected) (NSString *poi);

@end
