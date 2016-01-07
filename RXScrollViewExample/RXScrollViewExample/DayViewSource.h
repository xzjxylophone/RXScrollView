//
//  DayViewSource.h
//  RXScrollViewExample
//
//  Created by Rush.D.Xzj on 15/12/24.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXInfiniteView.h"

@class DayViewSource;
@protocol DayViewSourceDelegate <NSObject>

- (void)actionInDayViewSource:(DayViewSource *)dvs;

- (void)dayViewSource:(DayViewSource *)dvs scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)dayViewSource:(DayViewSource *)dvs scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
@end

@interface DayViewSource : NSObject <RXInfiniteViewDataSource, RXInfiniteViewDelegate>

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, weak) id<DayViewSourceDelegate> delegate;

@end
