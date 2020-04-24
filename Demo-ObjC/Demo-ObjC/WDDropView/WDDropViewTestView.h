//
//  WDDropViewTestView.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/24.
//  Copyright © 2020 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDDropViewTestView : UIView<UITableViewDelegate, UITableViewDataSource>
/** TableView */
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *resetButton;
@end

NS_ASSUME_NONNULL_END
