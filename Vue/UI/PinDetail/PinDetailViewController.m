//
//  PinDetailViewController.m
//  Babypai
//
//  Created by ning on 15/4/22.
//  Copyright (c) 2015年 Babypai. All rights reserved.
//https://github.com/ibireme/YYText

#import "PinDetailViewController.h"

#define MAX_LIMIT_NUMS 140

@interface PinDetailViewController ()<UITableViewDelegate,UITableViewDataSource, UIActionSheetDelegate>

@end

@implementation PinDetailViewController

-(id)init
{
    self = [super init];
    if(self){
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification 
                                                   object:nil];		
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [MobClick beginLogPageView:@"视频详情页面"];
}

- (void)viewWillDisappear:(BOOL)animated
{
//    [super viewWillDisappear:animated];
//    if(_currentPlayingCell){
//        [_currentPlayingCell backToInitState];
//        _currentPlayingCell = nil;
//    }
//    [MobClick endLogPageView:@"视频详情页面"];
}

- (void)viewDidDisappear:(BOOL)animated
{
//    [super viewDidDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//    
//    if (self.pinEdit) {
//        self.pinEdit(_position, _pin, _isDel);
//    }
}

- (NSString *)title
{
    return @"萌宝拍详情";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIBarButtonItem *moreBtn = [[UIBarButtonItem alloc]initWithImage:ImageNamed(@"baby_btn_more_b") style:UIBarButtonItemStylePlain target:self action:@selector(pressMoreBtn)];
//    self.navigationItem.rightBarButtonItem = moreBtn;
//    
//    
//    _cursor = 0;
//    _isDel = NO;
//    
//    
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44) style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = UIColorFromRGB(BABYCOLOR_background);
//    
//    [self.view addSubview:self.tableView];
//    [self.tableView registerClass:[PinViewTopCell class] forCellReuseIdentifier:NSStringFromClass([PinViewTopCell class])];
//    [self.tableView registerClass:[PinViewPlayerCell class] forCellReuseIdentifier:NSStringFromClass([PinViewPlayerCell class])];
//    [self.tableView registerClass:[PinViewBottomCell class] forCellReuseIdentifier:NSStringFromClass([PinViewBottomCell class])];

    
}

- (void)viewDidAppear:(BOOL)animated
{
//    [super viewDidAppear:animated];
//    DLogE(@"pinId : %ld", _pinId);
//    if ([[Utils utils] canAutoPlay:[self isNetworkWAN]]) {
//        _ifAutoPlay = YES;
//        [self.tableView reloadData];
//    } else {
//        _ifAutoPlay = NO;
//    }
//    
//    if (_currentPlayingCell && _ifAutoPlay) {
//        [_currentPlayingCell playCurrentVideo];
//    }
//    
//    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44)];
//    [self.view addSubview:self.toolBar];
//    
//    UIButton *sendBtn = [UIButton createButtonWithTitle:@"发 送" target:self action:@selector(resignTextView) type:BUTTON_TYPE_RED];
//    [self.toolBar addSubview:sendBtn];
//    self.sendBtn = sendBtn;
//    
//    self.sendBtn.sd_layout
//    .widthIs(60)
//    .rightSpaceToView(self.toolBar, 10)
//    .heightIs(36)
//    .centerYEqualToView(self.toolBar);
//    
//    self.textView = [[HPGrowingTextView alloc]initWithFrame:CGRectMake(10, 4, SCREEN_WIDTH - 90, 36)];
//    self.textView.isScrollable = NO;
//    self.textView.contentInset = UIEdgeInsetsMake(4, 5, 4, 5);
//    
//    self.textView.minNumberOfLines = 1;
//    self.textView.maxNumberOfLines = 3;
//    // you can also set the maximum height in points with maxHeight
//    // textView.maxHeight = 200.0f;
//    self.textView.returnKeyType = UIReturnKeyDone; //just as an example
//    self.textView.font = kFontSizeNormal;
//    self.textView.textColor = UIColorFromRGB(BABYCOLOR_main_text);
//    self.textView.dataDetectorTypes = UIDataDetectorTypeAll; // 显示数据类型的连接模式（如电话号码、网址、地址等）
//    self.textView.keyboardType = UIKeyboardTypeDefault; // 设置弹出键盘的类型
//    self.textView.delegate = self;
//    self.textView.tintColor = UIColorFromRGB(BABYCOLOR_base_color);
//    self.textView.internalTextView.font = kFontSizeNormal;
//    self.textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
//    self.textView.backgroundColor = [UIColor whiteColor];
//    self.textView.placeholder = @"说点什么吧~";
//    self.textView.placeholderColor = UIColorFromRGB(BABYCOLOR_comment_text);
//    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    
//    [self.toolBar addSubview:self.textView];
//    
//    self.textView.sd_layout
//    .heightIs(36)
//    .leftSpaceToView(self.toolBar, 10)
//    .rightSpaceToView(self.sendBtn, 10)
//    .centerYEqualToView(self.toolBar);
//    
//    self.toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//    
//    [self loadData];
}

-(void)resignTextView
{
//    [self.textView resignFirstResponder];
//    DLog(@"comment : %@", self.textView.text);
//    
//    if (![self isLogin]) {
//        [self loginUser];
//        return;
//    }
//    
//    if (![StringUtils isEmpty:self.textView.text]) {
//        [self commentPost:self.textView.text];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (void)commentPost:(NSString *)text
//{
//    NSString *fields = [NSString stringWithFormat:@"{\"user_id\":\"%ld\",\"pinId\":\"%ld\",\"text\":\"%@\"}", [self loginUserId], _pin.pin_id, text];
//    
//    DataCompletionBlock completionBlock = ^(NSDictionary *data, NSString *errorString){
//        
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        
//        if (data != nil) {
//            Comments *message = [Comments mj_objectWithKeyValues:data];
//            if (message.msg == 0) {
//                self.textView.text = @"";
//                [_comments.info insertObject:message.info[0] atIndex:0];
//                _pin.comment_count = _pin.comment_count + 1;
//                [_tableView reloadData];
//            } else {
//                [SVProgressHUD showErrorWithStatus:@"抱歉，评论失败"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                });
//            }
//        }
//    };
//    
//    BabyDataSource *souce = [BabyDataSource dataSource];
//    [souce getData:PIN_COMMENTADD parameters:fields completion:completionBlock];
//}
//
//- (void)pressMoreBtn
//{
//    DLog(@"pressMoreBtn");
//    
//    if (_currentPlayingCell) {
//        [_currentPlayingCell pauseCurrentVideo];
//    }
//    
//    if (_pin.user_id == [self loginUserId] && _pin.is_private) {
//        _moreSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除该萌宝拍", nil];
//        [_moreSheet showInView:self.view];
//        
//    } else {
//        [self sharePin:_pin];
//    }
//    
//    
//}
//
////Code from Brett Schumann
//-(void) keyboardWillShow:(NSNotification *)note{
//    // get keyboard size and loctaion
//    CGRect keyboardBounds;
//    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
//    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
//    
//    // Need to translate the bounds to account for rotation.
//    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
//    
//    // get a rect for the textView frame
//    CGRect containerFrame = self.toolBar.frame;
//    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
//    // animations settings
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:[duration doubleValue]];
//    [UIView setAnimationCurve:[curve intValue]];
//    
//    // set views with new info
//    self.toolBar.frame = containerFrame;
//    
//    
//    // commit animations
//    [UIView commitAnimations];
//}
//
//-(void) keyboardWillHide:(NSNotification *)note{
//    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
//    
//    // get a rect for the textView frame
//    CGRect containerFrame = self.toolBar.frame;
//    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
//    
//    // animations settings
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:[duration doubleValue]];
//    [UIView setAnimationCurve:[curve intValue]];
//    
//    // set views with new info
//    self.toolBar.frame = containerFrame;
//    
//    // commit animations
//    [UIView commitAnimations];
//}
//
////- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
////{
//////    float diff = (growingTextView.frame.size.height - height);
//////    
//////    CGRect r = self.toolBar.frame;
//////    r.size.height -= diff;
//////    r.origin.y += diff;
//////    self.toolBar.frame = r;
////}
//
////- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
////{
////    UITextRange *selectedRange = [growingTextView.internalTextView markedTextRange];
////    //获取高亮部分
////    UITextPosition *pos = [growingTextView.internalTextView positionFromPosition:selectedRange.start offset:0];
////    //获取高亮部分内容
////    //NSString * selectedtext = [textView textInRange:selectedRange];
////    
////    //如果有高亮且当前字数开始位置小于最大限制时允许输入
////    if (selectedRange && pos) {
////        NSInteger startOffset = [growingTextView.internalTextView offsetFromPosition:growingTextView.internalTextView.beginningOfDocument toPosition:selectedRange.start];
////        NSInteger endOffset = [growingTextView.internalTextView offsetFromPosition:growingTextView.internalTextView.beginningOfDocument toPosition:selectedRange.end];
////        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
////        
////        if (offsetRange.location < MAX_LIMIT_NUMS) {
////            return YES;
////        }
////        else
////        {
////            return NO;
////        }
////    }
////    
////    
////    NSString *comcatstr = [growingTextView.internalTextView.text stringByReplacingCharactersInRange:range withString:text];
////    
////    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
////    
////    if (caninputlen >= 0)
////    {
////        return YES;
////    }
////    else
////    {
////        NSInteger len = text.length + caninputlen;
////        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
////        NSRange rg = {0,MAX(len,0)};
////        
////        if (rg.length > 0)
////        {
////            NSString *s = @"";
////            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
////            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
////            if (asc) {
////                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
////            }
////            else
////            {
////                __block NSInteger idx = 0;
////                __block NSString  *trimString = @"";//截取出的字串
////                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
////                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
////                                         options:NSStringEnumerationByComposedCharacterSequences
////                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
////                                          
////                                          if (idx >= rg.length) {
////                                              *stop = YES; //取出所需要就break，提高效率
////                                              return ;
////                                          }
////                                          
////                                          trimString = [trimString stringByAppendingString:substring];
////                                          
////                                          idx++;
////                                      }];
////                
////                s = trimString;
////            }
////            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
////            [growingTextView.internalTextView setText:[growingTextView.internalTextView.text stringByReplacingCharactersInRange:range withString:s]];
////        }
////        return NO;
////    }
////}
////
////- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView
////{
////    UITextRange *selectedRange = [growingTextView.internalTextView markedTextRange];
////    //获取高亮部分
////    UITextPosition *pos = [growingTextView.internalTextView positionFromPosition:selectedRange.start offset:0];
////    
////    //如果在变化中是高亮部分在变，就不要计算字符了
////    if (selectedRange && pos) {
////        return;
////    }
////    
////    NSString  *nsTextContent = growingTextView.internalTextView.text;
////    NSInteger existTextNum = nsTextContent.length;
////    
////    if (existTextNum > MAX_LIMIT_NUMS)
////    {
////        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
////        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
////        
////        [growingTextView.internalTextView setText:s];
////    }
////    
////}
////
////- (void)loadData
////{
////    
////    // 设置普通状态的动画图片
////    NSMutableArray *idleImages = [NSMutableArray array];
////    for (NSUInteger i = 1; i<=60; i++) {
////        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
////        [idleImages addObject:image];
////    }
////    
////    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
////    NSMutableArray *refreshingImages = [NSMutableArray array];
////    for (NSUInteger i = 1; i<=8; i++) {
////        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
////        [refreshingImages addObject:image];
////    }
////
////    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
////    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataRefresh)];
////    // 设置普通状态的动画图片
////    [header setImages:idleImages forState:MJRefreshStateIdle];
////    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
////    [header setImages:refreshingImages forState:MJRefreshStatePulling];
////    // 设置正在刷新状态的动画图片
////    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
////    // 设置header
////    
////    header.lastUpdatedTimeLabel.hidden = YES;
////    header.stateLabel.hidden = YES;
////    
////    self.tableView.mj_header = header;
////    [self.tableView.mj_header beginRefreshing];
////    
////}
////
//- (void)loadDataMore
//{
//    _cursor++;
//    [self loadNewData];
//    
//}
//
//- (void)loadNewDataRefresh
//{
//    _cursor = 0;
//    _comments = nil;
//    if (_pin != nil) {
//        [self loadNewData];
//    } else {
//        [self loadPinData];
//    }
//    
//}
//
//- (void)loadPinData
//{
//    DataCompletionBlock completionBlock = ^(NSDictionary *data, NSString *errorString){
//        
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        if (data != nil) {
//            PinInfo *mPinInfo = [PinInfo mj_objectWithKeyValues:data];
//            if (mPinInfo.msg > 0) {
//                [SVProgressHUD showErrorWithStatus:@"Opps!数据错误啦，稍后再试吧~"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                    [self.navigationController popViewControllerAnimated:YES];
//                });
//            } else {
//                _pin = mPinInfo.info;
//                [self.tableView reloadData];
//                [self loadNewData];
//            }
//        } else {
//            [SVProgressHUD showErrorWithStatus:@"请稍后再试"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
//                [self.navigationController popViewControllerAnimated:YES];
//            });
//        }
//    };
//    
//    
//    BabyDataSource *souce = [BabyDataSource dataSource];
//    NSString *fields = [NSString stringWithFormat:@"{\"pin_id\":\"%ld\"}", _pinId];
//    [souce getData:PIN_INFO parameters:fields completion:completionBlock];
//}
//
//- (void)loadNewData
//{
//    DataCompletionBlock completionBlock = ^(NSDictionary *data, NSString *errorString){
//        
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//        if (data != nil) {
//            [self processData:data];
//        } else {
//            
//        }
//    };
//    
//    
//    BabyDataSource *souce = [BabyDataSource dataSource];
//    NSString *fields = [NSString stringWithFormat:@"{\"cursor\":\"%d\",\"pin_id\":\"%ld\"}", _cursor, _pin.pin_id];
//    [souce getData:PINS_COMMENTS parameters:fields completion:completionBlock];
//}
//
//- (void)processData:(NSDictionary *)data
//{
//    if(_comments == nil) {
//        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataMore)];
//        [footer setTitle:NOMOREDATA forState:MJRefreshStateNoMoreData];
//        self.tableView.mj_footer = footer;
//        
//        _comments = [Comments mj_objectWithKeyValues:data];
//    } else {
//        Comments *comments = [Comments mj_objectWithKeyValues:data];
//        [_comments.info addObjectsFromArray:comments.info];
//    }
//    
//    if ([_comments.info count] == 0) {
//        self.tableView.mj_footer.hidden = YES;
//    } else {
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
//        if ([_comments.info count] < 10)
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//    }
//    
//    
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 2;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    // Return the number of rows in the section.
//    
//    if (section == 0) {
//        return 3;
//    }
//    return _comments.info.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    if (indexPath.section == 0) {
//        switch (indexPath.row) {
//            case 0:
//                return pinViewTopH;
//            case 1:
//                return SCREEN_WIDTH;
//            case 2:
//                return [self.tableView cellHeightForIndexPath:indexPath model:_pin keyPath:@"pin" cellClass:[PinViewBottomCell class] contentViewWidth:[self cellContentViewWith]];
//        }
//    }
//    PinCommentFrame *commentFrame = [[PinCommentFrame alloc]init];
//    [commentFrame setComment:_comments.info[indexPath.row]];
//    return commentFrame.cellHeight;
//    
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    
//    UITableViewCell* tableCell = nil;
//    
//    if (indexPath.section == 0) {
//        
//        switch (indexPath.row) {
//            case 0: {
//                PinViewTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PinViewTopCell class])];
//                cell.pin = _pin;
//                cell.cellIndex = indexPath.section;
//                
//                cell.userClicked = ^(NSInteger cellIndex, UserInfoNoPin *user){
//                    [self pushToUser:user];
//                };
//                tableCell = cell;
//            }
//                break;
//            case 1: {
//                PinViewPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PinViewPlayerCell class])];
//                cell.pin = _pin;
//                cell.cellIndex = indexPath.section;
//                
//                cell.delegate = self;
//                if( !_ifAutoPlay ){
//                    cell.isCurrentCellPlaying = NO;
//                } else {
//                    cell.isCurrentCellPlaying = YES;
//                }
//                [cell playCurrentVideo];
//                
//                cell.privateClicked = ^(NSInteger cellIndex) {
//                    [self pinPrivateDialog:_pin atLocation:cellIndex];
//                };
//                
//                tableCell = cell;
//            }
//                break;
//            case 2: {
//                PinViewBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PinViewBottomCell class])];
//                cell.pin = _pin;
//                cell.cellIndex = indexPath.section;
//                
//                cell.likeUserClicked = ^(NSInteger cellIndex) {
//                    UsersViewController *usersVC = [[UsersViewController alloc]init];
//                    usersVC.likeCount = _pin.like_count;
//                    usersVC.pinUserId = _pin.pin_id;
//                    usersVC.userType = USER_TYPE_LIKE;
//                    [self.navigationController pushViewController:usersVC animated:YES];
//                };
//                
//                cell.shareClicked = ^(NSInteger cellIndex, Pin *pin) {
//                    [self sharePin:pin];
//                    if (_currentPlayingCell) {
//                        [_currentPlayingCell pauseCurrentVideo];
//                    }
//                };
//                
//                cell.likeClicked = ^(NSInteger cellIndex) {
//                    
//                    if (![self isLogin]) {
//                        [self loginUser];
//                        return;
//                    }
//                    
//                    if (_pin.liked == 0) {
//                        _pin.liked = 1;
//                        _pin.like_count ++;
//                        if (_pin.like_user == nil) {
//                            _pin.like_user = [[NSMutableArray alloc]init];
//                        }
//                        [_pin.like_user insertObject:[self loginUserInfomation].info atIndex:0];
//                        
//                        [self pinLikePost:_pin withLike:@"like"];
//                        
//                    } else {
//                        _pin.liked = 0;
//                        _pin.like_count --;
//                        NSMutableArray *users = _pin.like_user;
//                        for (int i = 0; i < [users count]; i++) {
//                            UserInfo *user = users[i];
//                            if (user.user_id == [self loginUserId]) {
//                                [users removeObjectAtIndex:i];
//                                break;
//                            }
//                        }
//                        _pin.like_user = users;
//                        [self pinLikePost:_pin withLike:@"unlike"];
//                    }
//                    
//                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//                    
//                };
//                
//                cell.rawTextUser = ^(NSString *userName) {
//                    UserViewController *user = [[UserViewController alloc]init];
//                    user.userName = userName;
//                    user.hidesBottomBarWhenPushed=YES;
//                    [self.navigationController pushViewController:user animated:YES];
//                };
//                
//                cell.rawTextTag = ^(NSString *tagString, long tag_id) {
//                    TagViewController *tag = [[TagViewController alloc]init];
//                    tag.tag_id = tag_id;
//                    tag.tagString = tagString;
//                    tag.hidesBottomBarWhenPushed=YES;
//                    [self.navigationController pushViewController:tag animated:YES];
//                };
//                
//                tableCell = cell;
//            }
//                break;
//        }
//        
//    } else {
//        
//        PinCommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PinCommentViewCell ID]];
//        if (cell == nil) {
//            cell = [[PinCommentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PinCommentViewCell ID]];
//        }
//        
//        PinCommentFrame *commentFrame = [[PinCommentFrame alloc]init];
//        [commentFrame setComment:_comments.info[indexPath.row]];
//        cell.cellIndex = indexPath.row;
//        cell.userCommentClicked = ^(NSInteger cellIndex, UserInfoNoPin *user){
//            [self pushToUser:user];
//        };
//        
//        cell.commentTextUser = ^(NSString *userName) {
//            UserViewController *user = [[UserViewController alloc]init];
//            user.userName = userName;
//            user.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:user animated:YES];
//        };
//        
//        cell.commentTextTag = ^(NSString *tagString, long tag_id) {
//            TagViewController *tag = [[TagViewController alloc]init];
//            tag.tag_id = tag_id;
//            tag.tagString = tagString;
//            tag.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:tag animated:YES];
//        };
//        
//        [cell setPinCommentFrame:commentFrame];
//        tableCell = cell;
//        
//    }
//    
//    [tableCell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    return tableCell;
//}
//
//- (void)pinPrivateDialog:(Pin *)pin atLocation:(NSInteger)position
//{
//    BabyDialog *dialogView = [[BabyDialog alloc]initWithTitle:@"提 示" whitCancelText:@"取消" withSubmitText:@"确 定" withContentText:@"您确认要公开这个视频吗？" isFlip:NO];
//    dialogView.onSubmtClick = ^(){
//        [_modal closeWithLeansRandom];
//        [self pinPrivate:pin atLocation:position];
//        
//    };
//    dialogView.onCancelClick = ^(){
//        [_modal closeWithLeansRandom];
//    };
//    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    _modal = [PathDynamicModal showWithModalView:dialogView inView:window];
//    _modal.showMagnitude = 100.0f;
//    _modal.closeMagnitude = 160.0f;
//}
//
//- (void)pinPrivate:(Pin *)pin atLocation:(NSInteger)position
//{
//    [SVProgressHUD showWithStatus:@"加载中..."];
//    
//    
//    DataCompletionBlock completionBlock = ^(NSDictionary *data, NSString *errorString){
//        
//        //shua xin stop
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        //        [SVProgressHUD dismiss];
//        if (data != nil) {
//            
//            PostMessage *messge = [PostMessage mj_objectWithKeyValues:data];
//            
//            if (messge.msg == 0) {
//                pin.is_private = 0;
//                _pin = pin;
//                NSIndexPath *bottomIndexPath = [NSIndexPath indexPathForRow:1 inSection:position];
//                [_tableView reloadRowsAtIndexPaths:@[bottomIndexPath] withRowAnimation:UITableViewRowAnimationNone];
//                
//                [SVProgressHUD showSuccessWithStatus:messge.info];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                    [self dismissViewControllerAnimated:YES completion:nil];
//                });
//            } else {
//                [SVProgressHUD showErrorWithStatus:messge.info];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                });
//            }
//            
//        } else {
//            [SVProgressHUD showErrorWithStatus:@"请稍后再试"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
//            });
//        }
//    };
//    
//    
//    BabyDataSource *souce = [BabyDataSource dataSource];
//    
//    NSString *fields = [NSString stringWithFormat:@"{\"user_id\":\"%ld\",\"pinId\":\"%ld\"}", [self loginUserId], pin.pin_id];
//    [souce getData:PIN_PRIVATE parameters:fields completion:completionBlock];
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 1) {
//        
//        if (_currentPlayingCell) {
//            [_currentPlayingCell pauseCurrentVideo];
//        }
//        
//        _commentPosition = indexPath.row;
//        _commentReportSheet = [[UIActionSheet alloc]initWithTitle:@"评论内容" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"回 复", @"复制文字", @"举报该评论", nil];
//        [_commentReportSheet showInView:self.view];
//    }
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//}
//
//- (void)pushToUser:(UserInfoNoPin *)userInfo
//{
//    UserViewController *user = [[UserViewController alloc]init];
//    user.hidesBottomBarWhenPushed=YES;
//    user.user = userInfo;
//    [self.navigationController pushViewController:user animated:YES];
//}
//
//- (void)delegateForPinCommentItemUser:(PinCommentViewCell *)cell
//{
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    
//    UserViewController *user = [[UserViewController alloc]init];
//    user.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:user animated:YES];
//    Pin *pin = _comments.info[indexPath.row];
//    user.user = pin.user;
//}
//
//- (void)pinViewPlayerCellRemoveReusePlayManageView
//{
//    _currentPlayingCell = nil;
//}
//
////- (void)pinViewPlayerCellPlayButtonTappedWithIndex:(NSInteger)index AndCell:(PinViewPlayerCell *)cell
////{
////    if(_currentPlayingCell){
////        [_currentPlayingCell backToInitState];
////        _currentPlayingCell = nil;
////    }
////    _currentPlayingCell = cell;
////}
//
////将要开始编辑
//// - (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
//
////将要结束编辑
//// - (BOOL)textViewShouldEndEditing:(UITextView *)textView;
//
////开始编辑
//// - (void)textViewDidBeginEditing:(UITextView *)textView;
//
////结束编辑
//// - (void)textViewDidEndEditing:(UITextView *)textView;
//
////内容将要发生改变编辑
// - (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    // 限制行数
//    if (textView.contentSize.height > 104) {
//        textView.text = [textView.text substringToIndex:[textView.text length]-1];
//        return NO;
//    }
//    
//    return YES;
//}
//
////内容发生改变编辑
//- (void) textViewDidChange:(UITextView *)textView
//{
//
//}
//
//#pragma actionSheet delegate
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    
//    if (actionSheet == _moreSheet) {
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (buttonIndex == 0)  {
//                if (_pin.user_id == [self loginUserId]) {
//                    [self showDeleteDialog];
//                }
//            }
//        });
//        
//    } else if (actionSheet == _reportSheet) {
//        NSString *report = nil;
//        switch (buttonIndex) {
//            case 0:
//                report = @"带有色情或政治内容";
//                [self reportPin:report];
//                break;
//            case 1:
//                report = @"盗用他人的作品";
//                [self reportPin:report];
//                break;
//            case 2:
//                report = @"其他原因";
//                [self reportPin:report];
//                break;
//        }
//        
//    } else if (actionSheet == _commentReportSheet) {
//        
//        switch (buttonIndex) {
//            case 0:
//                [self commentAt];
//                break;
//            case 1:
//                [self commentCopy];
//                break;
//            case 2:
//                _isReportComment = YES;
//                [self showReportSheet];
//                break;
//                
//            default:
//                break;
//        }
//        
//    }
//    
//}
//
//- (void)commentAt
//{
//    Comment *comment = _comments.info[_commentPosition];
//    [StringUtils updateTextViewTextInsertedString:self.textView withText:[NSString stringWithFormat:@"@%@ ",comment.user.username] isTag:NO];
//}
//
//- (void)commentCopy
//{
//    Comment *comment = _comments.info[_commentPosition];
//    [[UIPasteboard generalPasteboard] setPersistent:YES];
//    [[UIPasteboard generalPasteboard] setValue:comment.raw_text forPasteboardType:[UIPasteboardTypeListString objectAtIndex:0]];
//    
//    [SVProgressHUD showSuccessWithStatus:@"成功复制到剪切板"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
//}
//
//- (void)shareDelete
//{
//    [super shareDelete];
//    [self showDeleteDialog];
//}
//
//- (void)shareReport
//{
//    [super shareReport];
//    [self showReportSheet];
//}
//
//- (void)showDeleteDialog
//{
//    BabyDialog *dialogView = [[BabyDialog alloc]initWithTitle:@"删 除" whitCancelText:@"取消" withSubmitText:@"删 除" withContentText:@"您确定要删除这个萌宝拍吗？" isFlip:NO];
//    dialogView.onSubmtClick = ^(){
//        [_modal closeWithLeansRandom];
//        [self deletePin];
//        
//    };
//    dialogView.onCancelClick = ^(){
//        [_modal closeWithLeansRandom];
//    };
//    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    _modal = [PathDynamicModal showWithModalView:dialogView inView:window];
//    _modal.showMagnitude = 100.0f;
//    _modal.closeMagnitude = 160.0f;
//}
//
//- (void)reportPin:(NSString *)report
//{
//    NSString *fields;
//    
//    long myId = [self loginUserId] > 0 ? [self loginUserId] : 0;
//    if (!_isReportComment)
//        fields = [NSString stringWithFormat:@"{\"report_user_id\":\"%ld\",\"user_id\":\"%ld\",\"pin_id\":\"%ld\",\"comment_id\":\"0\",\"report_title\":\"%@\",\"report_type\":\"pin\"}",myId, _pin.user_id, _pin.pin_id, report];
//    else {
//        Comment *comment = _comments.info[_commentPosition];
//        
//        fields = [NSString stringWithFormat:@"{\"report_user_id\":\"%ld\",\"user_id\":\"%ld\",\"pin_id\":\"%ld\",\"comment_id\":\"%ld\",\"report_title\":\"%@\",\"report_type\":\"comment\"}",myId, comment.user.user_id, _pin.pin_id, comment.comment_id, report];
//    }
//    
//    DataCompletionBlock completionBlock = ^(NSDictionary *data, NSString *errorString){
//        
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        
//        if (data != nil) {
//            PostMessage *message = [PostMessage mj_objectWithKeyValues:data];
//            if (message.msg == 0) {
//                [SVProgressHUD showSuccessWithStatus:message.info];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                });
//            } else {
//                [SVProgressHUD showErrorWithStatus:message.info];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                });
//            }
//        }
//    };
//    
//    BabyDataSource *souce = [BabyDataSource dataSource];
//    
//    
//    [souce getData:REPORT parameters:fields completion:completionBlock];
//    
//}
//
//- (void)deletePin
//{
//    DataCompletionBlock completionBlock = ^(NSDictionary *data, NSString *errorString){
//        
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        
//        if (data != nil) {
//            PostMessage *message = [PostMessage mj_objectWithKeyValues:data];
//            if (message.msg == 0) {
//                [SVProgressHUD showSuccessWithStatus:message.info];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                });
//                _isDel = YES;
//                
//                [self.navigationController popViewControllerAnimated:YES];
//            } else {
//                [SVProgressHUD showErrorWithStatus:message.info];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                });
//            }
//        }
//    };
//    
//    
//    BabyDataSource *souce = [BabyDataSource dataSource];
//    
//    NSString *fields = [NSString stringWithFormat:@"{\"pinid\":\"%ld\",\"user_id\":\"%ld\"}", _pin.pin_id, [self loginUserId]];
//    
//    
//    [souce getData:PIN_DEL parameters:fields completion:completionBlock];
//}
//
//- (void)showReportSheet
//{
//    _reportSheet = [[UIActionSheet alloc]initWithTitle:@"举 报" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"带有色情或政治内容", @"盗用他人的作品", @"其他原因", nil];
//    [_reportSheet showInView:self.view];
//}
//
//- (CGFloat)cellContentViewWith
//{
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    
//    // 适配ios7
//    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
//        width = [UIScreen mainScreen].bounds.size.height;
//    }
//    return width;
//}
//
@end
