//
//  PublishUserViewController.m
//  Babypai
//
//  Created by ning on 16/5/10.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "PublishUserViewController.h"
#import "UserInfos.h"
#import "MJRefresh.h"
#import "CellUserPublish.h"

@interface PublishUserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UserInfos *userInfos;
@property (nonatomic, assign) int cursor;
@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) NSString *userName;

@property(nonatomic, strong) NSMutableArray *friends;

@end

@implementation PublishUserViewController

- (NSString *)title
{

    return @"选择好友";

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //[MobClick beginLogPageView:[self title]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[MobClick endLogPageView:[self title]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _cursor = 0;
    _userName = @"";
    _friends = [[NSMutableArray alloc]init];
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pressBackButton)];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(pressDoneButton)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColorFromRGB(BABYCOLOR_background);
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[CellUserPublish class] forCellReuseIdentifier:NSStringFromClass([CellUserPublish class])];
    [self loadData];
    
}

- (void)initUserInfo
{
    [super initUserInfo];
    [self loadNewDataRefresh];
}

- (void)pressBackButton
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)pressDoneButton
{
    if (self.userSelected) {
        self.userSelected(_friends);
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
//    [self.tableView.mj_header beginRefreshing];
    
    
}

- (void)loadDataMore
{
    _cursor++;
    [self loadNewData];
}

- (void)loadNewDataRefresh
{
    _cursor = 0;
    
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
                _userInfos = nil;
            }
            
            [self processData:data];
        } else {
            
        }
    };
    
    
    BabyDataSource *souce = [BabyDataSource dataSource];
    
    NSString *fields = [NSString stringWithFormat:@"{\"cursor\":\"%d\",\"uid\":\"%ld\",\"userName\":\"%@\"}", _cursor, [self loginUserId], _userName];
    
    [souce getData:USER_FRIENDS parameters:fields completion:completionBlock];
}

- (void)processData:(NSDictionary *)data
{
    if(_userInfos == nil) {
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataMore)];
        [footer setTitle:NOMOREDATA forState:MJRefreshStateNoMoreData];
        self.tableView.mj_footer = footer;
        _userInfos = [UserInfos mj_objectWithKeyValues:data];
    } else {
        UserInfos *userInfos = [UserInfos mj_objectWithKeyValues:data];
        [_userInfos.info addObjectsFromArray:userInfos.info];
        
        if ([userInfos.info count] == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    
    if ([_userInfos.info count] == 0) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableView reloadData];
        if ([_userInfos.info count] < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _userInfos.info.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CellUserPublish *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellUserPublish class])];
    UserInfo *userinfo = _userInfos.info[indexPath.row];
    cell.isSelected = [_friends containsObject:userinfo];
    cell.userInfo = userinfo;
    cell.cellIndex = indexPath.row;
    
    cell.followClicked = ^(NSInteger cellIndex, UserInfo *user) {
        [self reloadDataForSelected:indexPath];
    };
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(BABYCOLOR_background);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self reloadDataForSelected:indexPath];
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadDataForSelected:(NSIndexPath *)indexPath
{
    UserInfo *userinfo = _userInfos.info[indexPath.row];
    if ([_friends containsObject:userinfo]) {
        DLog(@"containsObject");
        [_friends removeObject:userinfo];
    } else {
        [_friends addObject:userinfo];
    }
//    [_tableView reloadData];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
