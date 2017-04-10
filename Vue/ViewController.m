//
//  ViewController.m
//  Vue
//
//  Created by sdfsdf on 2017/3/15.
//  Copyright © 2017年 sdfsdf. All rights reserved.
//

#import "ViewController.h"
#import "VideoRecorderViewController.h"
#import "Vue-Swift.h"
#import "ThemeHelper.h"
#import "VideoPublishViewController.h"

#import "CellTheme.h"
#import "BabyFileManager.h"
#import "ThemeHelper.h"
#import "StringUtils.h"
#import "MenuHrizontal.h"
#import "SVProgressHUD.h"
#import "ImageUtils.h"
#import "UIButton+UIButtonImageWithLabel.h"
#import "BabyUploadEntity.h"
#import <IJKMediaFramework/VideoEncoder.h>
#import "VideoPublishViewController.h"
#import "ThemeStoreViewController.h"
#import "BabyNavigationController.h"
#import "UIView+SDAutoLayout.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-80.0f)/2.0f,100.0f, 80.0f, 80.0f)];
    [button setTitle:@"进入" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor purpleColor]];
    [button addTarget:self action:@selector(videoButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-80.0f)/2.0f,220.0f, 80.0f, 80.0f)];
    [button2 setTitle:@"抠出" forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor purpleColor]];
    [button2 addTarget:self action:@selector(pressNextButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    [[ThemeHelper helper] prepareTheme];

    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)videoButtonTouched
{

    VideoRecorderViewController *camera = [[VideoRecorderViewController alloc] init];
    UINavigationController *cameraNav = [[UINavigationController alloc]initWithRootViewController:camera];
    [self presentViewController:cameraNav animated:YES completion:nil];

    
//    VideoPublishViewController *publishVC = [[VideoPublishViewController alloc]init];
////    publishVC.uploadEntity = uploadInfo;
////    publishVC.fromDraft = _fromDraft;
//    
//    publishVC.savedDraft = ^(BOOL saved) {
////        if (self.savedDraft) {
////            self.savedDraft(saved);
////        }
//    };
//    
//    publishVC.onPublish = ^() {
////        if (self.onPublish) {
////            self.onPublish();
////        }
//        [self.navigationController popViewControllerAnimated:YES];
//    };
//    
//   [self presentViewController:publishVC animated:YES completion:nil];

//    [self.navigationController pushViewController:publishVC animated:YES];
    
}


- (void)pressNextButton
{
    NSLog(@"pressNextButton------");

    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showProgress:0 status:@"生成视频中"];
    

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 生成视频

        
        VideoEncoder *encoder = [VideoEncoder videoEncoder];
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
        
        [mutableArray addObject:@"ffmpeg"];
        [mutableArray addObject:@"-y"];
        [mutableArray addObject:@"-i"];
        [mutableArray addObject:[[NSBundle mainBundle] pathForResource:@"test_264" ofType:@"mp4"]];
        [mutableArray addObject:@"-i"];
        
        
        
        [mutableArray addObject:[[NSBundle mainBundle] pathForResource:@"1491534897682" ofType:@"mp4"]];

        [mutableArray addObject:@"-filter_complex"];
        NSString *filter = @"[1:v]colorkey=0xffffff:0.45:0.2[keyed];[0:v][keyed]overlay[out]";
        [mutableArray addObject:filter];
        
        [mutableArray addObject:@"-map"];
        [mutableArray addObject:@"[out]"];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        
        NSString *folderPath = [path stringByAppendingPathComponent:VIDEO_FOLDER];
        
        NSString *tempPath = [folderPath stringByAppendingPathComponent:@"55555555555.mp4"];
        
        [mutableArray addObject:tempPath];
        
        NSArray *array =[mutableArray copy];
        
        OnEncoderProgressBlock progressBlock = ^(long size, long timestamp) {
           
            
        };
        
        OnEncoderCompletionBlock block = ^(int ret, NSString* retString) {
            DLog(@"执行完毕：ret = %d, retString : %@", ret, retString);
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
              
                
                
                [SVProgressHUD dismiss];
                
            });
            
        };
        
        [encoder videoMerge:array progress:progressBlock completion:block];
    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
