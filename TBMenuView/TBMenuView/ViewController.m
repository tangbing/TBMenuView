//
//  ViewController.m
//  TBMenuView
//
//  Created by Tb on 2016/11/17.
//  Copyright © 2016年 Tb. All rights reserved.
//

#import "ViewController.h"
#import "TBMenuView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   TBMenuView *menuView = [[TBMenuView alloc] initWithTitles:@[@"访问书城",@"从电脑传书"] cancelButtonTitle:@"取消" buttonClickComplete:^(NSInteger selectRow, NSString *selectTitle) {
       NSLog(@"点击了%zd行,:%@",selectRow,selectTitle);
   }];
    
    [menuView show];
    
}


@end
