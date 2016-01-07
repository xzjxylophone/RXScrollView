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
#import "DayViewSource.h"
#import "WeekViewSource.h"
#define k_Test_Offset   80


typedef enum E_RX_ViewStatus {
    kE_RX_ViewStatus_ShowTop,
    kE_RX_ViewStatus_ShowTV,
}E_RX_ViewStatus;

@interface MainViewController ()<DayViewSourceDelegate, WeekViewSourceDelegate>
@property (nonatomic, strong) UILabel *infiniteTopLabel;
@property (nonatomic, strong) RXInfiniteView *dayView;



@property (nonatomic, strong) RXInfiniteView *weekView;

//@property (nonatomic, strong) UIView *topView;

@property (nonatomic, assign) E_RX_ViewStatus e_RX_ViewStatus;

@property (nonatomic, strong) DayViewSource *dayViewSource;
@property (nonatomic, strong) WeekViewSource *weekViewSource;

@property (nonatomic, assign) BOOL showTop; // 当前是否 显示top




@end

@implementation MainViewController

- (void)lblAction:(id)sender
{
    
}

#pragma mark - WeekViewSourceDelegate
- (UIView *)viewFromCur
{
    return self.dayView.curView;
}

#pragma mark - DayViewSourceDelegate
- (void)actionInDayViewSource:(DayViewSource *)dvs
{
    [self addTopViewToRXView];
}



- (void)dayViewSource:(DayViewSource *)dvs scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    switch (self.e_RX_ViewStatus) {
        case kE_RX_ViewStatus_ShowTV:
        {
            
            self.weekView.top = - (self.weekView.height + y);
            
            [self.view bringSubviewToFront:self.weekView];
            [self.view bringSubviewToFront:self.infiniteTopLabel];
        }
            break;
            
        default:
            break;
    }
}

- (void)dayViewSource:(DayViewSource *)dvs scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat y = scrollView.contentOffset.y;
    if (y < 0) {
        CGFloat y1 = fabs(y);
        if (y1 > 80) {
            
            self.e_RX_ViewStatus = kE_RX_ViewStatus_ShowTop;
            self.weekViewSource.isShow = YES;
            self.weekView.top = self.infiniteTopLabel.height;
            self.dayView.top = [UIScreen mainScreen].bounds.size.height - 64;
            [self.weekView reloadData];
            
            [self.view bringSubviewToFront:self.weekView];
            
        }
    }
}


#pragma mark - AddTopViewToInfinite
- (void)addTopViewToRXView
{
    [self.view addSubview:self.weekView];
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
    
    
    self.dayViewSource = [[DayViewSource alloc] init];
    self.dayViewSource.delegate = self;
    
    self.weekViewSource = [[WeekViewSource alloc] init];
    self.weekViewSource.delegate = self;
    self.weekViewSource.isShow = NO;
    
    
    CGFloat inHeight = height - topViewHeight  - 64;
    self.dayView = [[RXInfiniteView alloc] initWithFrame:CGRectMake(0, topViewHeight, width, inHeight)];
    self.dayView.dataSource = self.dayViewSource;
    self.dayView.delegate = self.dayViewSource;
    self.dayView.curData = @(100);
    [self.dayView reloadData];
    [self.view addSubview:self.dayView];
    
    
    
    self.weekView = [[RXInfiniteView alloc] initWithFrame:CGRectMake(0, -inHeight + topViewHeight, width, inHeight)];
    self.weekView.dataSource = self.weekViewSource;
    self.weekView.delegate = self.weekViewSource;
    self.weekView.curData = @(100);
    [self.weekView reloadData];
    
    
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
