//
//  Main2ViewController.m
//  RXScrollViewExample
//
//  Created by Rush.D.Xzj on 16/1/2.
//  Copyright © 2016年 Rush.D.Xzj. All rights reserved.
//

#import "Main2ViewController.h"
#import "RXInfiniteView.h"
#import "RXCategoryHeader.h"
#import "DayViewSource.h"
#import "WeekViewSource.h"
#import "RXPVHeader.h"


typedef enum E_RX_ViewStatus {
    kE_RX_ViewStatus_ShowWeek,
    kE_RX_ViewStatus_ShowDay,
}E_RX_ViewStatus;



@interface Main2ViewController ()
@property (nonatomic, assign) E_RX_ViewStatus e_RX_ViewStatus;

@property (nonatomic, strong) UIView *tmpDayForWeekView;
@property (nonatomic, strong) RXInfiniteView *weekView;





@property (nonatomic, strong) UIView *tmpWeekForDayView;
@property (nonatomic, strong) RXInfiniteView *dayView;

@end

@implementation Main2ViewController


#pragma mark - initialize UI And Data
- (void)initializeUIAndData
{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    
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
