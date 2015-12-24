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
#import "RXCategoryHeader.h"
#define k_Test_Offset   80


typedef enum E_RX_ViewStatus {
    kE_RX_ViewStatus_ShowTop,
    kE_RX_ViewStatus_ShowTV,
}E_RX_ViewStatus;

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, RXInfiniteViewDataSource, RXInfiniteViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UILabel *infiniteTopLabel;
@property (nonatomic, strong) RXInfiniteView *rxInfiniteView;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, assign) E_RX_ViewStatus e_RX_ViewStatus;

@property (nonatomic, assign) BOOL showTop; // 当前是否 显示top




@end

@implementation MainViewController

- (void)lblAction:(id)sender
{
    
}
#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    switch (self.e_RX_ViewStatus) {
        case kE_RX_ViewStatus_ShowTV:
        {
            
            self.topView.top = - (self.topView.height + y);
            
            [self.view bringSubviewToFront:self.topView];
            [self.view bringSubviewToFront:self.infiniteTopLabel];
        }
            break;
            
        default:
            break;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat y = scrollView.contentOffset.y;
    if (y < 0) {
        CGFloat y1 = fabs(y);
        if (y1 > 80) {
            
            self.e_RX_ViewStatus = kE_RX_ViewStatus_ShowTop;
            self.topView.top = self.infiniteTopLabel.height;
            self.rxInfiniteView.top = [UIScreen mainScreen].bounds.size.height - 64;
            
            [self.view bringSubviewToFront:self.topView];
            
        }
    }
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
    [self addTopViewToRXView];
}
- (void)preActionInRXInfiniteView:(RXInfiniteView *)infiniteView
{
    [self addTopViewToRXView];
}

#pragma mark - AddTopViewToInfinite
- (void)addTopViewToRXView
{
    [self.view addSubview:self.topView];
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
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.showTop = NO;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat topViewHeight = 30;

    self.e_RX_ViewStatus = kE_RX_ViewStatus_ShowTV;
    
    self.infiniteTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, topViewHeight)];
    self.infiniteTopLabel.text = @"无限的";
    self.infiniteTopLabel.backgroundColor = [UIColor greenColor];
    [self.infiniteTopLabel rx_addGestureRecognizerWithTarget:self action:@selector(lblAction:)];
    
    
    
    CGFloat inHeight = height - topViewHeight  - 64;
    self.rxInfiniteView = [[RXInfiniteView alloc] initWithFrame:CGRectMake(0, topViewHeight, width, inHeight)];
    self.rxInfiniteView.dataSource = self;
    self.rxInfiniteView.delegate = self;
    self.rxInfiniteView.curData = @(100);
    [self.rxInfiniteView reloadData];
    [self.view addSubview:self.rxInfiniteView];
    
    
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, -inHeight + topViewHeight, width, inHeight)];
    self.topView.backgroundColor = [UIColor redColor];
    
    
    
//    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, inY, width, inHeight) style:UITableViewStyleGrouped];
//    
//    tv.dataSource = self;
//    tv.delegate = self;
//    [self.view addSubview:tv];
    
    
    
    
    
    [self addTopViewToRXView];

    
    [self.view addSubview:self.infiniteTopLabel];
    
    
    
    
    
    
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
