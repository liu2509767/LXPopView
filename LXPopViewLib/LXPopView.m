//
//  LXPopView.m
//  LXPopView
//
//  Created by LiuXin on 16/11/16.
//  Copyright © 2016年 LiuXin. All rights reserved.
//

#import "LXPopView.h"
/**
 *  使用时请解开此注释 及对应的AppDelegate代码
 *
 *  @return <#return value description#>
 */
//#import "AppDelegate.h"
#define MainScreenWith  [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface LXPopView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIDatePicker * datePicker;
    UIPickerView * pickerView;
    NSMutableArray *pickerViewArr;
    NSString * confirmStr;
    BOOL isDate;
}
@end
@implementation LXPopView
-(instancetype)initWithFrame:(CGRect)frame withButtonChooseView:(NSArray *)dataSoure
{
    self = [super initWithFrame:frame];
    if (self) {
        _dire = @"1";
        [self createButtomButton];
        if (dataSoure) {
        //自定义
            isDate = NO;
            pickerViewArr = [NSMutableArray arrayWithArray:dataSoure];
            [self createPickerView];
        }else{
        //时间选择器
            isDate = YES;
            [self createDatePicker];
        }
    }

    return self;
}
-(instancetype)initWithFrame:(CGRect)frame withDirection:(LXPopViewDirection)direction withView:(UIView *)view
{
    self = [super initWithFrame:frame];
    if (self) {
        switch (direction) {
            case LXPopViewTop:
            {
                _dire = @"0";
                [self createTopButton];
            }
                break;
            case LXPopViewButtom:
            {
                _dire = @"1";
                [self createButtomView:view];
            }
                break;
            case LXPopViewLeft:
            {
                _dire = @"2";
                
            }
                break;
            case LXPopViewRight:
            {
                _dire = @"3";
                [self createButtomView:view];
                
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}
-(void)createDatePicker
{
    datePicker = [[UIDatePicker alloc]init];
    datePicker.frame = CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 40);
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;

    self.layer.cornerRadius = 10;
    [self addSubview:datePicker];

}
-(void)createPickerView
{
    pickerView = [[UIPickerView alloc]init];
    pickerView.frame = CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 40);
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self addSubview:pickerView];
    //设定初始值
//    [pickerView selectRow:1 inComponent:0 animated:NO];
    [pickerView reloadAllComponents];
}
-(void)createButtomView:(UIView *)view
{
    [self addSubview:view];

}
-(void)createButtomButton
{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,40, MainScreenWith, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2,0, 1, 40)];
    line1.backgroundColor = [UIColor grayColor];
    [self addSubview:line1];
    //取消
    UIButton * cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(0,0, self.frame.size.width / 2, 40);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    //确定
    UIButton * confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    confirm.frame = CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width / 2, 40);
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    [confirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirm addTarget:self action:@selector(confirmDateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirm];
    
    
}
-(void)createTopButton
{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 40 , MainScreenWith, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2, self.frame.size.height - 40 , 1, 40)];
    line1.backgroundColor = [UIColor grayColor];
    [self addSubview:line1];
    //取消
    UIButton * cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(0, self.frame.size.height - 40, self.frame.size.width / 2, 40);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    //确定
    UIButton * confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    confirm.frame = CGRectMake(self.frame.size.width / 2, self.frame.size.height - 40, self.frame.size.width / 2, 40);
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    [confirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirm addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirm];
    

}
- (void)LXPopViewShow
{
    //解开此注释 详情看demo
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    _bgview = [[UIView alloc]initWithFrame:CGRectMake(0,0, MainScreenWith, MainScreenHeight)];
//    //黑层效果
//    if ([_dire isEqualToString:@"1"]||[_dire isEqualToString:@"3"]) {
//        _bgview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//    }else{
//    //透明
//    _bgview.backgroundColor = [UIColor clearColor];
//    }
//    [delegate.window addSubview:_bgview];
//    
//    //手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBgviewClick:)];
//    tap.numberOfTapsRequired = 1;
//    _bgview.userInteractionEnabled = YES;
//    [_bgview addGestureRecognizer:tap];
//    [delegate.window addSubview:self];
    //
    
    //滑出效果
        if ([_dire isEqualToString:@"1"]) {
            [UIView animateWithDuration:0.35 animations:^{
            self.frame = CGRectMake((MainScreenWith - self.frame.size.width)/2, MainScreenHeight - self.frame.size.height, self.frame.size.width, self.frame.size.height);
            }];
        }else if([_dire isEqualToString:@"3"]){

            [UIView animateWithDuration:0.35 delay:0.1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                    self.frame = CGRectMake(MainScreenWith * 1 / 3, 0, self.frame.size.width, self.frame.size.height);
            } completion:nil];
        
        }else if([_dire isEqualToString:@"0"]){
            [UIView animateWithDuration:0.35 animations:^{
                self.transform=CGAffineTransformMakeScale(1, 1);
            }];
           
        }else{
        
        
        }



}
-(void)confirmAction:(UIButton *)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(confirmButton:)]) {
        [self LXPopViewDissmiss];
        [self.delegate confirmButton:sender];
    }

}
-(void)confirmDateAction:(UIButton *)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(confirmDate:)]) {
        [self LXPopViewDissmiss];
        if (isDate) {
            NSDate * date = datePicker.date;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString * dateStr = [formatter stringFromDate:date];
            [self.delegate confirmDate:dateStr];
        }else
        {
            confirmStr = [pickerViewArr objectAtIndex:[pickerView selectedRowInComponent:0]];
            [self.delegate confirmDate:confirmStr];
        }
        
    }
}
-(void)cancelAction
{
    [self LXPopViewDissmiss];
}
- (void)tapBgviewClick:(UITapGestureRecognizer *)tap{
    [self LXPopViewDissmiss];
}
- (void)LXPopViewDissmiss
{
//    AppDelegate  *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    delegate.window.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.358 animations:^{
        if ([_dire isEqualToString:@"1"]) {
            self.frame = CGRectMake(0, MainScreenHeight, self.frame.size.width, self.frame.size.height);
        }else if([_dire isEqualToString:@"3"]){
        
            self.frame = CGRectMake(MainScreenWith, 0 , self.frame.size.width, self.frame.size.height);
        
        }else{
             self.frame = CGRectMake(0, 0 - self.frame.size.height , self.frame.size.width, self.frame.size.height);
        }

    } completion:^(BOOL finished) {
        [_bgview removeFromSuperview];
    }];


}
#pragma mark --UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //暂且定为1列，如需2 3 4 列 可通过 传过来的 dataSource进行更改
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return pickerViewArr.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [pickerViewArr objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
//    confirmStr = [pickerViewArr objectAtIndex:row];
}
@end
