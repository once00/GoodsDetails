//
//  OnceGoodsDetailsView.h
//  西北招商网云管理系统
//
//  Created by 曹绍奇 on 2018/5/21.
//  Copyright © 2018年 曹绍奇. All rights reserved.
//
//整体页面
#import <UIKit/UIKit.h>
#import "OnceGoodsDetailsTopView.h"
#import "XWAddShopCarTitleView.h"
#import "OnceGoodsDetailsBootmView.h"

@interface OnceGoodsDetailsView : UIView<XWAddShopCarTitleViewDelegate>

/*
 * 导航头部视图
 */
@property(strong, nonatomic) XWAddShopCarTitleView * titleView;

/**
 * 上部分view
 */
@property (nonatomic, strong) OnceGoodsDetailsTopView *top_view;

/**
 * 下部分view
 */
@property (nonatomic, strong) UIView *twoPageView;
/**
 * 下部分网页
 */
@property (strong,nonatomic)  UIWebView *webView;
/**
 *  商品详情内容
 */
@property (nonatomic, strong) NSString *htmlURlStr;

/**
 *  底部内容
 */
@property (nonatomic, strong) OnceGoodsDetailsBootmView *bootmview;

@end
