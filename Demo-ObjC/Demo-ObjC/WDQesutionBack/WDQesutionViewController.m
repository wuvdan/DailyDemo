//
//  WDQesutionViewController.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/28.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDQesutionViewController.h"
#import "WDCommonQuestionListTableViewCell.h"

@interface WDQesutionViewController ()
@property (nonatomic, copy) NSArray<NSArray<NSString *> *> *questionList;
@property (nonatomic, assign) bool isShowAll;
@property (nonatomic, assign) NSInteger showAllRow;
@end

@implementation WDQesutionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isShowAll = NO;
    
    self.tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[WDCommonQuestionListTableViewCell class] forCellReuseIdentifier:@"WDCommonQuestionListTableViewCell"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.questionList = @[@[@"课件附件昂克赛拉对讲机爱神的箭发神经", @"坚实的分解按实际方飒飒房间爱上"],
                          @[@"课件附件昂克赛拉对讲机爱神的箭发神经", @"坚实的分解按实际方飒飒房间爱上", @"坚实的分解按实际方飒飒房间爱上"],
                          @[@"1课件附件昂克赛拉对讲机爱神的箭发神经", @"2坚实的分解按实际方飒飒房间爱上", @"3坚实的分解按实际方飒飒房间爱上", @"4坚实的分解按实际方飒飒房间爱上" ,@"5坚实的分分解按实际方飒飒房间爱上分解按实际方飒飒房间爱上解按实际方飒飒房间爱上"]];
}

#pragma mark - UITableView DataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDCommonQuestionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WDCommonQuestionListTableViewCell" forIndexPath:indexPath];
    cell.questionButton.logoImageView.image = [UIImage imageNamed:@"car"];
    cell.questionButton.arrowImageView.image = [UIImage imageNamed:@"arrow down"];
    cell.questionButton.textLabel.text = @"我的车辆";
    if (self.questionList[indexPath.row].count <= 2) {
        cell.questionsList = self.questionList[indexPath.row];
        cell.questionButton.arrowImageView.hidden = YES;
    } else {
        cell.questionButton.arrowImageView.hidden = NO;
        if (self.isShowAll) {
            if (indexPath.row == self.showAllRow) {
                cell.questionsList = self.questionList[indexPath.row];
                cell.questionButton.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
            } else {
                NSArray *array = @[self.questionList[indexPath.row].firstObject, self.questionList[indexPath.row][1]];
                cell.questionsList = array;
                cell.questionButton.arrowImageView.transform = CGAffineTransformIdentity;
            }
        } else {
            NSArray *array = @[self.questionList[indexPath.row].firstObject, self.questionList[indexPath.row][1]];
            cell.questionsList = array;
            cell.questionButton.arrowImageView.transform = CGAffineTransformIdentity;
        }
    }
    cell.questionButton.tag = indexPath.row;
    [cell.questionButton addTarget:self action:@selector(showAllList:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)showAllList:(WDQuestionButton *)sender {
    if (self.showAllRow == sender.tag && self.isShowAll) {
        self.isShowAll = NO;
    } else {
        self.isShowAll = YES;
    }
    self.showAllRow = sender.tag;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.questionList[indexPath.row].count <= 2) {
        return 50 * self.questionList[indexPath.row].count;
    } else {
        if (self.isShowAll) {
            if (indexPath.row == self.showAllRow) {
                return 50 * self.questionList[indexPath.row].count;
            }
        }
        return 100;
    }
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
