//
//  WDDropViewTestView.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/24.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDDropViewTestView.h"

@implementation WDDropViewTestView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tableView];
        [self addSubview:self.sureButton];
        [self addSubview:self.resetButton];
        
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.trailing.mas_equalTo(0);
            make.height.mas_equalTo(45);
            make.width.mas_equalTo(self).multipliedBy(0.5);
        }];

        [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.leading.mas_equalTo(0);
            make.height.mas_equalTo(45);
            make.width.mas_equalTo(self).multipliedBy(0.5);
        }];

        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.leading.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(self.resetButton.mas_top);
        }];
    }
    return self;
}

#pragma mark - UITableView DataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"-------%ld", indexPath.row + 1];
    return cell;
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] init];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = kNormalFont(18);
        _sureButton.backgroundColor = kRGBColor(245, 245, 245);
    }
    return _sureButton;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        _resetButton = [[UIButton alloc] init];
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
        [_resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _resetButton.backgroundColor = [UIColor redColor];
        _resetButton.titleLabel.font = kNormalFont(18);
    }
    return _resetButton;
}

@end
