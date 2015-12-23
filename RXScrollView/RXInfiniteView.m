//
//  RXInfiniteView.m
//  RXVerifyExample
//
//  Created by Rush.D.Xzj on 15/12/19.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "RXInfiniteView.h"

@interface RXInfiniteView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;


@property (nonatomic, strong) UIView *preView;
@property (nonatomic, strong) UIView *curView;
@property (nonatomic, strong) UIView *nextView;


@end

@implementation RXInfiniteView

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2)/pageWidth)+1;
    switch (page) {
        case 1:
        {
            // 当前页
        }
            break;
        case 2:
        {
            // 下一页
            self.curData = [self.dataSource nextDataInRXInfiniteView:self];
            [self nextAction];
        }
            break;
        case 0:
        {
            // 上一页
            self.curData = [self.dataSource preDataInRXInfiniteView:self];
            [self preAction];
            
        }
            break;
        default:
            break;
    }
    
    
}

#pragma mark - Private
- (void)setView:(UIView *)view x:(CGFloat)x
{
    CGRect frame = view.frame;
    frame.origin.x = x;
    view.frame = frame;
}
- (void)updateToRightFrame
{
    
    CGFloat width = self.frame.size.width;
    
    [self setView:self.preView x:0];
    [self setView:self.curView x:width];
    [self setView:self.nextView x:width * 2];
    
    self.scrollView.contentOffset = CGPointMake(width, 0);
}
- (void)preAction
{
    UIView *nextView = self.nextView;
    self.nextView = self.curView;
    self.curView = self.preView;
    self.preView = [self.dataSource preViewInRXInfiniteView:self reuseView:nextView];
    [self updateToRightFrame];
    [self safeDelegate_preActionInRXInfiniteView:self];
}
- (void)nextAction
{
    UIView *preView = self.preView;
    self.preView = self.curView;
    self.curView = self.nextView;
    self.nextView = [self.dataSource nextViewInRXInfiniteView:self reuseView:preView];
    [self updateToRightFrame];
    [self safeDelegate_nextActionInRXInfiniteView:self];
}

#pragma mark - Proverty
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(width * 3, height);
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

#pragma mark - Public
- (void)reloadData
{
    

    [self.preView removeFromSuperview];
    [self.curView removeFromSuperview];
    [self.nextView removeFromSuperview];
    
    self.preView = [self.dataSource preViewInRXInfiniteView:self reuseView:nil];
    self.curView = [self.dataSource curViewInRXInfiniteView:self reuseView:nil];
    self.nextView = [self.dataSource nextViewInRXInfiniteView:self reuseView:nil];
    
    
    [self.scrollView addSubview:self.preView];
    [self.scrollView addSubview:self.curView];
    [self.scrollView addSubview:self.nextView];
    
    
    [self updateToRightFrame];
    
}

#pragma mark - Safe Delegate
- (void)safeDelegate_nextActionInRXInfiniteView:(RXInfiniteView *)infiniteView
{
    if ([self.delegate respondsToSelector:@selector(nextActionInRXInfiniteView:)]) {
        [self.delegate nextActionInRXInfiniteView:infiniteView];
    }
}
- (void)safeDelegate_preActionInRXInfiniteView:(RXInfiniteView *)infiniteView
{
    if ([self.delegate respondsToSelector:@selector(preActionInRXInfiniteView:)]) {
        [self.delegate preActionInRXInfiniteView:infiniteView];
    }
}


#pragma mark - Constructor And Destructor
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}


@end
