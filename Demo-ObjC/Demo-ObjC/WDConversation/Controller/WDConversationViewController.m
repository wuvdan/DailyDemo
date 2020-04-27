//
//  WDConversationViewController.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/26.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDConversationViewController.h"
#import "WDConversationMessageTextCell.h"
#import "WDConversationMessageOrderCell.h"
#import "WDConversationMessageImageCell.h"
#import "WDConversationModel.h"
#import <SDWebImage.h>
#import "WDConversationKeyboardView.h"
#import "WDConversationBoxViewController.h"

@interface WDConversationViewController ()<WDConversationBoxViewControllerDelegate>
@property (nonatomic, copy) NSArray<WDConversationModel *> *modelArray;
@property (nonatomic, strong) WDConversationBoxViewController *boxViewController;
@property (nonatomic, assign) CGFloat boxHeight;
@property (nonatomic, assign) CGFloat keybordHeight;

@end

@implementation WDConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"张三";
    
    self.boxHeight = kTabbarHeight;
        
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView registerClass:[WDConversationMessageTextCell class] forCellReuseIdentifier:@"WDConversationMessageTextCell"];
    [self.tableView registerClass:[WDConversationMessageOrderCell class] forCellReuseIdentifier:@"WDConversationMessageOrderCell"];
    [self.tableView registerClass:[WDConversationMessageImageCell class] forCellReuseIdentifier:@"WDConversationMessageImageCell"];
    
    WDConversationModel *m1 = [[WDConversationModel alloc] init];
    m1.directionType = WDConversationMessageDirectionTypeSend;
    m1.contentText = @"这是一个提供就熬这是一个提供就熬这是一个提供就熬这是一个提供就提供就熬这是一个提供就熬这是一个提供就熬";
    
    WDConversationModel *m2 = [[WDConversationModel alloc] init];
    m2.directionType = WDConversationMessageDirectionTypeRecive;
    m2.contentText = @"好的谢谢";
    
    WDConversationModel *m3 = [[WDConversationModel alloc] init];
    m3.directionType = WDConversationMessageDirectionTypeRecive;
    m3.orderModel = ({
        WDConversationOrderModel *orderModel = [[WDConversationOrderModel alloc] init];
        orderModel.path = @"长江西路（长江西路 - 玉兰大道）";
        orderModel.beginTime = @"· 2020-01-20 15:45:12";
        orderModel.endTime = @"· 2020-01-21 15:45:12";
        orderModel.price = @"20.00元";
        orderModel;
    });
    
    WDConversationModel *m4 = [[WDConversationModel alloc] init];
    m4.directionType = WDConversationMessageDirectionTypeSend;
    m4.orderModel = ({
        WDConversationOrderModel *orderModel = [[WDConversationOrderModel alloc] init];
        orderModel.path = @"长江西路（长江西路 - 玉兰大道）";
        orderModel.beginTime = @"· 2020-01-20 15:45:12";
        orderModel.endTime = @"· 2020-01-21 15:45:12";
        orderModel.price = @"20.00元";
        orderModel;
    });
    
    WDConversationModel *m5 = [[WDConversationModel alloc] init];
    m5.imagePath = @"http://t7.baidu.com/it/u=3616242789,1098670747&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg?sec=1588477259&t=b5097e1dae7e97289e773a4d5827727a";
    self.modelArray = @[m1, m2, m3, m4, m5];
    

    self.boxViewController = [[WDConversationBoxViewController alloc] init];
    self.boxViewController.delegate = self;
    [self addChildViewController:self.boxViewController];
    [self.view addSubview:self.boxViewController.view];
    
    [self.view addSubview:self.tableView];

    self.boxViewController.view.frame = CGRectMake(0, kScreenHeight - kTabbarHeight - kSafeAreaBottomHeight, kScreenWidth, kScreenHeight);
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaBottomHeight - kTabbarHeight);
}

- (void)chatBoxViewController:(WDConversationBoxViewController *)chatboxViewController
      didChangeTextViewHeight:(CGFloat)height {
    self.boxHeight = height;
    [self changeSubViewFrame];
}

- (void)chatBoxViewController:(WDConversationBoxViewController *)chatboxViewController
        didChangeChatBoxHeight:(CGFloat)height {
    self.keybordHeight = height;
    [self changeSubViewFrame];
}

- (void)scrollToBottom {
    if (self.modelArray.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.modelArray.count - 1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

- (void)changeSubViewFrame {
    if (self.keybordHeight > 100) { // 键盘弹出
        if (self.boxHeight <= kTabbarHeight) {
            self.boxViewController.view.frame = CGRectMake(0, kScreenHeight - kTabbarHeight - self.keybordHeight, kScreenWidth, kScreenHeight);
            self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - self.keybordHeight - kTabbarHeight);
        } else {
            self.boxViewController.view.frame = CGRectMake(0, kScreenHeight - self.boxHeight - self.keybordHeight, kScreenWidth, kScreenHeight);
            self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - self.keybordHeight - self.boxHeight);
        }
    } else { // 键盘收起
        self.boxViewController.view.frame = CGRectMake(0, kScreenHeight - kTabbarHeight - kSafeAreaBottomHeight, kScreenWidth, kScreenHeight);
        self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaBottomHeight - kTabbarHeight);
        
        if (self.boxHeight <= kTabbarHeight) {
            self.boxViewController.view.frame = CGRectMake(0, kScreenHeight - kTabbarHeight - kSafeAreaBottomHeight, kScreenWidth, kScreenHeight);
            self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaBottomHeight - kTabbarHeight);
        } else {
            self.boxViewController.view.frame = CGRectMake(0, kScreenHeight - self.boxHeight - kSafeAreaBottomHeight, kScreenWidth, kScreenHeight);
            self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaBottomHeight - self.boxHeight);
        }
    }
    [self scrollToBottom];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDConversationModel *model = self.modelArray[indexPath.section];
    
    if (model.contentText.length != 0 && model.imagePath.length == 0 && model.orderModel == nil) {
        WDConversationMessageTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WDConversationMessageTextCell" forIndexPath:indexPath];
        cell.messageDirectionTypeSend = model.directionType;
        cell.contentTextLabel.text = model.contentText;
        return cell;
    } else if (model.contentText.length == 0 && model.imagePath.length == 0 && model.orderModel != nil) {
        WDConversationMessageOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WDConversationMessageOrderCell" forIndexPath:indexPath];
         cell.messageDirectionTypeSend = model.directionType;
        cell.contentOrderView.pathLabel.text = model.orderModel.path;
        cell.contentOrderView.beginTimeLabel.text = model.orderModel.beginTime;
        cell.contentOrderView.endTimeLabel.text = model.orderModel.endTime;
        cell.contentOrderView.priceLabel.text = model.orderModel.price;
        return cell;
    } else {
        WDConversationMessageImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WDConversationMessageImageCell" forIndexPath:indexPath];
        cell.messageDirectionTypeSend = model.directionType;
        [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.imagePath]];
        [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.imagePath]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDConversationModel *model = self.modelArray[indexPath.section];
    return [model getContentHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.boxViewController resignFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.boxViewController resignFirstResponder];
    self.keybordHeight = 0;
    [self changeSubViewFrame];
}
@end
