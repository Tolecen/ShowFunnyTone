//
//  BabyDialog.h
//  Babypai
//
//  Created by ning on 16/4/24.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import <UIKit/UIKit.h>

#define dialogW 300
#define dialogH 200

@interface BabyDialog : UIView

- (id)initWithTitle:(NSString *)title whitCancelText:(NSString *)cancel withSubmitText:(NSString *)submit withContentText:(NSString *)content isFlip:(bool) flip;

@property(nonatomic, copy) void(^onCancelClick)();
@property(nonatomic, copy) void(^onSubmtClick)();

@end
