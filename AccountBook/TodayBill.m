//
//  TodayBill.m
//  AccountBook
//
//  Created by qinglinyou on 16/1/14.
//  Copyright © 2016年 junhaoshen. All rights reserved.
//

#import "TodayBill.h"

@interface TodayBill ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TodayBill

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

-(void)createUI{
    
#pragma 返回按钮
    UIButton * returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    returnButton.frame = CGRectMake(20, 30, 70, 30);
    
    returnButton.backgroundColor = [UIColor lightGrayColor];
    
    returnButton.layer.cornerRadius = 10.0;
    
    [returnButton setTitle:@"返回" forState:UIControlStateNormal];
    
    [returnButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [returnButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [returnButton addTarget:self action:@selector(returnOnclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:returnButton];

#pragma topView
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(returnButton.frame) + 5,  self.view.bounds.size.width, 40)];
    
    topView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:topView];
    
    UILabel * topLabel = [[UILabel alloc]init];
    
    topLabel.center = CGPointMake(topView.frame.size.width/2, topView.frame.size.height/2);
    
    topLabel.frame = CGRectMake(0, 0, topView.frame.size.width / 3, topView.frame.size.height / 2);
    
    [topView addSubview:topLabel];
    
#pragma tableView创建
    UITableView * myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(returnButton.frame)) style:UITableViewStyleGrouped];
    
    myTableView.delegate = self;
    
    myTableView.dataSource = self;
    
    [myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    [self.view addSubview:myTableView];
    
    
    
}
#pragma tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.textLabel.text = @"支出额度";
    
    UILabel * accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width - 80, 5, 70, cell.frame.size.height - 10)];
    
    accountLabel.text = @"0.00";
    
    [cell addSubview:accountLabel];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    
    return  view;
}

-(void)returnOnclick{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
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
