//
//  AddType.m
//  AccountBook
//
//  Created by junhaoshen on 16/1/13.
//  Copyright © 2016年 junhaoshen. All rights reserved.
//

#import "AddType.h"

@interface AddType ()

@end

@implementation AddType

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
    
}

-(void)createUI{
    
//    UITextField * mytextFiled = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 35)];
//    
//    mytextFiled.borderStyle = UITextBorderStyleRoundedRect;
//    
//    mytextFiled.textAlignment = NSTextAlignmentLeft;
//    
//    mytextFiled.placeholder = @"请输入内容";
//    
//    mytextFiled.clearsOnBeginEditing = YES;
//    
//    mytextFiled.clearButtonMode = UITextFieldViewModeAlways;
//    
//    [self.view addSubview:mytextFiled];
    
    for(int i = 0;i < 3 ;i ++){
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.backgroundColor = [UIColor lightGrayColor];
        
        button.frame = CGRectMake(20, 80 + i * 37, self.view.frame.size.width - 40, 35);
        
        button.tag = 100 + i;
        
        if(i == 0){
            [button setTitle:@"餐饮" forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(foodOnclick) forControlEvents:UIControlEventTouchUpInside];
            
        }else if(i == 1){
            [button setTitle:@"住宿" forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(houseOnclick) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            [button setTitle:@"交通" forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(trafficOnclick) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
        
        [self.view addSubview:button];
        
        
        
    }
    
    
    
    UIButton * returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    returnButton.frame = CGRectMake(25, 30, 60, 30);
    
    returnButton.backgroundColor = [UIColor grayColor];
    
    returnButton.layer.cornerRadius = 10.0;
    
    [returnButton setTitle:@"返回" forState:UIControlStateNormal];
    
    [returnButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [returnButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [returnButton addTarget:self action:@selector(buttonOnclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:returnButton];
    
//    UIButton * certainButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    certainButton.frame = CGRectMake(self.view.frame.size.width - 25 - 60, 30, 60, 30);
//    
//    certainButton.backgroundColor = [UIColor grayColor];
//    
//    certainButton.layer.cornerRadius = 10.0;
//    
//    [certainButton setTitle:@"确定" forState:UIControlStateNormal];
//    
//    [certainButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    
//    [certainButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    
//    [certainButton addTarget:self action:@selector(certainOnclick) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:certainButton];
    
    
    
}

-(void)buttonOnclick{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

-(void)foodOnclick{
    
     _string = @"餐饮";
    
    self.myBlock(self.string);

    [self dismissViewControllerAnimated:NO completion:nil];
    
}

-(void)houseOnclick{
    
    NSString * str= @"住宿";
    
    self.myBlock(str);
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

-(void)trafficOnclick{

    _string = @"交通";
    
    self.myBlock(self.string);
    
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
