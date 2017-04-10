//
//  CellUserPublish.h
//  Babypai
//
//  Created by ning on 16/5/10.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "BabyTableViewCell.h"
#import "UserInfo.h"

@interface CellUserPublish : BabyTableViewCell

@property(nonatomic, strong) UserInfo *userInfo;

@property(nonatomic, assign) NSInteger cellIndex;

@property(nonatomic, assign) BOOL isSelected;

@property(nonatomic, copy) void(^followClicked)(NSInteger cellIndex, UserInfo *user);

@end
