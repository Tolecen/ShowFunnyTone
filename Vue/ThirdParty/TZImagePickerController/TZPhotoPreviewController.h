//
//  TZPhotoPreviewController.h
//  TZImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZPhotoPreviewController : UIViewController

@property (nonatomic, strong) NSArray *photoArr;                ///< All photos / 所有图片的数组
// @property (nonatomic, strong) NSMutableArray *selectedPhotoArr; ///< Current selected photos / 当前选中的图片数组
@property (nonatomic, assign) NSInteger currentIndex;           ///< Index of the photo user click / 用户点击的图片的索引

/// Return the new selected photos / 返回最新的选中图片数组
@property (nonatomic, copy) void (^backButtonClickBlock)();
@property (nonatomic, copy) void (^okButtonClickBlock)();

@end
