//
//  WeekViewSource.h
//  RXScrollViewExample
//
//  Created by Rush.D.Xzj on 15/12/24.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXInfiniteView.h"

@class WeekViewSource;

@protocol WeekViewSourceDelegate <NSObject>

- (UIView *)viewFromCur;

@end

@interface WeekViewSource : NSObject <RXInfiniteViewDataSource, RXInfiniteViewDelegate>

@property (nonatomic, weak) id<WeekViewSourceDelegate> delegate;

@property (nonatomic, assign) BOOL isShow;

@end
