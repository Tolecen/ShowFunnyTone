//
//  BoardsViewController.h
//  Babypai
//
//  Created by ning on 16/4/25.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "BabyBaseVC.h"
#import "Boards.h"

typedef NS_ENUM(NSInteger, BOARDS_TYPE) {
    BOARDS_TYPE_NORMARL,
    BOARDS_TYPE_SELECT
};

@interface BoardsViewController : BabyBaseVC

@property(nonatomic, assign) long user_id;
@property(nonatomic, assign) BOARDS_TYPE boardType;

@property(nonatomic, copy) void (^onBoardSelect)(Board *board);

@end
