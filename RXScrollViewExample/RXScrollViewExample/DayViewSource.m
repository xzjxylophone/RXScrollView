//
//  DayViewSource.m
//  RXScrollViewExample
//
//  Created by Rush.D.Xzj on 15/12/24.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "DayViewSource.h"

@interface DayViewSource ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation DayViewSource

#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    [self.delegate dayViewSource:self scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.delegate dayViewSource:self scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = @"klsjglksgj";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", tableView.tag];
    return cell;
}

#pragma mark - Private
- (UIView *)viewWithInRXInfiniteView:(RXInfiniteView *)infiniteView data:(id)data reuseView:(UIView *)reuseView
{
    UITableView *tableView = nil;
    if (reuseView == nil) {
        
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, infiniteView.frame.size.width, infiniteView.frame.size.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
    } else {
        tableView = (UITableView *)reuseView;
    }
    tableView.tag = [data integerValue] + 1000;
    [tableView reloadData];
    return tableView;
}

#pragma mark - RXInfiniteViewDataSource
- (UIView *)curViewInRXInfiniteView:(RXInfiniteView *)infiniteView reuseView:(UIView *)reuseView
{
    id curData = infiniteView.curData;
    return [self viewWithInRXInfiniteView:infiniteView data:curData reuseView:reuseView];
}
- (UIView *)preViewInRXInfiniteView:(RXInfiniteView *)infiniteView reuseView:(UIView *)reuseView
{
    id preData = [self preDataInRXInfiniteView:infiniteView];
    return [self viewWithInRXInfiniteView:infiniteView data:preData reuseView:reuseView];
}
- (UIView *)nextViewInRXInfiniteView:(RXInfiniteView *)infiniteView reuseView:(UIView *)reuseView
{
    id nextData = [self nextDataInRXInfiniteView:infiniteView];
    return [self viewWithInRXInfiniteView:infiniteView data:nextData reuseView:reuseView];
}

- (id)preDataInRXInfiniteView:(RXInfiniteView *)infiniteView
{
    NSInteger cur = [infiniteView.curData integerValue];
    return @(cur - 1);
}
- (id)nextDataInRXInfiniteView:(RXInfiniteView *)infiniteView
{
    NSInteger cur = [infiniteView.curData integerValue];
    return @(cur + 1);
}
#pragma mark - RXInfiniteViewDelegate
- (void)nextActionInRXInfiniteView:(RXInfiniteView *)infiniteView
{   
    [self.delegate actionInDayViewSource:self];
}
- (void)preActionInRXInfiniteView:(RXInfiniteView *)infiniteView
{
    [self.delegate actionInDayViewSource:self];
}

@end
