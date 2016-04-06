//
//  RXLimitView.m
//  RXVerifyExample
//
//  Created by Rush.D.Xzj on 15/12/19.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "RXLimitView.h"


@interface RXLimitView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;


@property (nonatomic, copy) void (^preCompletion)(void);
@property (nonatomic, copy) void (^nextCompletion)(void);


@end
@implementation RXLimitView


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGPoint contentOffset = scrollView.contentOffset;
//    NSLog(@"contentOffset:%@", NSStringFromCGPoint(contentOffset));
    
//    NSLog(@"scrollViewDidScroll");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    CGPoint contentOffset = scrollView.contentOffset;
//    NSLog(@"scrollViewDidEndDragging,contentOffset:%@", NSStringFromCGPoint(contentOffset));
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _currentPage = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
//    CGPoint contentOffset = scrollView.contentOffset;
//    NSLog(@"scrollViewDidEndDecelerating,contentOffset:%@", NSStringFromCGPoint(contentOffset));
    if ([self.delegate respondsToSelector:@selector(gestureScrollInRXLimitView:)]) {
        [self.delegate gestureScrollInRXLimitView:self];
    }
    
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
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    NSInteger count = [self.dataSource numberOfPageInRXLimitView:self];

    if (currentPage < 0) {
        currentPage = 0;
    }
    if (currentPage > count - 1) {
        currentPage = count - 1;
    }
    _currentPage = currentPage;
    
    
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width * currentPage, 0);
    
}

- (BOOL)isFirstPage
{
    return self.currentPage == 0;
}
- (BOOL)isLastPage
{
    NSInteger count = [self.dataSource numberOfPageInRXLimitView:self];
    return (self.currentPage == count - 1);
}

#pragma mark - Public
- (void)reloadData
{
    NSArray *views = self.scrollView.subviews;
    for (UIView *view in views) {
        [view removeFromSuperview];
    }
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    NSInteger count = [self.dataSource numberOfPageInRXLimitView:self];
    self.scrollView.contentSize = CGSizeMake(width * count, height);
    for (NSInteger i = 0; i < count; i++) {
        UIView *view = [self.dataSource rxLimitView:self viewForAtIndex:i];
        CGRect frame = view.frame;
        frame.origin.x = i * width;
        // 不能设置Y值
//        frame.origin.y = 0;
        view.frame = frame;
        [self.scrollView addSubview:view];
    }
    
}

- (void)prePageWithDuration:(NSTimeInterval)duration completion:(void(^)(void))completion
{
    CGFloat x = self.scrollView.contentOffset.x;
    CGFloat destX = x - self.frame.size.width;
    if (destX < 0) {
        return;
    }
    self.preCompletion = completion;
    
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationPreDidShowStop:finished:)];
    self.scrollView.contentOffset = CGPointMake(destX, 0);
    [UIView commitAnimations];
    
}
- (void)nextPageWithDuration:(NSTimeInterval)duration completion:(void(^)(void))completion
{
    CGFloat x = self.scrollView.contentOffset.x;
    CGFloat destX = x + self.frame.size.width;
    NSInteger count = [self.dataSource numberOfPageInRXLimitView:self];
    if (destX > self.frame.size.width * (count - 1)) {
        return;
    }
    self.nextCompletion = completion;
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationNextDidShowStop:finished:)];
    self.scrollView.contentOffset = CGPointMake(destX, 0);
    [UIView commitAnimations];
}

- (void)animationNextDidShowStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _currentPage = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    if (self.nextCompletion != nil) {
        self.nextCompletion();
        self.nextCompletion = nil;
    }
}
- (void)animationPreDidShowStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _currentPage = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    if (self.preCompletion != nil) {
        self.preCompletion();
        self.preCompletion = nil;
    }
}

#pragma mark - Constructor And Destructor
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _currentPage = 0;
    }
    return self;
}


@end
