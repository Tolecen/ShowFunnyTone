//
//  PinDetailViewController.h
//  Babypai
//
//  Created by ning on 15/4/22.
//  Copyright (c) 2015年 Babypai. All rights reserved.
//
#import "Pin.h"
#import "BabyBaseVC.h"

@interface PinDetailViewController : BabyBaseVC

@property (nonatomic, strong) Pin *pin;

@property (nonatomic, assign) long pinId;

@property (nonatomic, assign) long position;

@property(nonatomic, copy) void(^pinEdit) (long position, Pin *pinEdit, BOOL isDel);

@end
