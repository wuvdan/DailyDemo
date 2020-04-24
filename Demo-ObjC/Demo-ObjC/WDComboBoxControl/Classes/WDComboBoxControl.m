//
//  WDComboBoxControl.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/24.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDComboBoxControl.h"

@interface WDComboBoxControl () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> * dataArray;
@property (nonatomic, strong) NSArray<NSString *> * titleArray;
@property (nonatomic, strong) UIView *sourceView;
@property (nonatomic, assign) WDComboBoxControlDirection direction;
@end

@implementation WDComboBoxControl

#pragma mark =============== 初始化页面 ===============
- (instancetype)initViewWithMaxHeight:(CGFloat)height fromView:(UIView *)view showDirection:(WDComboBoxControlDirection)direction {
    self = [super init];
    if (self) {
        _viewHeight = height;
        _sourceView = view;
        _direction = direction;
        [self setupSubViewsPropertys];
        [self setupSubViewsConstraints];
    }
    return self;
}

#pragma mark =============== 显示页面 ===============
- (void)showInView {
    self.frame = UIScreen.mainScreen.bounds;
    [UIApplication.sharedApplication.delegate.window addSubview:self];
}

#pragma mark =============== 让页面消失 ===============
- (void)dismisssView {
    [self removeFromSuperview];
}

#pragma mark =============== 获取数据源 ===============
- (void)setDataSource:(id<WDComboBoxControlDataSource>)dataSource {
    _dataSource = dataSource;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dataSourceOfColunm)]) {
        self.dataArray = [self.dataSource dataSourceOfColunm];
    }
    
    if (self.dataArray && [self.dataSource respondsToSelector:@selector(titleOfSection)]) {
        self.titleArray =  [self.dataSource titleOfSection];
    }
    
    [self.tableView reloadData];
}

#pragma mark =============== Add controls, set properties ===============
- (void)setupSubViewsPropertys {
    self.backgroundButton = [[UIButton alloc] init];
    self.backgroundButton.backgroundColor = UIColor.clearColor;
    [self.backgroundButton addTarget:self action:@selector(dismisssView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backgroundButton];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.tableView.layer.borderWidth = 0.5;
    self.tableView.estimatedRowHeight = 45;
    self.tableView.layer.cornerRadius = 5;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self addSubview:self.tableView];
}

#pragma mark =============== Setting control layout constraints ===============
- (void)setupSubViewsConstraints {
    self.backgroundButton.frame = UIScreen.mainScreen.bounds;
    
    switch (self.direction) {
        case WDComboBoxControlDirectionBottom:{
            self.tableView.frame = CGRectMake(CGRectGetMinX(self.sourceView.frame),
                                              CGRectGetMaxY(self.sourceView.frame),
                                              self.sourceView.frame.size.width,
                                              self.viewHeight);
        }
            break;
        case WDComboBoxControlDirectionTop:{
            self.tableView.frame = CGRectMake(CGRectGetMinX(self.sourceView.frame),
                                              CGRectGetMaxY(self.sourceView.frame) - self.viewHeight - self.sourceView.frame.size.height,
                                              self.sourceView.frame.size.width,
                                              self.viewHeight);
        }
            break;
        case WDComboBoxControlDirectionLeading:{
            self.tableView.frame = CGRectMake(CGRectGetMinX(self.sourceView.frame) - self.sourceView.frame.size.width,
                                              CGRectGetMinY(self.sourceView.frame),
                                              self.sourceView.frame.size.width,
                                              self.viewHeight);
        }
            break;
        case WDComboBoxControlDirectionTrailing:{
            self.tableView.frame = CGRectMake(CGRectGetMinX(self.sourceView.frame) + self.sourceView.frame.size.width,
                                              CGRectGetMinY(self.sourceView.frame),
                                              self.sourceView.frame.size.width,
                                              self.viewHeight);
        }
            break;
        default:
            break;
    }
}

#pragma mark =============== UITableViewDelegate, UITableViewDataSource ===============
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titleArray[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedAtIndexPath:resultTitle: fromSourceView:)]) {
        [self.delegate selectedAtIndexPath:indexPath resultTitle:self.dataArray[indexPath.section][indexPath.row] fromSourceView:self.sourceView];
        [self dismisssView];
    }
}
@end
