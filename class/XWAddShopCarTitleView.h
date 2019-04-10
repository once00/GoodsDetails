//
//  OnceGoodsDetailsView.m
//  西北招商网云管理系统
//
//  Created by 曹绍奇 on 2018/5/21.
//  Copyright © 2018年 曹绍奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XWAddShopCarTitleView;


@protocol XWAddShopCarTitleViewDelegate <NSObject>


-(void)XWAddShopCarTitleView:(XWAddShopCarTitleView*)View ClickTitleWithTag:(NSInteger)tag andButton:(UIButton *)sender;

@end



@interface XWAddShopCarTitleView : UIView

@property(weak, nonatomic) id<XWAddShopCarTitleViewDelegate> delegate;
//向上 滚动展示titleSegmentView
-(void)ScrollShowTitleSegmentViewWithDuration:(CGFloat)duration;
//向下 滚动展示titleLable
-(void)ScrollShowTitleLableWithDuration:(CGFloat)duration
;
// 设置选中
-(void)updataSelectTitleWithTag:(NSInteger)tag;
@end
