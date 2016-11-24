
//
//  TBMenuView.m
//  TBMenuView
//
//  Created by Tb on 2016/11/17.
//  Copyright © 2016年 Tb. All rights reserved.
//

#define mScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define mScreenHeight  ([UIScreen mainScreen].bounds.size.height)
#define TimeInterval 0.25

#define MenuHeight 150


#import "TBMenuView.h"
@interface TBMenuView()<UITableViewDataSource,UITableViewDelegate>
{
    NSString* _cancelButtonTitle;
    NSArray*  _titles;
}
@property (nonatomic,copy)void (^btnClickBlock)(NSInteger,NSString *);
/**遮盖*/
@property (nonatomic,strong)UIButton *coverButton;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *menuDatas;
@end

@implementation TBMenuView

- (UIButton *)coverButton
{
    if (!_coverButton) {
        _coverButton = [[UIButton alloc] init];
        _coverButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [_coverButton addTarget:self action:@selector(coverButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _coverButton.frame = [UIScreen mainScreen].bounds;
        _coverButton.hidden= YES;
    }
    return _coverButton;
}

- (NSMutableArray *)menuDatas
{
    if (!_menuDatas) {
        _menuDatas = [NSMutableArray array];
        [_menuDatas addObjectsFromArray:_titles];
    }
    return _menuDatas;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = MenuHeight / [self.menuDatas count];
        _tableView.separatorInset = UIEdgeInsetsZero;
    }
    return _tableView;
}

- (instancetype)initWithTitles:(NSArray *)titles cancelButtonTitle:(NSString *)cancelButtonTitle buttonClickComplete:(void (^)(NSInteger, NSString *))buttonClickComplete
{
    if (self = [super init]) {
        _titles = titles;
        _cancelButtonTitle = cancelButtonTitle;
        self.btnClickBlock = buttonClickComplete;
        self.frame = CGRectMake(0, mScreenHeight, mScreenWidth, MenuHeight);
        if (cancelButtonTitle == nil) {
            cancelButtonTitle = @"取消";
        }
        [self.menuDatas addObject:cancelButtonTitle];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.coverButton];
    [self addSubview:self.tableView];
    [window addSubview:self];
}

- (void)coverButtonClick
{
    [self hide];
}
- (void)show
{
    [UIView animateWithDuration:TimeInterval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.coverButton.hidden = NO;
        
        CGRect newFrame = self.frame;
        newFrame.origin.y = mScreenHeight - self.frame.size.height;
        self.frame = newFrame;
    } completion:nil];
}
- (void)hide
{
    [UIView animateWithDuration:TimeInterval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.coverButton.hidden = YES;
        
        CGRect newFrame = self.frame;
        newFrame.origin.y = mScreenHeight;
        self.frame = newFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.coverButton removeFromSuperview];
    }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    UILabel *contentLabel = [[UILabel alloc] init];
    [contentLabel setText:self.menuDatas[indexPath.row]];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.tintColor = [UIColor redColor];
    contentLabel.font = [UIFont boldSystemFontOfSize:18];
    contentLabel.frame = CGRectMake(0, 0, mScreenWidth, cell.frame.size.height);
    [cell.contentView addSubview:contentLabel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];
    !self.btnClickBlock ? : self.btnClickBlock(indexPath.row,self.menuDatas[indexPath.row]);
}

@end
