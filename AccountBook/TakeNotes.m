//
//  TakeNotes.m
//  AccountBook
//
//  Created by junhaoshen on 16/1/7.
//  Copyright © 2016年 junhaoshen. All rights reserved.
//

#import "TakeNotes.h"

#import "AddType.h"
#import "AppDelegate.h"
@interface TakeNotes ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

static float account = 0.00;

//定义屏幕宽高的宏
#define HEIGHT self.view.frame.size.height
#define WIDTH self.view.frame.size.width

@implementation TakeNotes
{
    UIImageView *imagePhoto;
    
    UIView * footerView;
    
    UIView * expendAmountView;
    
    float heightText;
    
    UITableView * myTableView;
    
    UITextView * myTextView;
    
    UILabel * remarksLabel;
    
    UIView * remarksLine;
    
    int n;
    
    int num;
    
    UILabel *labelAccount;
    
    NSMutableArray * myArray;
    
    BOOL isHaveDian;
    
    BOOL incomeFlag;
    
    BOOL expendFlag;
    
    AddType * typeObject;
    
    UILabel *accountLabel;
//    收入总额
    NSString * incomeStr;
//    支出总额
    NSString * expendStr;
    
    UIActionSheet *_actionSheet;
    
    UIImageView *_background;
    
    UIButton * photoButton;
    
    UIView * accountView;
}

-(void)viewWillAppear:(BOOL)animated{
    
    account = 0.00;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createUI];
    
//    [self createBackground];
    
    [self createActionSheet];
    
}

-(void)createUI{
    
    typeObject = [[AddType alloc]init];
    
    myArray = [[NSMutableArray alloc]initWithArray:@[@"餐饮"]];
    
//    n = 2;
    
    UIButton * certainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    certainButton.frame = CGRectMake(self.view.bounds.size.width - 90, 30, 70, 30);
    
    certainButton.layer.cornerRadius = 10.0;
    
    certainButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [certainButton setTitle:@"保存" forState:UIControlStateNormal];
    
    [certainButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [certainButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    certainButton.backgroundColor = [UIColor lightGrayColor];
    
    [certainButton addTarget:self action:@selector(certainOnclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:certainButton];
    
    _buttonOnclick.backgroundColor = [UIColor lightGrayColor];
    
    _buttonOnclick.layer.cornerRadius = 10;
    
    [_buttonOnclick addTarget:self action:@selector(OnclickReturn) forControlEvents:UIControlEventTouchUpInside];
    
    [_mySegmented addTarget:self action:@selector(segmentedOnclick:) forControlEvents:UIControlEventValueChanged];
    
//    创建总额的View
    accountView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_mySegmented.frame) + 5, self.view.bounds.size.width, 40)];
    
    [self.view addSubview:accountView];
    
    accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, accountView.frame.size.width / 4, accountView.frame.size.height - 10)];
    
    accountLabel.font = [UIFont boldSystemFontOfSize:16];

    accountLabel.text = @"支付总额";
    
    accountLabel.textColor = [UIColor blackColor];
    
    [accountView addSubview:accountLabel];
    
    labelAccount = [[UILabel alloc]initWithFrame:CGRectMake(accountView.frame.size.width - accountView.frame.size.width / 4 , 5, accountView.frame.size.width / 4, accountView.frame.size.height - 10)];
    
    labelAccount.font = [UIFont boldSystemFontOfSize:18];
    
    labelAccount.textColor = [UIColor blackColor];
    
    labelAccount.text = @"0.00";
    
    [accountView addSubview:labelAccount];

//   创建tableView
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(accountView.frame), self.view.bounds.size.width, self.view.bounds.size.height - myTableView.frame.origin.y) style:UITableViewStylePlain];
    
    myTableView.delegate = self;
    
    myTableView.dataSource = self;
    
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    myTableView.separatorColor = [UIColor grayColor];
    
    [myTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"FOOTER"];
    
    [myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    myTableView.scrollEnabled = NO;
    
    [self.view addSubview:myTableView];
    
    footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, myTableView.frame.size.width, myTableView.frame.size.height)];
    
    [myTableView setTableFooterView:footerView];
    
    myTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 5, myTableView.frame.size.width - 80, 38)];
    
    myTextView.delegate = self;
    
    [footerView addSubview:myTextView];

    myTextView.font = [UIFont systemFontOfSize:18];
// 照片
    imagePhoto = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(myTextView.frame), footerView.frame.size.width/2, 80)];
    
    [footerView addSubview:imagePhoto];
//********************************************
    photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    photoButton.frame =CGRectMake(CGRectGetMaxX(myTextView.frame), myTextView.frame.origin.y + 5, 40, 30);
    
    [photoButton setImage:[UIImage imageNamed:@"photo.jpg"] forState:UIControlStateNormal];
    
    photoButton.layer.cornerRadius = 10;
    
    [photoButton addTarget:self action:@selector(photoButtonOncllick) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:photoButton];
    
    remarksLabel = [[UILabel alloc]init];

    remarksLabel.center = CGPointMake(24, myTextView.frame.size.height/2);
    
    remarksLabel.bounds = CGRectMake(0, 0, 40, myTextView.frame.size.height-10);
    
    remarksLabel.enabled = NO;
    
    remarksLabel.text = @"备注";
    
    remarksLabel.textColor = [UIColor lightTextColor];
    
    [myTextView addSubview:remarksLabel];
    
    myTextView.returnKeyType = UIReturnKeyDone;
    
    remarksLine = [[UIView alloc]initWithFrame:CGRectMake(0, myTextView.frame.size.height - 2, myTextView.frame.size.width, 2)];
    
    remarksLine.backgroundColor = [UIColor lightGrayColor];

    [myTextView addSubview:remarksLine];

}

#pragma textfield的代理方法
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
     textField.text = [NSString stringWithFormat:@"%.2f",[textField.text floatValue]];
    
//    if ([textField.text rangeOfString:@"."].location==NSNotFound&&textField.text.length > 0) {
//        textField.text = [NSString stringWithFormat:@"%.2f",[textField.text floatValue]];
//    }
    
    account = account + [textField.text floatValue];
    
    labelAccount.text = [NSString stringWithFormat:@"%.2f",account];
   
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
//    rangeOfString 搜索string内的字符串 是否存在
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }

    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([textField.text length]==0){
                if(single == '.'){
//                    [self alertView:@"亲，第一个数字不能为小数点"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
                if (single == '0') {
//                    [self alertView:@"亲，第一个数字不能为0"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
            }
            if (single=='.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }else
                {
//                    [self alertView:@"亲，您已经输入过小数点了"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    int tt=range.location-ran.location;
                    if (tt <= 2){
                        return YES;
                    }else{
//                        [self alertView:@"亲，您最多输入两位小数"];
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
           
        }else{//输入的数据格式不正确
//            [self alertView:@"亲，您输入的格式不正确"];
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;  
    }
}

#pragma UItextViewDelegate的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView;{
    
    [remarksLabel setHidden:YES];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView;{
    
    if(textView.text.length == 0 ){
        
        [remarksLabel setHidden:NO];
    
    }else{
        [remarksLabel setHidden:YES];
    }
}

//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    
//    if([text isEqualToString:@"\n"]){
//        
//        [textView resignFirstResponder];
//        
//        return NO;
//    }
//    
//    return YES;
//    
//}

-(void)textViewDidChange:(UITextView *)textView{
    
    textView.frame=CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, textView.contentSize.height);
    
    remarksLine.frame = CGRectMake(0, myTextView.frame.size.height - 2, myTextView.frame.size.width, 2);

    float textViewWidth=textView.frame.size.width;//取得文本框高度
    
    NSString *content=textView.text;
    
    NSDictionary *dict=@{NSFontAttributeName:[UIFont systemFontOfSize:20.0]};
    
    CGSize contentSize=[content sizeWithAttributes:dict];//计算文字长度
    
    heightText=contentSize.height;
    
    int numLine=ceilf(contentSize.width/textViewWidth); //计算当前文字长度对应的行数
    
    if(numLine > 3){
        
        myTableView.frame = CGRectMake(myTableView.frame.origin.x, myTableView.frame.origin.y, myTableView.frame.size.width, myTableView.frame.size.height + (numLine - 2)*heightText);
        
        myTableView.contentOffset = CGPointMake(0, heightText *(numLine - 2));
        
        myTableView.scrollEnabled = YES;
    }
        
    if(myTableView.contentOffset.y == 0){
        
        myTableView.scrollEnabled = NO;
        
    }
    
    imagePhoto.frame = CGRectMake(0, CGRectGetMaxY(myTextView.frame)+ 3, footerView.frame.size.width/2, 80);
    
    photoButton.frame = CGRectMake(CGRectGetMaxX(myTextView.frame), CGRectGetMaxY(myTextView.frame) - 30, 40, 30);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return myArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, cell.frame.size.width / 4, cell.frame.size.height - 10)];
//    
//    label.font = [UIFont boldSystemFontOfSize:16];
//    
//    label.textColor = [UIColor blackColor];
//    
//    [cell addSubview:label];
    
    UITextField *cellTextField = [[UITextField alloc]initWithFrame:CGRectMake(cell.frame.size.width - cell.frame.size.width / 4 , 5, cell.frame.size.width / 4, cell.frame.size.height - 10)];
    
    cellTextField.font = [UIFont boldSystemFontOfSize:16];
    
    cellTextField.textColor = [UIColor blackColor];
    
    cellTextField.placeholder = @"0.00";

    cellTextField.delegate = self;
    
    cellTextField.clearsOnBeginEditing = YES;
    
    [cell addSubview:cellTextField];
    
//    UILabel *cellAccount = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width - cell.frame.size.width / 4 , 5, cell.frame.size.width / 4, cell.frame.size.height - 10)];
//    
//    cellAccount.font = [UIFont boldSystemFontOfSize:18];
//    
//    cellAccount.textColor = [UIColor blackColor];
//
//    [cell addSubview:cellAccount];
    
//    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightOnclick)];
//
//    [cellAccount addGestureRecognizer:rightTap];
    
//    if(indexPath.row == 0){
//        
//        label.text = @"支出总额：";
//        
//        labelAccount.text = @"0.00";
//        
//    }else{

        cell.textLabel.text = myArray[indexPath.row];
        
//        cellAccount.text = @"0.00";
    
//    }
    
    
    if(myTextView.text.length == 0&&myArray.count > 5){
        
        tableView.scrollEnabled = YES;
    }
        
    
    return cell;
}

//-(void)rightOnclick{
//    
//    NSLog(@"")
//    
//}


#pragma mark  添加和删除cell
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        if(myArray.count > 1){
        
        [myArray removeObjectAtIndex:(indexPath.row)];
            
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];

        }
        
        }];
    
    //设置添加按钮
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"添加" handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {

        collectRowAction.backgroundColor = [UIColor greenColor];
        
        [self presentViewController:typeObject animated:NO completion:nil];
        
       typeObject.myBlock = ^(NSString * str){
            
            [myArray insertObject:str atIndex:(indexPath.row )];
           
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];

        };
  
    }];
    
    collectRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    collectRowAction.backgroundColor = [UIColor grayColor];

    return  @[deleteRowAction,collectRowAction];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    return YES;
    
    
}

-(void)segmentedOnclick:(UISegmentedControl *)segmented{
    
   
    if(segmented.selectedSegmentIndex == 0){
        
        n = 1;
        
        accountLabel.text = @"支出金额";
        
        expendStr = [NSString stringWithFormat:@"%@",labelAccount.text];
        
        
    }else{
        
        n = 2;
        
        accountLabel.text = @"收入金额";

        incomeStr = [NSString stringWithFormat:@"%@",labelAccount.text];
        
    }
}

#pragma  照相机
//创建ActionSheet
- (void)createActionSheet
{
    _actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择功能" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"相机", nil];
}
//实现协议方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //switch传入你点击actionsheet的按钮索引
    switch (buttonIndex) {
        case 0:
        {
            //相册
            NSLog(@"相册");
            //UIImagePickerControllerSourceTypePhotoLibrary  系统相册
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                
                //使用相册
                [self loadImageWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                
            }else{
                
                //使用alertview提示相册不可用
                [self createAlertViewWithMeassge:@"不好意思，相册不可用！"];
                
            }
            
        }
            break;
        case 1:
        {
            //相机
            NSLog(@"相机");
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                //调用相机
                [self loadImageWithSourceType:UIImagePickerControllerSourceTypeCamera];
                
            }else{
                
                [self createAlertViewWithMeassge:@"不好意思，相机不可用!"];
                
            }
            
        }
            break;
        default:
            break;
    }
}

//封装一个方法  创建alertview
- (void)createAlertViewWithMeassge:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alertView show];
}
//调用相册、相机的方法
- (void)loadImageWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    //创建一个UIImagePickerController对象
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    //指定picker的类型
    picker.sourceType = sourceType;
    
    //指定代理对象
    picker.delegate = self;
    
    //推出pickerController（VC）    一般都使用模态的方式推出pickerController
    [self presentViewController:picker animated:YES completion:nil];
    
}
//实现UIImagePikcerController的协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"回传信息:%@", info);
    
    if ([info valueForKey:UIImagePickerControllerOriginalImage]) {
        //如果取到了   使用
        UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
        
        //UIImage *scaleImage = [ImageTool resizeIamgetoSize:CGSizeMake(50, 50) withImage:orgImage];
        //把取出后的图片赋给background
//        _background.image = orgImage;
        
//        UIImageView *imagePhoto = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(myTextView.frame), footerView.frame.size.width/2, 80)];
//        
        imagePhoto.image = orgImage;
        
         num ++;
//
//        [footerView addSubview:imagePhoto];
        
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"点击取消");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma 相机
-(void)photoButtonOncllick{
    
    //弹出actionsheet
    [_actionSheet showInView:self.view];
    
}

-(void)OnclickReturn{
    
    if(expendFlag||incomeFlag){
        
        UIApplication * app = [UIApplication sharedApplication];
        
        AppDelegate * appDelegate = app.delegate;
        
        //    appDelegate.income =
        
        appDelegate.expend = [NSString stringWithFormat:@"%.2f",account];
        
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

-(void)certainOnclick{

    labelAccount.text = [NSString stringWithFormat:@"%.2f",account];

//    [self dismissViewControllerAnimated:NO completion:nil];
    
}

-(void)createPhotoImage{
    
    
    
    
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
