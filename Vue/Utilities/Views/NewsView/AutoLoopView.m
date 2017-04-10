//
//  AutoLoopView.m
//  AutoLoopScrollView

#import "AutoLoopView.h"
#import "NewsViewItem.h"

@interface AutoLoopView ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *pictureScrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *myPicViewArr;
@property (nonatomic,strong) NSMutableArray *myTagArr;
@property (nonatomic,strong) NSMutableArray *myTitleArr;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) BOOL lock;
@end

#define PageCtlWidth  40
#define PageCtlHeight 20
#define PWidth  self.bounds.size.width
#define PHeight  self.bounds.size.height

@implementation AutoLoopView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self pictureScrollView];
        [self pageControl];
        self.lock = NO;
    }
    return self;
}

-(NSTimer *)timer{
    if (_timer==nil) {
        _timer = [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [_timer setFireDate:[NSDate distantFuture]];
    }
    return _timer;
}


-(UIScrollView *)pictureScrollView{
    if (_pictureScrollView==nil) {
        _pictureScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _pictureScrollView.pagingEnabled = YES;
        _pictureScrollView.showsHorizontalScrollIndicator = NO;
        _pictureScrollView.showsVerticalScrollIndicator = NO;
        _pictureScrollView.bounces = NO;
        _pictureScrollView.delegate =self;
        [self addSubview:_pictureScrollView];
    }
    return _pictureScrollView;
}

-(UIPageControl *)pageControl{
    if (_pageControl==nil) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - PageCtlHeight, self.bounds.size.width, PageCtlHeight)];
        _pageControl.numberOfPages = self.myTitleArr.count;
        _pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.hidden = YES;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

-(NSMutableArray *)myPicViewArr{
    if (_myPicViewArr==nil) {
        _myPicViewArr = [NSMutableArray array];
    }
    return _myPicViewArr;
}

-(NSMutableArray *)myTagArr{
    if (_myTagArr==nil) {
        _myTagArr = [NSMutableArray array];
    }
    return _myTagArr;
}

-(NSMutableArray *)myTitleArr{
    if (_myTitleArr==nil) {
        _myTitleArr = [NSMutableArray array];
    }
    return _myTitleArr;
}

- (void)setScrollerByTag:(NSArray *)tags andTitle:(NSArray *)titles
{
    [self.myTagArr removeAllObjects];
    [self.myTagArr addObjectsFromArray:tags];
    
    [self.myTitleArr removeAllObjects];
    [self.myTitleArr addObjectsFromArray:titles];
    
    NSInteger count = self.myPicViewArr.count;
    NSInteger picCount  = titles.count;
    if (picCount > count-2) {
        for (int i = 0; i<titles.count-(count-2); i++) {
            NewsViewItem *item = [[NewsViewItem alloc]initWithFrame:CGRectMake(0, 0, PWidth, PHeight)];
            item.userInteractionEnabled = YES;
            [self.myPicViewArr addObject:item];
            [self.pictureScrollView addSubview:item];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPicAction:)];
            [item addGestureRecognizer:tap];
        }
    }
    for (int i =0; i<titles.count+2; i++) {
        NewsViewItem *item = self.myPicViewArr[i];
        
        NSString *tag;
        NSString *title;
        if (i==0) {
            tag =  [tags lastObject];
            title =  [titles lastObject];
            item.tag = titles.count - 1;
            
        }else if (i==titles.count+1){
            tag =  [tags firstObject];
            title =  [titles firstObject];
            item.tag = 0;
        }else{
            
            tag =  tags[i-1];
            title =  titles[i-1];
            item.tag = i-1;
        }
        item.frame = CGRectMake(0, i*PHeight, PWidth, PHeight);
        [item setNeedsLayout];
        [item setViewWithTitle:title description:tag];
    }
    self.pictureScrollView.contentSize = CGSizeMake(0, (titles.count+2)*PHeight);
    self.pictureScrollView.contentOffset = CGPointMake(0, PHeight);
    self.pageControl.numberOfPages = self.myTitleArr.count;
    
    [self starTimer];
}


#pragma mark - scrollView
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //偏离位置
    if (scrollView.contentOffset.y == 0)
    {
        self.pictureScrollView.contentOffset = CGPointMake(0, PHeight * self.myTitleArr.count);
    }
    else if(scrollView.contentOffset.y == PHeight * (self.myTitleArr.count + 1) )
    {
        self.pictureScrollView.contentOffset = CGPointMake(0, PHeight);
    }
    
    //小圆点
    int currentPage = scrollView.contentOffset.y / self.bounds.size.height;
    if (currentPage == 0)
    {
        self.pageControl.currentPage = self.myTitleArr.count - 1;
    }
    else if(currentPage == self.myTitleArr.count + 1)
    {
        self.pageControl.currentPage = 0;
    }
    else
    {
        self.pageControl.currentPage = currentPage - 1;
    }
}

/**用户将要开始拖拽的时候调用*/
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //停止定时器
    [self.timer setFireDate: [NSDate distantFuture]];
}

/**用户将要停止拖拽的时候调用*/
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //开始定时器
    if (!self.lock) {
        [self performSelector:@selector(starTimer) withObject:nil afterDelay:2.0f];
        self.lock = YES;
    }
}

- (void)starTimer{
    self.lock = NO;
    [self.timer setFireDate:[NSDate distantPast]];
}

#pragma mark - 定时器滚动轮播图
-(void)nextPage
{
    NSInteger index;
    if (self.pageControl.currentPage == self.pageControl.numberOfPages-1)
    {
        self.pageControl.currentPage = 0;
        index = 1;
    }else{
        self.pageControl.currentPage = self.pageControl.currentPage + 1;
        index = self.pageControl.currentPage+1;
    }
    [self.pictureScrollView setContentOffset:CGPointMake(0, PHeight * index) animated:YES];
}


- (void)tapPicAction:(UITapGestureRecognizer *)sender{
    
    if ([self.delegate respondsToSelector:@selector(tapLoopViewTag:)]) {
        [self.delegate tapLoopViewTag:sender.view.tag];
    }
}

-(void)dealloc{
    [self.timer invalidate];
}

@end
