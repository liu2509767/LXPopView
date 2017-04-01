//
//  LXPopView.h
//  LXPopView
//
//  Created by LiuXin on 16/11/16.
//  Copyright © 2016年 LiuXin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,LXPopViewDirection) {
    LXPopViewTop,
    LXPopViewButtom,
    LXPopViewLeft,//因项目并未用到,暂未实现 与Right 类似
    LXPopViewRight

};
@protocol LXPopViewDelegate <NSObject>
@optional
- (void)confirmButton:(UIButton *)sender;
- (void)confirmDate:(NSString *)value;
@end
@interface LXPopView : UIView
@property (nonatomic,strong)UIView *bgview;
@property (nonatomic,copy)NSString *dire;
@property (nonatomic,assign)id<LXPopViewDelegate>delegate;
/**
 *  弹出窗口
 *
 *  @param frame     frame
 *  @param direction 方向
 *  @param view      view
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame withDirection:(LXPopViewDirection)direction withView:(UIView *)view;
/**
 *  底部选择pickerView
 *
 *  @param frame     fram
 *  @param dataSoure nil or dataSoure （datapickerview or pickerview）
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame withButtonChooseView:(NSArray *)dataSoure;
/**
 *  弹出
 */
- (void)LXPopViewShow;
/**
 *  消失
 */
- (void)LXPopViewDissmiss;
@end
