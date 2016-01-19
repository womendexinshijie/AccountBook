//
//  ViewController.m
//  AccountBook
//
//  Created by junhaoshen on 16/1/5.
//  Copyright © 2016年 junhaoshen. All rights reserved.
//

#import "ViewController.h"

#import "TodayBill.h"
#import "TakeNotes.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController
{
    UIView * todayView;
    
    UILabel * consumeLabel;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createUI];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    todayView.backgroundColor = [UIColor whiteColor];
    
    UIApplication * app = [UIApplication sharedApplication];
    
    AppDelegate * appDelegate = app.delegate;
    
    consumeLabel.text = appDelegate.expend;
    
    if([appDelegate.expend intValue] == 0){
        
        consumeLabel.text = @"0.00";
    }
}

-(void)createUI{
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height*3/7 )];
    
    [self.view addSubview:topView];
    
    UIImageView * topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1242397_095459034_2.jpg"]];
    
    topImageView.center = CGPointMake(topView.frame.size.width/2, topView.frame.size.height/2);
    
    topImageView.bounds = CGRectMake(0, 0, topView.frame.size.width, topView.frame.size.height);
    
    [topView addSubview:topImageView];
    
//******************************************
    NSArray * monthArray = @[@"本月收入",@"本月支出",@"本月差额"];
    
    for(int i = 0;i < 3; i ++){
        
        UILabel * monthIncome = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/3 * i, CGRectGetMaxY(topView.bounds) - topView.bounds.size.height/4.5, self.view.bounds.size.width/3, topView.bounds.size.height/10)];
        
        monthIncome.tag = 100 + i;
        
        monthIncome.textAlignment = NSTextAlignmentCenter;
        
        monthIncome.text = @"0.00";
        
        monthIncome.textColor = [UIColor whiteColor];
        
        [topView addSubview:monthIncome];
        
        UILabel * monthIncome1 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/3 * i, CGRectGetMaxY(topView.bounds) - topView.bounds.size.height/4.5 + topView.bounds.size.height/10 - 10, self.view.bounds.size.width/3, topView.bounds.size.height/9)];
        
        monthIncome1.textAlignment = NSTextAlignmentCenter;
        
        monthIncome1.font = [UIFont systemFontOfSize:15];
        
        monthIncome1.text = monthArray[i];
        
        monthIncome1.textColor = [UIColor whiteColor];
        
        [topView addSubview:monthIncome1];
        
        if(i > 0){
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/3 * i, topView.bounds.size.height - topView.bounds.size.height/4.5 + 5, 1, monthIncome.bounds.size.height + monthIncome1.bounds.size.height - 20)];
        
        lineView.backgroundColor = [UIColor whiteColor];
        
        [topView addSubview:lineView];
            
        }
        
    }
//******************************************
    UIButton * accountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    accountButton.frame =CGRectMake(20,CGRectGetMaxY(topView.bounds), self.view.bounds.size.width - 40, self.view.bounds.size.height/12);
    
    accountButton.backgroundColor = [UIColor colorWithRed:254/255.0 green:185/255.0 blue:17/255.0 alpha:1];
    
    [accountButton setTitle:@"记一笔" forState:UIControlStateNormal];
    
    [accountButton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    
    [accountButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    
    [accountButton.layer setCornerRadius:10];
    
    [accountButton addTarget:self action:@selector(onClickButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:accountButton];
    
//******************************************
    todayView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.bounds) + accountButton.bounds.size.height, self.view.bounds.size.width, accountButton.bounds.size.height)];
    
//    todayView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:todayView];
    
    UITapGestureRecognizer * todayTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(todayTapOnclick)];
    
    [todayView addGestureRecognizer:todayTap];
    
    UILabel * todayLabel = [[UILabel alloc]init];
    
    todayLabel.center = CGPointMake(todayView.bounds.size.width/4, todayView.bounds.size.height/2);
    
    todayLabel.bounds = CGRectMake(0, 0, todayView.bounds.size.width/4, todayView.bounds.size.height/2);
    
    todayLabel.text = @"今日支出";
    
    todayLabel.textColor = [UIColor blackColor];
    
    [todayView addSubview:todayLabel];
    
    consumeLabel = [[UILabel alloc]init];
    
    consumeLabel.center = CGPointMake(todayView.bounds.size.width/15 * 12, todayView.bounds.size.height/2);
    
    consumeLabel.bounds = CGRectMake(0, 0, todayView.bounds.size.width/3, todayView.bounds.size.height/2);
    
//    consumeLabel.text = @"未消费";
    
    consumeLabel.textAlignment = NSTextAlignmentCenter;
    
    consumeLabel.textColor = [UIColor grayColor];
    
    [todayView addSubview:consumeLabel];

//********************************************
    UIView * calendarView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.bounds) + accountButton.bounds.size.height * 2 , self.view.bounds.size.width, accountButton.bounds.size.height)];
    
//    calendarView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:calendarView];
    
    UITapGestureRecognizer * calendarTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(calendarTapOnclick)];
    
    [calendarView addGestureRecognizer:calendarTap];
    
    UILabel * calendarLabel = [[UILabel alloc]init];
    
    calendarLabel.center = CGPointMake(calendarView.bounds.size.width/4, calendarView.bounds.size.height/2);
    
    calendarLabel.bounds = CGRectMake(0, 0, calendarView.bounds.size.width/4, calendarView.bounds.size.height/2);
    
    calendarLabel.text = @"记账日历";
    
    calendarLabel.textColor = [UIColor blackColor];
    
    [calendarView addSubview:calendarLabel];
    
    UILabel * remindLabel = [[UILabel alloc]init];
    
    remindLabel.center = CGPointMake(calendarView.bounds.size.width/10 * 9, calendarView.bounds.size.height/2);
    
    remindLabel.bounds = CGRectMake(0, 0, calendarView.bounds.size.width/4, calendarView.bounds.size.height/2);
    
    remindLabel.text = @"新增提醒";
    
    remindLabel.textColor = [UIColor grayColor];
    
    [calendarView addSubview:remindLabel];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(todayView.frame), self.view.bounds.size.width - 60, 0.5)];
    
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:lineView];
    
    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(calendarView.frame), self.view.bounds.size.width - 60, 1)];
    
    lineView1.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:lineView1];
    
    
    
    
    
}

-(void)onClickButton{
    
    TakeNotes * takeNotes = [[TakeNotes alloc]init];
    
//    [self.navigationController popToViewController:takeNotes animated:NO];
    
    [self presentViewController:takeNotes animated:NO completion:nil];
    
}

-(void)todayTapOnclick{
    
    todayView.backgroundColor = [UIColor lightGrayColor];
    
    TodayBill *todayBill = [[TodayBill alloc]init];
    
    todayBill.str = consumeLabel.text;
    
    [self presentViewController:todayBill animated:NO completion:nil];
    
}

-(void)calendarTapOnclick{
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
