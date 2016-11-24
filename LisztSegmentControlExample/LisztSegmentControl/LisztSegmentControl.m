//
//  LisztSegmentControl.m
//  LisztSegmentControlExample
//
//  Created by Liszt on 16/11/24.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import "LisztSegmentControl.h"

#define  ProportionWidth [UIScreen mainScreen].bounds.size.width / 375

@interface LisztSegmentControl()<UIScrollViewDelegate>{
    /*所有Buttons*/
    NSMutableArray *segButtons;
}
/*选项卡*/
@property (strong, nonatomic) UIView *segTabBarView;
/*悬浮View*/
@property (strong, nonatomic) UIView *segSuspensionView;
/*底部ScrollView*/
@property (strong, nonatomic) UIScrollView *segScrollView;
/*标题组*/
@property (strong, nonatomic) NSArray *segTitles;
/*控制器组*/
@property (strong, nonatomic) NSArray *segControlls;
/*选择回调Block*/
@property (copy, nonatomic) LisztSegmentDidSelectBlcok didSelectBlock;
@end

@implementation LisztSegmentControl

- (instancetype)initWithFrame:(CGRect)frame withControllers:(NSArray<UIViewController *> *)controllers withTitles:(NSArray<NSString *> *)titles didSelect:(LisztSegmentDidSelectBlcok)selectBlock{
    self = [super initWithFrame:frame];
    if(self){
        /*1.设置默认参数*/
        self.segTitles = titles;
        self.segControlls = controllers;
        self.didSelectBlock = selectBlock;
        segButtons = [NSMutableArray arrayWithCapacity:0];
        /*2.初始化UI*/
        [self InitializationDefaultUI];
    }
    return self;
}
- (void)InitializationDefaultUI{
    /*1.添加视图*/
    [self addSubview:self.segTabBarView];
    [self addSubview:self.segScrollView];
}

#pragma mark - Button Action
- (void)buttonAction:(UIButton *)button{
    CGRect segSuspensionFrame = self.segSuspensionView.frame;
    segSuspensionFrame.origin.x = button.tag * self.bounds.size.width / self.segTitles.count;
    [UIView animateWithDuration:0.1 animations:^{
        self.segSuspensionView.frame = segSuspensionFrame;
    }];
    
    if(self.didSelectBlock){
        self.didSelectBlock(button.tag);
    }
    
    [self.segScrollView setContentOffset:CGPointMake(button.tag * CGRectGetWidth(self.segScrollView.frame), 0) animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(self.segScrollView.frame);
    CGRect segSuspensionFrame = self.segSuspensionView.frame;
    segSuspensionFrame.origin.x = page * self.bounds.size.width / self.segTitles.count;
    [UIView animateWithDuration:0.1 animations:^{
        self.segSuspensionView.frame = segSuspensionFrame;
    }];
    
    if(self.didSelectBlock){
        self.didSelectBlock(page);
    }
}

#pragma mark - 懒加载
- (UIView *)segTabBarView{
    if(!_segTabBarView){
        _segTabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), ProportionWidth * 45.f)];
//        _segTabBarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        /*1.创建标题按钮*/
        [self.segTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            itemButton.frame = CGRectMake(idx * self.bounds.size.width / self.segTitles.count, 0, self.bounds.size.width / self.segTitles.count, CGRectGetHeight(_segTabBarView.frame) - ProportionWidth * 3);
            [itemButton setTitle:self.segTitles[idx] forState:UIControlStateNormal];
            itemButton.tag = idx;
            itemButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
            [itemButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_segTabBarView addSubview:itemButton];
            
            /*2.创建间隔View*/
            if(idx!=self.segTitles.count - 1){
                UIView *spaceView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(itemButton.bounds)-ProportionWidth * 0.6, 0, ProportionWidth * 0.6, CGRectGetHeight(_segTabBarView.bounds))];
                spaceView.backgroundColor = [UIColor lightGrayColor];
                [itemButton addSubview:spaceView];
            }
            [segButtons addObject:itemButton];
        }];
        
        /*3.创建segSuspensionView*/
        [_segTabBarView addSubview:self.segSuspensionView];
    }
    return _segTabBarView;
}
- (UIView *)segSuspensionView{
    if(!_segSuspensionView){
        _segSuspensionView = [[UIView alloc]initWithFrame:CGRectMake(0, ProportionWidth * 45.f - ProportionWidth * 3, CGRectGetWidth(self.segTabBarView.frame) / self.segTitles.count,ProportionWidth * 3)];
        _segSuspensionView.backgroundColor = [UIColor cyanColor];
    }
    return _segSuspensionView;
}
- (UIScrollView *)segScrollView{
    if(!_segScrollView){
        _segScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.segTabBarView.frame), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetHeight(self.segTabBarView.bounds))];
        _segScrollView.delegate = self;
        _segScrollView.bounces = NO;
        _segScrollView.pagingEnabled = YES;
        _segScrollView.showsVerticalScrollIndicator = NO;
        _segScrollView.showsHorizontalScrollIndicator = NO;

        /*1.添加子控制器视图*/
        [self.segControlls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIViewController *tempController = self.segControlls[idx];
            tempController.view.frame = CGRectMake(idx * CGRectGetWidth(_segScrollView.frame), 0, CGRectGetWidth(_segScrollView.frame), CGRectGetHeight(_segScrollView.frame));
            [_segScrollView addSubview:tempController.view];
        }];
        _segScrollView.contentSize = CGSizeMake(self.segControlls.count * CGRectGetWidth(_segScrollView.frame), CGRectGetHeight(_segScrollView.frame));
    }
    return _segScrollView;
}
@end
