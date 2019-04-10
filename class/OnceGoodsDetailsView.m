//
//  OnceGoodsDetailsView.m
//  西北招商网云管理系统
//
//  Created by 曹绍奇 on 2018/5/21.
//  Copyright © 2018年 曹绍奇. All rights reserved.
//

#import "OnceGoodsDetailsView.h"
#import "DetailsEnterpriseServiceProductsTop.h"
#import "DetailsEnterpriseServiceProductsBootm.h"

@interface OnceGoodsDetailsView ()<UIScrollViewDelegate>

/** 商品详情整体 */
@property(strong,nonatomic)UIScrollView *scrollView;

@property (nonatomic, strong) MJRefreshGifHeader *header;

@end

@implementation OnceGoodsDetailsView

- (instancetype)init{
    self=[super init];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    [self takeVC].edgesForExtendedLayout = UIRectEdgeNone;
    
    // 添加子控件
    [self addSubview:self.scrollView];
    
    [self.scrollView  addSubview:self.top_view];
    [self.scrollView  addSubview:self.twoPageView];
    [self.twoPageView addSubview:self.webView];
    [self addSubview:self.bootmview];
    
    // 配置上拉和下拉操作
    [self configureRefresh];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat navhh=[self takeVC].navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    self.frame=[ UIScreen mainScreen ].bounds;
    
    self.titleView.frame=CGRectMake(0, 0, CONTROL_W(150), CONTROL_W(44));
    
    self.scrollView.frame=CGRectMake(0, 0, HG_WIDTH, HG_HEIGHT-navhh-CONTROL_W(50));
    self.scrollView.contentSize = CGSizeMake(HG_WIDTH*2, 0);
    
    self.top_view.frame=self.bounds;
//    self.top_view.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height * 5);
    
    self.twoPageView.frame=CGRectMake(0, CGRectGetMaxY(self.top_view.frame), self.top_view.width, self.top_view.height);
    
    self.webView.frame = CGRectMake(0, 0, self.top_view.width, self.top_view.height);
    
    self.bootmview.frame=CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), HG_WIDTH, CONTROL_W(50));
}

- (void)didAddSubview:(UIView *)subview{
    NSLog(@"1111111111111111111");
}
- (void)willRemoveSubview:(UIView *)subview{
    NSLog(@"22222222222222222");
}
- (void)willMoveToSuperview:(nullable UIView *)newSuperview{
    NSLog(@"3333333333333333333");
}
- (void)didMoveToSuperview{
    NSLog(@"44444444444444");
    self.titleView.frame=CGRectMake(0, 0, CONTROL_W(150), CONTROL_W(44));
    [self takeVC].navigationItem.titleView = _titleView;
    
}
- (void)willMoveToWindow:(nullable UIWindow *)newWindow{
    NSLog(@"55555555555555555");
}
- (void)didMoveToWindow{
    NSLog(@"6666666666666666");
}
- (void)removeFromSuperview{
    NSLog(@"7777777777777777");
}
- (void)dealloc{
    NSLog(@"888888888888888");
}

- (void)setHtmlURlStr:(NSString *)htmlURlStr{
//    NSString *headStr = @"<head><style>img{width:100% !important}</style></head>";
//    NSString *URlStr = [NSString stringWithFormat:@"%@<body style='background-color:#ffffff'>%@<br><div style=\"margin: 15px 15px;\"></div></body>", headStr, htmlURlStr];
//    [self.webView loadHTMLString:URlStr baseURL:nil];
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
#pragma mark - Lazy Methods
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate=self;
        _scrollView.bounces = NO;
        _scrollView.alwaysBounceVertical =YES ;
        _scrollView.alwaysBounceHorizontal =NO ;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
        } else {
            [self takeVC].automaticallyAdjustsScrollViewInsets = false;
        }
    }
    return _scrollView;
}
- (XWAddShopCarTitleView *)titleView {
    if(!_titleView) {
        _titleView = [[XWAddShopCarTitleView alloc] init];
        _titleView.delegate =self;
    }
    return _titleView;
}
- (OnceGoodsDetailsTopView *)top_view {
    if(!_top_view) {
        _top_view = [[OnceGoodsDetailsTopView alloc] init];
    }
    return _top_view;
}
#pragma mark - 第二页
- (UIView *)twoPageView {
    if (!_twoPageView) {
        _twoPageView = [[UIView alloc] init];
    }
    return _twoPageView;
}
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scrollView.delegate=self;
    }
    return _webView;
}
- (OnceGoodsDetailsBootmView *)bootmview {
    if(!_bootmview) {
        _bootmview = [[OnceGoodsDetailsBootmView alloc] init];
    }
    return _bootmview;
}

#pragma mark- ==================导航标题切换代理==============================
-(void)XWAddShopCarTitleView:(XWAddShopCarTitleView *)View ClickTitleWithTag:(NSInteger)tag andButton:(UIButton *)sender{
    // scroll水平方向偏移
    self.scrollView.contentOffset = CGPointMake(tag*self.bounds.size.width, 0);
    switch (tag) {
        case 0:
        {
            // 商品
            // 更改图文详情的位置
            [self modifyPhotoViewFrameOne:YES];
            
        }
            break;
        case 1:
        {
            //详情
            [self modifyPhotoViewFrameOne:NO];
            // 设置偏移
        }
            break;
            
            
        default:
            break;
    }
}
#pragma mark =====================================底部滚动的处理================================
- (void)configureRefresh {
    // 动画时间
    CGFloat duration = 0.3f;
    // 1.设置 UITableView 上拉显示商品详情
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, self.height);
            [_titleView ScrollShowTitleLableWithDuration:0.3];
        } completion:^(BOOL finished) {
            [self.top_view.mj_footer endRefreshing];
            //禁止横向滚动
            self.scrollView.scrollEnabled = NO;
        }];
    }];
    footer.automaticallyHidden = NO; // 关闭自动隐藏(若为YES，cell无数据时，不会执行上拉操作)
    footer.stateLabel.backgroundColor = self.top_view.backgroundColor;
    [footer setTitle:@"继续拖动，查看图文详情" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStatePulling];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStateRefreshing];
    self.top_view.mj_footer = footer;
    
    // 2.设置 UIWebView 下拉显示商品详情
    self.header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //设置动画效果
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
            [_titleView ScrollShowTitleSegmentViewWithDuration:0.3];
        } completion:^(BOOL finished) {
            //结束加载
            [self.webView.scrollView.mj_header endRefreshing];
            self.scrollView.scrollEnabled = YES;
        }];
    }];
    self.header.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字、颜色、字体
    [self.header setTitle:@"下拉，返回商品简介" forState:MJRefreshStateIdle];
    [self.header setTitle:@"释放，返回商品简介" forState:MJRefreshStatePulling];
    [self.header setTitle:@"释放，返回商品简介" forState:MJRefreshStateRefreshing];
    self.header.stateLabel.textColor = RGB16(0x666666);
    self.header.stateLabel.font = [UIFont systemFontOfSize:12.f];
    self.webView.scrollView.mj_header = self.header;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 设置偏移
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 繁殖冲突
    //    if ([self.tableview isEqual:scrollView]) {
    //
    //        // 调整 bannder的偏移量
    //        NSLog(@"---contentOffset Y:%lf",scrollView.contentOffset.y);
    //        if (scrollView.contentOffset.y>0) {
    //
    ////            self.bannderView.y =64+ (scrollView.contentOffset.y)*0.2;
    //            //  self.bannderEventView.y = 0 - (scrollView.contentOffset.y+SCREEN_WIDTH);
    //        }
    //        if (scrollView.contentOffset.y<=0) {
    ////            self.bannderView.y = 64;
    //            //  self.bannderEventView.y= 0;
    //        }
    //    }
}
// 减速完成调用（scrollView的contentOffSet是确定的
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if ([self isEqual:scrollView]) {
        NSLog(@"---contentOffset Y:%lf",scrollView.contentOffset.y);
        // 索引
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        // 修改导航选中标题
        [self.titleView  updataSelectTitleWithTag:index];
        switch (index) {
            case 0:
            {
                // 更改图文详情的位置
                [self modifyPhotoViewFrameOne:YES];
            }
                break;
            case 1:
            {
                //详情
                [self modifyPhotoViewFrameOne:NO];
            }
                break;
                
            default:
                break;
        }
    }
}
#pragma mark- 调增图文详情的位置
-(void)modifyPhotoViewFrameOne:(BOOL)inone{
    // 修改图文详情的位置
    //图文详情第一页第二页都存在 所以用的是同一个View ，然后进行位置切换
    if (inone==YES) {
        // 修改图文的Frame 位置为第一page的下半页
        self.twoPageView.frame=CGRectMake(0, CGRectGetMaxY(self.top_view.frame), self.top_view.width, self.top_view.height);
        self.webView.scrollView.mj_header = self.header;
        // 禁止水平滚动
        self.scrollView.scrollEnabled = YES;
    }else{
        // 修改图文的Frame 位置为第二page的上半页
        self.twoPageView.frame=CGRectMake(HG_WIDTH, 0, self.top_view.width, self.top_view.height);
        self.webView.scrollView.mj_header=nil;
        // 禁止水平滚动
        self.scrollView.scrollEnabled = YES;
    }
}



#pragma mark==============获取父视图的控制器=============================
- (UIViewController *)takeVC
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


- (UIViewController *)currentViewController {
    
    UIViewController * currVC = nil;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController * Rootvc = window.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        } else {
            currVC = Rootvc;
            Rootvc = nil;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}







@end
