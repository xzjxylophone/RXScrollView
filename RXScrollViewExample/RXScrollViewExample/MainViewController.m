//
//  MainViewController.m
//  RXScrollViewExample
//
//  Created by Rush.D.Xzj on 15/12/23.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "MainViewController.h"

#import "RXLimitView.h"
#import "RXInfiniteView.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, RXLimitViewDataSource, RXInfiniteViewDataSource>
@property (nonatomic, strong) UILabel *limitTopLabel;
@property (nonatomic, strong) RXLimitView *rxLimitView;

@property (nonatomic, strong) UILabel *infiniteTopLabel;
@property (nonatomic, strong) RXInfiniteView *rxInfiniteView;

@end

@implementation MainViewController


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
#pragma mark - RXLimitViewDataSource
- (NSInteger)numberOfPageInRXLimitView:(RXLimitView *)rxLimitView
{
    return 5;
}

- (UIView *)rxLimitView:(RXLimitView *)rxLimitView viewForAtIndex:(NSInteger)index
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, rxLimitView.frame.size.width, rxLimitView.frame.size.height)];
    tableView.tag = index + 1000;
    tableView.delegate = self;
    tableView.dataSource = self;
    return tableView;
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


#pragma mark - initialize UI And Data
- (void)initializeUIAndData
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat topViewHeight = 30;
    CGFloat svHeight = 200;
    
    self.limitTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, topViewHeight)];
    self.limitTopLabel.backgroundColor = [UIColor redColor];
    self.limitTopLabel.text = @"有限的";
    
    
    self.rxLimitView = [[RXLimitView alloc] initWithFrame:CGRectMake(0, topViewHeight, width, svHeight)];
    self.rxLimitView.dataSource = self;
    [self.rxLimitView reloadData];
    
    [self.view addSubview:self.limitTopLabel];
    [self.view addSubview:self.rxLimitView];
    
    
    CGFloat inTopViewY = topViewHeight + svHeight;
    self.infiniteTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, inTopViewY, width, topViewHeight)];
    self.infiniteTopLabel.text = @"无限的";
    self.infiniteTopLabel.backgroundColor = [UIColor greenColor];
    
    CGFloat inHeight = height - topViewHeight * 2 - svHeight - 64;
    CGFloat inY = inTopViewY + topViewHeight;
    self.rxInfiniteView = [[RXInfiniteView alloc] initWithFrame:CGRectMake(0, inY, width, inHeight)];
    self.rxInfiniteView.dataSource = self;
    self.rxInfiniteView.curData = @(100);
    [self.rxInfiniteView reloadData];
    
    [self.view addSubview:self.infiniteTopLabel];
    [self.view addSubview:self.rxInfiniteView];
    
    
    
    
}
- (void)initializeAction
{
    
}


#pragma mark - View Life Cycle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initializeUIAndData];
    [self initializeAction];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
