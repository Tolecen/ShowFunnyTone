//
//  StringUtils.h
//  Babypai
//
//  Created by ning on 16/4/17.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPGrowingTextView.h"
#import "MacroDefinition.h"

@interface StringUtils : NSObject

+ (NSString *)getDatePath;
+ (NSString *)getDatePathWithFile:(NSString *)suffix;

+ (bool)isEmpty:(NSString *)str;

+ (bool)isEmail:(NSString *)email;
+ (bool)isMobile:(NSString *)mobile;
+ (bool)isCarNo:(NSString* )carNo;

+ (long)toLong:(NSString *)str;

+ (int)videoTime:(long)video_time;

/**
 *   *  更新插入数据到光标处
 *
 *  @param textView HPGrowingTextView
 *  @param text     文字
 *  @param isTag    是否是标签 ##
 */
+ (void)updateTextViewTextInsertedString:(HPGrowingTextView *)textView withText:(NSString *)text isTag:(BOOL)isTag;

@end
