//
//  RXLimitView.h
//  RXVerifyExample
//
//  Created by Rush.D.Xzj on 15/12/19.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RXLimitViewDataSource;
@protocol RXLimitViewDelegate;


@interface RXLimitView : UIView
@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, weak) id<RXLimitViewDataSource> dataSource;
@property (nonatomic, weak) id<RXLimitViewDelegate> delegate;





// 0 到 count - 1
// 当设置小于0的时候默认是0, 当大于count-1的时候是count-1
@property (nonatomic, assign) NSInteger currentPage;


// 是否是第一页
@property (nonatomic, readonly) BOOL isFirstPage;
// 是否是最后一页
@property (nonatomic, readonly) BOOL isLastPage;


- (void)reloadData;


- (void)prePageWithDuration:(NSTimeInterval)duration completion:(void(^)(void))completion;
- (void)nextPageWithDuration:(NSTimeInterval)duration completion:(void(^)(void))completion;



@end



@protocol RXLimitViewDataSource <NSObject>

- (NSInteger)numberOfPageInRXLimitView:(RXLimitView *)rxLimitView;

- (UIView *)rxLimitView:(RXLimitView *)rxLimitView viewForAtIndex:(NSInteger)index;

@end

@protocol RXLimitViewDelegate <NSObject>

- (void)gestureScrollInRXLimitView:(RXLimitView *)rxLimitView;


@end








