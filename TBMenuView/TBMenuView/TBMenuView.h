//
//  TBMenuView.h
//  TBMenuView
//
//  Created by Tb on 2016/11/17.
//  Copyright © 2016年 Tb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBMenuView : UIView


/**
 初始化化方法
 @param titles              标题数组
 @param cancelButtonTitle   取消
 @param buttonClickComplete 点击的回掉
 */
- (instancetype)initWithTitles:(NSArray *)titles cancelButtonTitle:(NSString *)cancelButtonTitle buttonClickComplete:(void (^)(NSInteger selectRow,NSString *selectTitle))buttonClickComplete;

/**显示*/
- (void)show;
@end
