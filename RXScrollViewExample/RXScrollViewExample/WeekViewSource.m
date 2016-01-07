//
//  WeekViewSource.m
//  RXScrollViewExample
//
//  Created by Rush.D.Xzj on 15/12/24.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "WeekViewSource.h"
@interface WeekViewSource() <UITableViewDataSource, UITableViewDelegate>

@end


@implementation WeekViewSource


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isShow) {
        return 2;
    } else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            NSString *identify = @"klsjglksgj";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.text = [NSString stringWithFormat:@"%zd", tableView.tag];
            return cell;
        }
        case 1:
        default:
        {
            
            NSString *identify = @"klsjglksgj2";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            UIView *view = [self.delegate viewFromCur];
            [cell.contentView addSubview:view];
            return cell;
        }
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.frame.size.height;
}






#pragma mark - Private
- (UIView *)viewWithInRXInfiniteView:(RXInfiniteView *)infiniteView data:(id)data reuseView:(UIView *)reuseView
{

    UITableView *tableView = nil;
    if (reuseView == nil) {
        
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, infiniteView.frame.size.width, infiniteView.frame.size.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.bounces = NO;
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

@end
