//
//  UserViewController.m
//  Babypai
//
//  Created by ning on 15/4/19.
//  Copyright (c) 2015年 Babypai. All rights reserved.
//

#import "UserViewController.h"
#import "Vue-Swift.h"


//#import "UserTopInfoCell.h"
//#import "Pins.h"
//#import "Pin.h"
//#import "UIButton+UIButtonImageWithLabel.h"
//#import "UIImageView+WebCache.h"
//#import "MJRefresh.h"
//#import "PinDetailViewController.h"
//#import "ALDBlurImageProcessor.h"
//#import "UITableView+SDAutoTableViewCellHeight.h"
//#import "UsersViewController.h"
//#import "BoardsViewController.h"
//
//#import "PinViewTopCell.h"
//#import "PinViewPlayerCell.h"
//#import "PinViewBottomCell.h"
//#import "StringUtils.h"
//#import "TagViewController.h"
//#import "CellNoData.h"
//
//#import "BabyDialog.h"
//#import "BabyPai-swift.h"
//#import "PostMessage.h"
//#import "SVProgressHUD.h"

@interface UserViewController () <UITableViewDataSource, UITableViewDelegate, DetailsPageDelegate>
{
    BOOL _isLoading;
}
@property (assign) CGPoint scrollViewDragPoint;

@property (assign) int cursor;

//@property (strong, nonatomic) PinViewPlayerCell *currentPlayingCell;
@property (assign, nonatomic) NSInteger currentPlayingIndex;

@property (strong, nonatomic) NSMutableArray *listArray;
@property (strong, nonatomic) NSMutableArray *visibleIndexArray;
@property (assign, nonatomic) BOOL ifAutoPlay;                  //是否自动播放

@property(nonatomic, weak) PathDynamicModal *modal;

@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation UserViewController
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    [MobClick beginLogPageView:@"用户详情页面"];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    if(_currentPlayingCell){
//        [_currentPlayingCell backToInitState];
//        _currentPlayingCell = nil;
//    }
//    [MobClick endLogPageView:@"用户详情页面"];
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    if ([[Utils utils] canAutoPlay:[self isNetworkWAN]]) {
//        _ifAutoPlay = YES;
//    } else {
//        _ifAutoPlay = NO;
//    }
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    _cursor = 0;
//    _visibleIndexArray = [[NSMutableArray alloc]init];
//    [self setupViews];
//    [self setupDetailsPageView];
//    [self requestUserDetails];
//}
//
//- (void)setupViews
//{
//    self.detailsPageView = [[DetailsPageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self.view addSubview:self.detailsPageView];
//    
//    
//    _navBarBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shadow_asset_details"]];
//    //    _navBarBg.backgroundColor = UIColorFromRGB(BABYCOLOR_base_color);
//    _navBarBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, TopBar_height);
//    [self.view addSubview:_navBarBg];
//    
//    _navBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TopBar_height)];
//    _navBarView.backgroundColor = UIColorFromRGB(BABYCOLOR_base_color);
//    _navBarView.alpha = 0.0;
//    [self.view addSubview:_navBarView];
//    
//    _navBarTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, StatusBar_height, SCREEN_WIDTH, NavigationBar_HEIGHT)];
//    _navBarTitleLabel.font = kFontSize(18);
//    _navBarTitleLabel.textColor = [UIColor whiteColor];
//    _navBarTitleLabel.textAlignment = NSTextAlignmentCenter;
//    [_navBarView addSubview:_navBarTitleLabel];
//    
//    [self setupNavbarButtons];
//}
//
//- (void)setupDetailsPageView
//{
//    self.detailsPageView.tableViewDataSource = self;
//    self.detailsPageView.tableViewDelegate = self;
//    self.detailsPageView.delegate = self;
//    self.detailsPageView.tableViewSeparatorColor = [UIColor clearColor];
//    self.detailsPageView.tableView.backgroundColor = BACKGROUND_COLOR;
//}
//
//- (void)setupNavbarButtons
//{
////    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
////    buttonBack.frame = CGRectMake(10, 31, 22, 22);
////    [buttonBack setImage:ImageNamed(@"baby_icn_back") forState:UIControlStateNormal];
////    [buttonBack addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
////    [self.view addSubview:buttonBack];
//    
//    UIButton *backBtn = [[UIButton alloc]init];
//    [backBtn setImage:[UIImage imageNamed:@"baby_icn_back"] withTitle:@"返回" titleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [backBtn setImage:[UIImage imageNamed:@"baby_icn_back"] withTitle:@"返回" titleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    backBtn.titleLabel.font = kFontSize(18);
//    [self.view addSubview:backBtn];
//    [backBtn addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
//    CGSize backSize = [@"返回" sizeWithAttributes:@{NSFontAttributeName: kFontSize(18)}];
//    
//    backBtn.sd_layout
//    .widthIs(backSize.width + 32)
//    .heightIs(backSize.height)
//    .leftSpaceToView(self.view, 10)
//    .topSpaceToView(self.view, (84 - backSize.height) / 2);
//    
//    
//    UIButton *shareBtn = [[UIButton alloc]init];
//    [shareBtn setImage:[UIImage imageNamed:@"baby_icn_share"] withTitle:@"分享" titleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [shareBtn setImage:[UIImage imageNamed:@"baby_icn_share"] withTitle:@"分享" titleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    shareBtn.titleLabel.font = kFontSize(18);
//    if (_user == nil) {
//        shareBtn.hidden = YES;
//    } else {
//        shareBtn.hidden = NO;
//    }
//    _shareButton = shareBtn;
//    [self.view addSubview:shareBtn];
//    [shareBtn addTarget:self action:@selector(shareUserClick) forControlEvents:UIControlEventTouchUpInside];
//    CGSize shareSize = [@"分享" sizeWithAttributes:@{NSFontAttributeName: kFontSize(18)}];
//    
//    shareBtn.sd_layout
//    .widthIs(shareSize.width + 32)
//    .heightIs(shareSize.height)
//    .rightSpaceToView(self.view, 10)
//    .topSpaceToView(self.view, (84 - shareSize.height) / 2);
//    
//    _navBarTitleLabel.text = self.user.username;
//    
//}
//
//- (void)shareUserClick
//{
//    if (self.user) {
//        [self shareUser:self.user];
//    } else {
//        [self shareUser:self.userInfomation.info];
//    }
//    
//}
//
//- (void)requestUserDetails
//{
//    _isLoading = YES;
//    DataCompletionBlock completionBlock = ^(NSDictionary *data, NSString *errorString){
//        
//        //shua xin stop
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        
//        if (data != nil) {
//            [self processDetailsData:data];
//        } else {
//            
//        }
//    };
//    
//    BabyDataSource *souce = [BabyDataSource dataSource];
//    NSString *fields;
//    if (self.user != nil && self.user.user_id > 0) {
//        fields = [NSString stringWithFormat:@"{\"userName\":\"%@\",\"uid\":\"%ld\",\"userId\":\"%ld\",\"havePin\":\"0\"}", self.user.username, self.user.user_id, [self loginUserId]];
//    } else {
//        _userId = _userId > 0 ? _userId : 0;
//        if (![StringUtils isEmpty:self.userName] || _userId > 0) {
//            fields = [NSString stringWithFormat:@"{\"userName\":\"%@\",\"uid\":\"%ld\",\"userId\":\"%ld\",\"havePin\":\"0\"}", self.userName, _userId, [self loginUserId]];
//        }
//    }
//    
//    [souce getData:USER_INFOMATION parameters:fields completion:completionBlock];
//
//}
//
//- (void)requestUserPins
//{
//    _cursor++;
//    [self loadNewData];
//}
//
//- (void)loadNewData
//{
//    DataCompletionBlock completionBlockPin = ^(NSDictionary *data, NSString *errorString){
//        
//        //shua xin stop
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        [self.detailsPageView.tableView.mj_footer endRefreshing];
//        if (data != nil) {
//            [self processUserPins:data];
//        } else {
//            
//        }
//    };
//    BabyDataSource *souce = [BabyDataSource dataSource];
//    
//    NSString *fields = [NSString stringWithFormat:@"{\"cursor\":\"%d\",\"uid\":\"%ld\",\"userId\":\"%ld\"}", _cursor, _userInfomation.info.user_id,  [self loginUserId]];
//    [souce getData:USER_INFOMATION_PINS parameters:fields completion:completionBlockPin];
//}
//
//- (void)processUserPins:(NSDictionary *)data
//{
//    _isLoading = NO;
//    Pins *pins = [Pins mj_objectWithKeyValues:data];
//    
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestUserPins)];
//    self.detailsPageView.tableView.mj_footer = footer;
//    
//    if ([pins.info count] == 0) {
//        [self.detailsPageView.tableView.mj_footer endRefreshingWithNoMoreData];
//    } else {
//        if (self.userInfomation.info.pins == nil) {
//            self.userInfomation.info.pins = [[NSMutableArray alloc]init];
//        }
//        [self.userInfomation.info.pins addObjectsFromArray:pins.info];
//        
//    }
//    [self.detailsPageView.tableView reloadData];
//}
//
//- (void)processDetailsData:(NSDictionary *)data
//{
//    self.userInfomation = [UserInfomation mj_objectWithKeyValues:data];
//    
//    if (self.userInfomation.msg > 0) {
//        [SVProgressHUD showErrorWithStatus:@"Opps!数据错误啦，稍后再试吧~"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//            [self.navigationController popViewControllerAnimated:YES];
//        });
//        return;
//    }
//    
//    if (self.userInfomation.info.user_id == [self loginUserId]) {
//        [Utils updataUserInfoDic:self.userInfomation];
//    }
//    
//    _navBarTitleLabel.text = self.userInfomation.info.username;
//    [self loadNewData];
//    
////    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestUserPins)];
////    footer.state = MJRefreshStateRefreshing;
////    footer.stateLabel.hidden = YES;
////    self.detailsPageView.tableView.mj_footer = footer;
//    
//    if (self.user == nil) {
//        [self.detailsPageView reloadDataStrong];
//    } else {
//        [self.detailsPageView reloadData];
//    }
//    
//    self.detailsPageView.navBarView = self.navBarView;
//}
//
//- (void)popViewController:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
////返回多少个section
//-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
//{
//    if ([_userInfomation.info.pins count] == 0) {
//        return 2;
//    }
//    return 1 + [_userInfomation.info.pins count];
//}
//
////返回行数，也就是返回数组中所存储数据，也就是section的元素
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 1;
//    } else {
//        if ([_userInfomation.info.pins count] == 0) {
//            return 1;
//        }
//        return 3;
//    }
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0) {
//        return [self.detailsPageView.tableView cellHeightForIndexPath:indexPath model:_userInfomation.info keyPath:@"userInfo" cellClass:[UserTopInfoCell class] contentViewWidth:[self cellContentViewWith]];
//    } else {
//        
//        if ([_userInfomation.info.pins count] == 0) {
//            return kCellNoDataH;
//        } else {
//            switch (indexPath.row) {
//                case 0:
//                    return pinViewTopH;
//                case 1:
//                    return [self.detailsPageView.tableView cellHeightForIndexPath:indexPath model:_userInfomation.info.pins[indexPath.section - 1] keyPath:@"pin" cellClass:[PinViewPlayerCell class] contentViewWidth:[self cellContentViewWith]];
//                case 2:
//                    return [self.detailsPageView.tableView cellHeightForIndexPath:indexPath model:_userInfomation.info.pins[indexPath.section - 1] keyPath:@"pin" cellClass:[PinViewBottomCell class] contentViewWidth:[self cellContentViewWith]];
//                default:
//                    return pinViewTopH;
//            }
//        }
//        
//        
//    }
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
//        UserTopInfoCell *userCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserTopInfoCell class])];
//        if (userCell == nil) {
//            userCell = [[UserTopInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UserTopInfoCell class])];
//        }
//        
//        userCell.pinClicked = ^(){
//            
//        };
//        
//        userCell.boardClicked = ^(){
//            BoardsViewController *boardsVC = [[BoardsViewController alloc]init];
//            boardsVC.boardType = BOARDS_TYPE_NORMARL;
//            boardsVC.user_id = _userInfomation.info.user_id;
//            boardsVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:boardsVC animated:YES];
//        };
//        
//        userCell.followingClicked = ^(){
//            NSLog(@"followingClicked");
//            UsersViewController *usersVC = [[UsersViewController alloc]init];
//            usersVC.hidesBottomBarWhenPushed = YES;
//            usersVC.pinUserId = _userInfomation.info.user_id;
//            usersVC.userType = USER_TYPE_FOLLOWING;
//            [self.navigationController pushViewController:usersVC animated:YES];
//        };
//        
//        userCell.followerClicked = ^(){
//            NSLog(@"followerClicked");
//            UsersViewController *usersVC = [[UsersViewController alloc]init];
//            usersVC.hidesBottomBarWhenPushed = YES;
//            usersVC.pinUserId = _userInfomation.info.user_id;
//            usersVC.userType = USER_TYPE_FOLLOWER;
//            [self.navigationController pushViewController:usersVC animated:YES];
//        };
//        
//        if (_userInfomation != nil && _userInfomation.info != nil) {
//            userCell.userInfo = _userInfomation.info;
//        } else {
//            userCell.userInfo = _user;
//        }
//        tableCell = userCell;
//        tableCell.backgroundColor = [UIColor clearColor];
//    } else {
//        
//        if ([_userInfomation.info.pins count] == 0) {
//            
//            CellNoData *tagCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellNoData class])];
//            
//            if (tagCell == nil) {
//                tagCell = [[CellNoData alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CellNoData class])];
//            }
//            tagCell.loadingData = _isLoading;
//            tableCell = tagCell;
//            tableCell.backgroundColor = [UIColor clearColor];
//        } else {
//        
//            switch (indexPath.row) {
//                case 0: {
//                    PinViewTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PinViewTopCell class])];
//                    if (cell == nil) {
//                        cell = [[PinViewTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PinViewTopCell class])];
//                    }
//                    cell.pin = _userInfomation.info.pins[indexPath.section - 1];
//                    cell.cellIndex = indexPath.section - 1;
//                    
//                    cell.userClicked = ^(NSInteger cellIndex, UserInfoNoPin *user){
//                        [self pushToUser:user];
//                    };
//                    tableCell = cell;
//                    tableCell.backgroundColor = [UIColor whiteColor];
//                }
//                    break;
//                case 1: {
//                    PinViewPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PinViewPlayerCell class])];
//                    if (cell == nil) {
//                        cell = [[PinViewPlayerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PinViewPlayerCell class])];
//                    }
//                    cell.pin = _userInfomation.info.pins[indexPath.section - 1];
//                    cell.cellIndex = indexPath.section - 1;
//                    
//                    cell.delegate = self;
//                    if( !_ifAutoPlay ){
//                        cell.isCurrentCellPlaying = NO;
//                    }
//                    else{
//                        cell.isCurrentCellPlaying = NO;
//                        if(_currentPlayingIndex == (indexPath.section - 1)){
//                            cell.isCurrentCellPlaying = YES;
//                        }
//                    }
//                    [cell playCurrentVideo];
//                    
//                    cell.privateClicked = ^(NSInteger cellIndex) {
//                        [self pinPrivateDialog:_userInfomation.info.pins[cellIndex] atLocation:cellIndex];
//                    };
//                    
//                    tableCell = cell;
//                    tableCell.backgroundColor = [UIColor clearColor];
//                }
//                    break;
//                case 2: {
//                    PinViewBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PinViewBottomCell class])];
//                    if (cell == nil) {
//                        cell = [[PinViewBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PinViewBottomCell class])];
//                    }
//                    cell.pin = _userInfomation.info.pins[indexPath.section - 1];
//                    cell.cellIndex = indexPath.section - 1;
//                    
//                    cell.likeUserClicked = ^(NSInteger cellIndex) {
//                        [self pushToPinDetail:indexPath];
//                    };
//                    
//                    cell.shareClicked = ^(NSInteger cellIndex, Pin *pin) {
//                        [self sharePin:pin];
//                        if (_currentPlayingCell) {
//                            [_currentPlayingCell pauseCurrentVideo];
//                        }
//                    };
//                    
//                    cell.likeClicked = ^(NSInteger cellIndex) {
//                        if (![self isLogin]) {
//                            [self loginUser];
//                            return;
//                        }
//                        
//                        Pin *pin = _userInfomation.info.pins[cellIndex];
//                        
//                        if (pin.liked == 0) {
//                            pin.liked = 1;
//                            pin.like_count ++;
//                            if (pin.like_user == nil) {
//                                pin.like_user = [[NSMutableArray alloc]init];
//                            }
//                            [pin.like_user insertObject:[self loginUserInfomation].info atIndex:0];
//                            
//                            [self pinLikePost:pin withLike:@"like"];
//                            
//                        } else {
//                            pin.liked = 0;
//                            pin.like_count --;
//                            NSMutableArray *users = pin.like_user;
//                            for (int i = 0; i < [users count]; i++) {
//                                UserInfo *user = users[i];
//                                if (user.user_id == [self loginUserId]) {
//                                    [users removeObjectAtIndex:i];
//                                    break;
//                                }
//                            }
//                            pin.like_user = users;
//                            [self pinLikePost:pin withLike:@"unlike"];
//                        }
//                        
//                        _userInfomation.info.pins[cellIndex] = pin;
//                        [self.detailsPageView.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//                        
//                    };
//                    
//                    cell.rawTextUser = ^(NSString *userName) {
//                        UserViewController *user = [[UserViewController alloc]init];
//                        user.userName = userName;
//                        user.hidesBottomBarWhenPushed=YES;
//                        [self.navigationController pushViewController:user animated:YES];
//                    };
//                    
//                    cell.rawTextTag = ^(NSString *tagString, long tag_id) {
//                        TagViewController *tag = [[TagViewController alloc]init];
//                        tag.tag_id = tag_id;
//                        tag.tagString = tagString;
//                        tag.hidesBottomBarWhenPushed=YES;
//                        [self.navigationController pushViewController:tag animated:YES];
//                    };
//                    
//                    tableCell = cell;
//                    tableCell.backgroundColor = [UIColor whiteColor];
//                }
//                    break;
//            }
//        }
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
//                _userInfomation.info.pins[position] = pin;
//                NSIndexPath *bottomIndexPath = [NSIndexPath indexPathForRow:1 inSection:position + 1];
//                [self.detailsPageView.tableView reloadRowsAtIndexPaths:@[bottomIndexPath] withRowAnimation:UITableViewRowAnimationNone];
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
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if ([_userInfomation.info.pins count] > 0 && indexPath.section > 0) {
//        [self pushToPinDetail:indexPath];
//    }
//    
//}
//
//- (void)pushToPinDetail:(NSIndexPath *)indexPath
//{
//    PinDetailViewController *pinDetail = [[PinDetailViewController alloc]init];
//    pinDetail.hidesBottomBarWhenPushed=YES;
//    Pin *pin = _userInfomation.info.pins[indexPath.section - 1];
//    pinDetail.pin = pin;
//    pinDetail.position = indexPath.section - 1;
//    pinDetail.pinEdit = ^(long position, Pin *pinEdit, BOOL isDel) {
//        if (isDel) {
//            [_userInfomation.info.pins removeObjectAtIndex:position];
//            [self.detailsPageView.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
//            [self.detailsPageView.tableView reloadData];
//        } else {
//            _userInfomation.info.pins[position] = pinEdit;
//            NSIndexPath *bottomIndexPath = [NSIndexPath indexPathForRow:2 inSection:(position + 1)];
//            [self.detailsPageView.tableView reloadRowsAtIndexPaths:@[bottomIndexPath] withRowAnimation:UITableViewRowAnimationNone];
//        }
//    };
//    
//    [self.navigationController pushViewController:pinDetail animated:YES];
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 1) {
//        [self addOneIndexPathToVisibleIndexArrayWithValue:indexPath];
//    }
//}
//
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 1) {
//        [_visibleIndexArray removeObject:indexPath];
//        if(_currentPlayingIndex == (indexPath.section - 1)){
//            if(_currentPlayingCell){
//                [_currentPlayingCell backToInitState];
//                _currentPlayingCell = nil;
//            }
//        }
//    }
//}
//
//#pragma mark --- PinViewPlayerCellDelegate ---
//
//- (void)pinViewPlayerCellRemoveReusePlayManageView
//{
//    _currentPlayingCell = nil;
//}
//
//- (void)pinViewPlayerCellPlayButtonTappedWithIndex:(NSInteger)index AndCell:(PinViewPlayerCell *)cell
//{
//    if(_currentPlayingCell){
//        [_currentPlayingCell backToInitState];
//        _currentPlayingCell = nil;
//    }
//    _currentPlayingIndex = index;
//    _currentPlayingCell = cell;
//}
//
//
//
//- (void)setCurrentPlayingIndex:(NSInteger)currentPlayingIndex
//{
//    DLog(@"setCurrentPlayingIndex : %ld", (long)currentPlayingIndex);
//    if(_currentPlayingIndex != currentPlayingIndex){
//        _currentPlayingIndex = currentPlayingIndex;
//        [self.detailsPageView.tableView reloadData];
//    }
//}
//
//- (BOOL)judgeOneIndexPathIsExistInVisibleIndexArrayWithValue:(NSIndexPath *)indexPath
//{
//    NSInteger visibleCount = [_visibleIndexArray count];
//    for(int i=0; i < visibleCount; i++){
//        NSIndexPath *oneIndexPath = [_visibleIndexArray objectAtIndex:i];
//        if(oneIndexPath.section == indexPath.section){
//            return YES;
//        }
//    }
//    return NO;
//}
//
//- (void)addOneIndexPathToVisibleIndexArrayWithValue:(NSIndexPath *)indexPath
//{
//    BOOL isExist = [self judgeOneIndexPathIsExistInVisibleIndexArrayWithValue:indexPath];
//    DLog(@"addOneIndexPathToVisibleIndexArrayWithValue : %ld, isExist : %d", indexPath.section, isExist);
//    if( !isExist ){
//        [_visibleIndexArray addObject:indexPath];
//    }
//}
//
//- (NSInteger)getCurrentCellIndexShouldBePlaying
//{
//    NSInteger visibleCount = [_visibleIndexArray count];
//    if (visibleCount == 2 ){
//        CGFloat offsetY = self.detailsPageView.tableView.contentOffset.y;
//        NSIndexPath *firstIndexPath = [_visibleIndexArray firstObject];
//        NSIndexPath *lastIndexPath = [_visibleIndexArray lastObject];
//        
//        if (firstIndexPath.section > lastIndexPath.section) {
//            firstIndexPath = lastIndexPath;
//            lastIndexPath = [_visibleIndexArray firstObject];
//        }
//        
//        CGRect rectInTableView = [self.detailsPageView.tableView rectForRowAtIndexPath:firstIndexPath];
//        CGRect rectInSuperview = [self.detailsPageView.tableView convertRect:rectInTableView toView:[self.detailsPageView.tableView superview]];
//        
//        float cellOffsetY = rectInSuperview.origin.y - TopBar_height;//cell距离顶部的距离（用户可见部分）
//        float cellHeight = 1.0f;
//        if (_userInfomation.info.pins.count > (firstIndexPath.section - 1)) {
//            cellHeight = SCREEN_WIDTH;
//        }
//        float f3 = (cellOffsetY + cellHeight) / cellHeight;
//        if (offsetY > 0 && f3 < 0.5 && (lastIndexPath.section - 1) < _userInfomation.info.pins.count) {
//            return lastIndexPath.section - 1;
//        }
//        return firstIndexPath.section - 1;
//    }
//    else if( visibleCount == 3 ){
//        NSIndexPath *firstIndexPath = [_visibleIndexArray firstObject];
//        NSInteger smallIndex = firstIndexPath.section - 1;
//        for(int i = 1; i < visibleCount; i++){
//            NSIndexPath *oneIndexPath = [_visibleIndexArray objectAtIndex:i];
//            if(oneIndexPath.section <= smallIndex){
//                smallIndex = oneIndexPath.section - 1;
//            }
//        }
//        return smallIndex + 1;
//    }
//    return 0;
//}
//
//- (BOOL)judgeCurrentFullScreenPlayingCellIfOutOfScreen
//{
//    NSInteger visibleCount = [_visibleIndexArray count];
//    for(int i = 0; i < visibleCount; i++){
//        NSIndexPath *oneIndexPath = [_visibleIndexArray objectAtIndex:i];
//        if(_currentPlayingIndex == (oneIndexPath.section - 1)){
//            return NO;
//        }
//    }
//    return YES;
//}
//
//#pragma mark --- UIScrollViewDelegate ---
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
//    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.2];
//}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
//    BOOL isOutOfScreen = [self judgeCurrentFullScreenPlayingCellIfOutOfScreen];
//    if(isOutOfScreen){
//        if(_currentPlayingCell){
//            [_currentPlayingCell backToInitState];
//            _currentPlayingCell = nil;
//        }
//    }
//    if(_ifAutoPlay){
//        self.currentPlayingIndex = [self getCurrentCellIndexShouldBePlaying];
//    }
//}
//
//
//- (void)pushToUser:(UserInfoNoPin *)userInfo
//{
//    UserViewController *user = [[UserViewController alloc]init];
//    user.hidesBottomBarWhenPushed=YES;
//    user.user = userInfo;
//    [self.navigationController pushViewController:user animated:YES];
//}
//
//
//#pragma mark -
//#pragma mark UserDetailsPageDelegate
//
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    self.scrollViewDragPoint = scrollView.contentOffset;
//}
//
//- (CGPoint)detailsPage:(DetailsPageView *)detailsPageView tableViewWillBeginDragging:(UITableView *)tableView;
//{
//    return self.scrollViewDragPoint;
//}
//
//- (UIViewContentMode)contentModeForImage:(UIImageView *)imageView
//{
//    return UIViewContentModeScaleAspectFill;
//}
//
//- (UIImageView*)detailsPage:(DetailsPageView*)detailsPageView imageDataForImageView:(UIImageView*)imageView;
//{
//    long avatar_id;
//    BabyFile *avatar;
//    if (self.user == nil) {
//        avatar_id = self.userInfomation.info.avatar_id;
//        avatar = self.userInfomation.info.avatar;
//    } else {
//        avatar_id = self.user.avatar_id;
//        avatar = self.user.avatar;
//    }
//    
//    if(avatar_id > 0) {
//        
//        [imageView sd_setImageWithURL:[Utils getImagePathURL:avatar tagWith:nil] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            if (image != nil) {
//                [UIView animateWithDuration:0.3f animations:^{
//                ALDBlurImageProcessor *_blurImageProcessor = [[ALDBlurImageProcessor alloc] initWithImage: image];
//                [_blurImageProcessor asyncBlurWithRadius: 5
//                                              iterations: 7
//                                            successBlock: ^( UIImage *blurredImage) {
//                                                imageView.image = blurredImage;
//                                            }
//                                              errorBlock: ^( NSNumber *errorCode ) {
//                                                  NSLog( @"Error code: %d", [errorCode intValue] );
//                                              }];
//                }];
//            }
//        }];
//        
//    } else {
//        [imageView setImage:ImageNamed(@"avatar")];
//        
//        if (imageView.image != nil) {
//            [UIView animateWithDuration:0.3f animations:^{
//            ALDBlurImageProcessor *_blurImageProcessor = [[ALDBlurImageProcessor alloc] initWithImage: imageView.image];
//            [_blurImageProcessor asyncBlurWithRadius: 5
//                                          iterations: 7
//                                        successBlock: ^( UIImage *blurredImage) {
//                                            imageView.image = blurredImage;
//                                        }
//                                          errorBlock: ^( NSNumber *errorCode ) {
//                                              NSLog( @"Error code: %d", [errorCode intValue] );
//                                          }];
//            }];
//        }
//        
//    }
//    
//    return imageView;
//}
//
//#pragma mark pinViewCell delegate
//- (void)detailsPage:(DetailsPageView *)detailsPageView tableViewDidLoad:(UITableView *)tableView
//{
//    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//}
//
//- (void)detailsPage:(DetailsPageView *)detailsPageView headerViewDidLoad:(UIView *)headerView
//{
//    [headerView setAlpha:0.0];
//    [headerView setHidden:YES];
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
//
@end
