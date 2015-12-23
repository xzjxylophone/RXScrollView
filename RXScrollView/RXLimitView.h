//
//  RXLimitView.h
//  RXVerifyExample
//
//  Created by Rush.D.Xzj on 15/12/19.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RXLimitViewDataSource;



@interface RXLimitView : UIView

@property (nonatomic, weak) id<RXLimitViewDataSource> dataSource;

- (void)reloadData;


@end



@protocol RXLimitViewDataSource <NSObject>

- (NSInteger)numberOfPageInRXLimitView:(RXLimitView *)rxLimitView;

- (UIView *)rxLimitView:(RXLimitView *)rxLimitView viewForAtIndex:(NSInteger)index;

@end
