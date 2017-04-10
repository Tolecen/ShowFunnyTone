//
//  BoardsViewController.m
//  Babypai
//
//  Created by ning on 16/4/25.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "BoardsViewController.h"
#import "MJRefresh.h"
#import "CellBoard.h"
//#import "PinsViewController.h"
#import "StringUtils.h"
#import "SVProgressHUD.h"
#import "CellNoData.h"
#import "BabyDialog.h"
#import "Babypai-swift.h"
#import "PostMessage.h"


@interface BoardsViewController ()<UITableViewDelegate,UITableViewDataSource, UIAlertViewDelegate>
{
    BOOL _isLoading;
}
@property (nonatomic, strong) Boards *boards;
@property (nonatomic, assign) int cursor;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) long boardPosition;
@property (nonatomic, assign) long boardPositionId;
@property (nonatomic, strong) NSString *boardPositionName;

@property(nonatomic, weak) PathDynamicModal *modal;

@end

@implementation BoardsViewController

- (NSString *)title
{
    switch (_boardType) {
        case BOARDS_TYPE_NORMARL:
            return @"影 集";
            break;
        case BOARDS_TYPE_SELECT:
            return @"选择影集";
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if (_boardType == BOARDS_TYPE_SELECT) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
//    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@页面", [self title]]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:[NSString stringWithFormat:@"%@页面",[self title]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _cursor = 0;
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColorFromRGB(BABYCOLOR_background);
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[CellBoard class] forCellReuseIdentifier:NSStringFromClass([CellBoard class])];
    [self.tableView registerClass:[CellNoData class] forCellReuseIdentifier:NSStringFromClass([CellNoData class])];
    
    [self loadData];
}

- (void)initUserInfo
{
    [super initUserInfo];
    
    if ([self loginUserId] == _user_id) {
        UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"添加影集" style:UIBarButtonItemStylePlain target:self action:@selector(addBoardAdd)];
        self.navigationItem.rightBarButtonItem = myButton;
    }
 
}

- (void)boardDelDialog
{
    
    NSString *tips = [NSString stringWithFormat:@"确定要删除“%@”影集吗？（影集里面珍贵的视频也会被删除哦~）", _boardPositionName];
    
    BabyDialog *dialogView = [[BabyDialog alloc]initWithTitle:@"提 示" whitCancelText:@"取消" withSubmitText:@"确 定" withContentText:tips isFlip:NO];
    dialogView.onSubmtClick = ^(){
        [_modal closeWithLeansRandom];
        [self delBoard];
        
    };
    dialogView.onCancelClick = ^(){
        [_modal closeWithLeansRandom];
    };
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _modal = [PathDynamicModal showWithModalView:dialogView inView:window];
    _modal.showMagnitude = 100.0f;
    _modal.closeMagnitude = 160.0f;
}

- (void)delBoard
{
    DataCompletionBlock completionBlock = ^(NSDictionary *data, NSString *errorString){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (data != nil) {
            PostMessage *message = [PostMessage mj_objectWithKeyValues:data];
            [SVProgressHUD showErrorWithStatus:message.info];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
            if (message.msg == 0) {
                long myBoardCount = [self loginUserInfomation].info.board_count;
                myBoardCount--;
                [self loginUserInfomation].info.board_count = myBoardCount;
                [Utils updataUserInfoDic:[self loginUserInfomation]];
                
                [_boards.info removeObjectAtIndex:_boardPosition];
                [_tableView reloadData];
                
            }
        } else {
            
        }
    };
    
    
    BabyDataSource *souce = [BabyDataSource dataSource];
    
    NSString *fields = [NSString stringWithFormat:@"{\"user_id\":\"%ld\",\"board_id\":\"%ld\"}", _user_id, _boardPositionId];
    
    
    [souce getData:BOARD_DEL parameters:fields completion:completionBlock];
}

- (void)addBoardAdd
{
    _boardPositionName = @"";
    _boardPositionId = 0;
    _boardPosition = 0;
    [self addBoard:NO];
}

- (void)addBoard:(BOOL)isEdit
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:isEdit ? @"编辑影集" :@"添加影集" message:nil delegate:self cancelButtonTitle:isEdit ? @"确定" :@"添加" otherButtonTitles:@"取消", nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alertView show];
    
    UITextField *tf = [alertView textFieldAtIndex:0];
    if (isEdit) {
        tf.text = _boardPositionName;
    }
    
}

#pragma mark   获得输入框里的值
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        UITextField *tf = [alertView textFieldAtIndex:0];//获得输入框
        NSString *boardName = tf.text;//获得值
        NSLog(@"boardName : %@", boardName);
        
        [self addBoardSubmit:boardName];
    }
}

- (void)addBoardSubmit:(NSString *)boardName
{
    if ([StringUtils isEmpty:boardName]) {
        [SVProgressHUD showErrorWithStatus:@"请填写影集名称"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    DataCompletionBlock completionBlock = ^(NSDictionary *data, NSString *errorString){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (data != nil) {
            _boards = [Boards mj_objectWithKeyValues:data];
            
            if (_boards.msg > 0) {
                if (_boardPosition == 0) {
                    [SVProgressHUD showErrorWithStatus:@"添加影集失败"];
                } else {
                    [SVProgressHUD showErrorWithStatus:@"编辑影集失败"];
                }
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            } else {
                if (_boardPosition == 0) {
                    [SVProgressHUD showSuccessWithStatus:@"成功添加影集"];
                    long myBoardCount = [self loginUserInfomation].info.board_count;
                    myBoardCount++;
                    [self loginUserInfomation].info.board_count = myBoardCount;
                    [Utils updataUserInfoDic:[self loginUserInfomation]];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                _cursor = 0;
                [self.tableView reloadData];
            }
            
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
    };
    
    
    BabyDataSource *souce = [BabyDataSource dataSource];
    
    NSString *fields = [NSString stringWithFormat:@"{\"board_name\":\"%@\",\"board_id\":\"%ld\",\"user_id\":\"%ld\"}", boardName, _boardPositionId, _user_id];
    
    
    [souce getData:BOARD_ADD parameters:fields completion:completionBlock];
    
}

- (void)loadData
{
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataRefresh)];
    // 设置普通状态的动画图片
    [header setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:refreshingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    // 设置header
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
    
    
}

- (void)loadDataMore
{
    _cursor++;
    [self loadNewData];
}

- (void)loadNewDataRefresh
{
    _cursor = 0;
    _isLoading = YES;
    [self loadNewData];
}

- (void)loadNewData
{
    DataCompletionBlock completionBlock = ^(NSDictionary *data, NSString *errorString){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (data != nil) {
            if (_cursor == 0) {
                _boards = nil;
            }
            
            [self processData:data];
        } else {
            
        }
    };
    
    
    BabyDataSource *souce = [BabyDataSource dataSource];
    
    NSString *fields = [NSString stringWithFormat:@"{\"cursor\":\"%d\",\"uid\":\"%ld\"}", _cursor, _user_id];

    
    [souce getData:USER_BOARDS parameters:fields completion:completionBlock];
}

- (void)processData:(NSDictionary *)data
{
    _isLoading = NO;
    if(_boards == nil) {
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataMore)];
        [footer setTitle:NOMOREDATA forState:MJRefreshStateNoMoreData];
        self.tableView.mj_footer = footer;
        _boards = [Boards mj_objectWithKeyValues:data];
    } else {
        Boards *boards = [Boards mj_objectWithKeyValues:data];
        [_boards.info addObjectsFromArray:boards.info];
        
        if ([boards.info count] == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    
    if ([_boards.info count] == 0) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        
        if ([_boards.info count] < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (_boards.info.count == 0) {
        return 1;
    }
    return _boards.info.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_boards.info.count == 0) {
        return kCellNoDataH;
    }
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* tableCell = nil;
    if (_boards.info.count == 0) {
        CellNoData *tagCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellNoData class])];
        tagCell.loadingData = _isLoading;
        tableCell = tagCell;
        tableCell.backgroundColor = [UIColor clearColor];
    } else {
        CellBoard *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellBoard class])];
        
        cell.board = _boards.info[indexPath.row];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(BABYCOLOR_background);
        tableCell = cell;
    }
    
   
    return tableCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UserViewController *user = [[UserViewController alloc]init];
//    user.hidesBottomBarWhenPushed=YES;
//    user.user = _boards.info[indexPath.row];
//    [self.navigationController pushViewController:user animated:YES];
    
    if (_boards.info.count == 0) {
        return;
    }
    
    if (_boardType == BOARDS_TYPE_SELECT) {
        if (self.onBoardSelect) {
            _onBoardSelect(_boards.info[indexPath.row]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
        Board *board = _boards.info[indexPath.row];
        
        PinsViewController *pinsVC = [[PinsViewController alloc] init];
        pinsVC.board_id = board.board_id;
        pinsVC.board_name = board.title;
        pinsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pinsVC animated:YES];
    }
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        DLog(@"点击了删除");
        Board *board = _boards.info[indexPath.row];
        _boardPosition = (long)indexPath.row;
        _boardPositionId = board.board_id;
        _boardPositionName = board.title;
        [self boardDelDialog];
    }];
    
    // 删除一个置顶按钮
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        DLog(@"点击了编辑");
        Board *board = _boards.info[indexPath.row];
        _boardPosition = (long)indexPath.row;
        _boardPositionId = board.board_id;
        _boardPositionName = board.title;
        [self addBoard:YES];
        
    }];
    editRowAction.backgroundColor = UIColorFromRGB(BABYCOLOR_comment_text);
    
    // 将设置好的按钮放到数组中返回
    return @[deleteRowAction, editRowAction];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_boards.info.count == 0 || _user_id != [self loginUserId]) {
        return NO;
    }
    return YES;
}

@end
