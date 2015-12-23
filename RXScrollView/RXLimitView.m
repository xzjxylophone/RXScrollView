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


@end
@implementation RXLimitView


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffset = scrollView.contentOffset;
    NSLog(@"contentOffset:%@", NSStringFromCGPoint(contentOffset));
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
        [self addSubview:_scrollView];
    }
    return _scrollView;
}


- (void)reloadData
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    NSInteger count = [self.dataSource numberOfPageInRXLimitView:self];
    self.scrollView.contentSize = CGSizeMake(width * count, height);
    for (NSInteger i = 0; i < count; i++) {
        UIView *view = [self.dataSource rxLimitView:self viewForAtIndex:i];
        CGRect frame = view.frame;
        frame.origin.x = i * width;
        frame.origin.y = 0;
        view.frame = frame;
        [self.scrollView addSubview:view];
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
