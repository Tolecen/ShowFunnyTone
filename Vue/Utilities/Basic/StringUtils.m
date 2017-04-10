//
//  StringUtils.m
//  Babypai
//
//  Created by ning on 16/4/17.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils


+ (NSString *)getDatePath
{
    // 实例化NSDateFormatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter setDateFormat:@"yyyy/MM/dd"];
    // 获取当前日期
    NSDate *currentDate = [NSDate date];
    NSString *currentDateString = [formatter stringFromDate:currentDate];
    return currentDateString;
}

+ (NSString *)getDatePathWithFile:(NSString *)suffix
{
    return [NSString stringWithFormat:@"/{year}/{mon}/{day}/face_{filemd5}{.suffix}"];;
}

+ (bool)isEmpty:(NSString *)str
{
    if (str == nil || str.length == 0) {
        return true;
    }
    
    return false;
}

/*邮箱验证*/
+ (bool)isEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*手机号码验证 */
+ (bool)isMobile:(NSString *)mobile
{
    
    NSString *phoneRegex = @"((^(13|14|15|18|17)[0-9]{9}$)|(^0[1,2]{1}\\d{1}-?\\d{8}$)|(^0[3-9] {1}\\d{2}-?\\d{7,8}$)|(^0[1,2]{1}\\d{1}-?\\d{8}-(\\d{1,4})$)|(^0[3-9]{1}\\d{2}-? \\d{7,8}-(\\d{1,4})$))";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

/*车牌号验证 */
+ (bool)isCarNo:(NSString* )carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

+ (long)toLong:(NSString *)str
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:str];
    return (long)[myNumber longLongValue];
}

+ (int)videoTime:(long)video_time
{
    int time = 0;
    int time_s = (int) video_time / 1000;
    if (time_s < 1)
        time = 1;
    else {
        time = time_s;
        int time_d = (int) video_time % 1000;
        if (time_d > 500)
            time = time + 1;
    }
    return time;
}

+ (void)updateTextViewTextInsertedString:(HPGrowingTextView *)textView withText:(NSString *)text isTag:(BOOL)isTag
{
    DLogV(@"updateTextViewTextInsertedString : %@", text);
    if ([self isEmpty:text]) {
        return;
    }
    
    long rangeLocation = isTag ? (text.length - 2) : (text.length + 1);
    
    // 获得光标所在的位置
    NSUInteger location = textView.selectedRange.location;
    DLogV(@"location : %d, NSNotFound : %d, textView.text.length : %d", location, NSNotFound, textView.text.length);
    if (location == NSNotFound || location >= textView.text.length) {
        
        NSString *currentText = textView.text;
        if ([StringUtils isEmpty:currentText]) {
            currentText = @"";
        }
        [textView setText:[NSString stringWithFormat:@"%@%@",
                              currentText,
                              text]];
        DLogV(@"updateTextViewTextInsertedString textView.text: %@", textView.text);
        textView.selectedRange = NSMakeRange(currentText.length + rangeLocation, 1);
        
        if (isTag) {
            [textView becomeFirstResponder];
        } else {
            [textView resignFirstResponder];
        }
        
        return;
    }
    
    if ([StringUtils isEmpty:textView.text]) {
        [textView setText:text];
        textView.selectedRange = NSMakeRange(location + rangeLocation, 1);
        
        if (isTag) {
            [textView becomeFirstResponder];
        } else {
            [textView resignFirstResponder];
        }
        return;
    }
    
    NSString *preText = [textView.text substringToIndex:location];
    if ([StringUtils isEmpty:preText]) {
        preText = @"";
    }
    
    NSString *lastText = [textView.text substringFromIndex:location];
    if ([StringUtils isEmpty:lastText]) {
        lastText = @"";
    }
    
    NSString *result = [NSString stringWithFormat:@"%@%@%@",
                        preText,
                        text,
                        lastText];
    
    [textView setText:result];
    
    // 调整光标
    textView.selectedRange = NSMakeRange(location + rangeLocation, 1);
    if (isTag) {
        [textView becomeFirstResponder];
    } else {
        [textView resignFirstResponder];
    }
}

@end
