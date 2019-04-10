//
//  OnceGoodsDetailsTopView.m
//  西北招商网云管理系统
//
//  Created by 曹绍奇 on 2018/5/22.
//  Copyright © 2018年 曹绍奇. All rights reserved.
//

#import "OnceGoodsDetailsTopView.h"

@interface OnceGoodsDetailsTopView ()

@end

@implementation OnceGoodsDetailsTopView

- (instancetype)init{
    self=[super init];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.contentSize = CGSizeMake(HG_WIDTH, HG_HEIGHT * 5);
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
}

@end
