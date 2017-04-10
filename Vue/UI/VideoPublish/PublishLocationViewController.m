//
//  PublishLocationViewController.m
//  Babypai
//
//  Created by ning on 16/5/17.
//  Copyright © 2016年 Babypai. All rights reserved.
//

#import "PublishLocationViewController.h"
#import "CellLocationPublish.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

@interface PublishLocationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *mPois;
@property (nonatomic, assign) int cursor;
@property (nonatomic, strong)UITableView *tableView;


@end

@implementation PublishLocationViewController

- (NSString *)title
{
    return @"修改位置";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _cursor = 1;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColorFromRGB(BABYCOLOR_background);
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[CellLocationPublish class] forCellReuseIdentifier:NSStringFromClass([CellLocationPublish class])];
    
}

- (void)initUserInfo
{
    [super initUserInfo];
    [self loadData];
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
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
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

- (void)loadNewData
{
    DLogE(@"loadNewData");
    __weak PublishLocationViewController *wSelf = self;
}

- (void)searchPOI:(CLLocation *)location
{
    DLogE(@"searchPOI, %f, %f", location.coordinate.latitude, location.coordinate.longitude);
    //配置用户Key
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _mPois.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LocationCellH;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CellLocationPublish *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellLocationPublish class])];
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(BABYCOLOR_background);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
