//
//  ViewController.m
//  LXPopView
//
//  Created by LiuXin on 16/11/16.
//  Copyright © 2016年 LiuXin. All rights reserved.
//

#import "ViewController.h"
#import "LXPopView.h"
#define MainScreenWith  [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<LXPopViewDelegate>
{
    UILabel *lab;
    UITextField * ta;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [rightBtn addTarget: self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(0, 0, 50, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, 300, 50)];
    lab.backgroundColor = [UIColor redColor];
    lab.text = @"原数据！！！！";
    [self.view addSubview:lab];
    
    ta = [[UITextField alloc]initWithFrame:CGRectMake(0, 400, 300, 50)];
    ta.backgroundColor = [UIColor whiteColor];
    ta.enabled = NO;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 400, 300, 50);
    [button addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self.view addSubview:ta];
   
    
}
-(void)rightBtnAction
{
////    UIView * vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWith, 200)];
////    vie.backgroundColor = [UIColor redColor];
    LXPopView * lx = [[LXPopView alloc]initWithFrame:CGRectMake(MainScreenWith,0, MainScreenWith*2/3,MainScreenHeight) withDirection:LXPopViewRight withView:nil
                      ];
//    lx.transform = CGAffineTransformMakeScale(0, 0);
    lx.delegate = self;
    lx.backgroundColor = [UIColor whiteColor];

    [lx LXPopViewShow];
//    NSArray * arr = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
//    LXPopView * lx = [[LXPopView alloc]initWithFrame:CGRectMake(0,MainScreenHeight, MainScreenWith , 216) withButtonChooseView:arr];
//    lx.backgroundColor = [UIColor whiteColor];
//    lx.delegate = self;
//    [lx LXPopViewShow];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//代理
//-(void)confirmButton:(UIButton *)sender
//{
//    lab.text = @"筛选新数据";
//}
-(void)confirmDate:(NSString *)sender
{
    ta.text = sender;
}

@end
