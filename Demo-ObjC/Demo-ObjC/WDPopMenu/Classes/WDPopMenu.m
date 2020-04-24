//
//  WDPopMenu.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/23.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDPopMenu.h"

#define WD_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define WD_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

typedef NS_ENUM(NSInteger, WDPopMenuType) {
    WDPopMenuTypeNormal,
    WDPopMenuTypeOnlyTitle,
    WDPopMenuTypeOnlyIcon,
};

@interface WDPopMenuCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) WDPopMenuType showType;
@end

@implementation WDPopMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViewsProperties];
    }
    return self;
}

- (void)setupSubViewsProperties {
    self.iconImageView                                           = [[UIImageView alloc] init];
    self.iconImageView.contentMode                               = UIViewContentModeScaleAspectFit;
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLabel                                              = [[UILabel alloc] init];
    self.titleLabel.font                                         = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor                                    = [UIColor blackColor];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints    = NO;
    [self.contentView addSubview:self.titleLabel];
}

- (void)setShowType:(WDPopMenuType)showType {
    _showType = showType;
    [self setupSubViewsConstraint];
}

- (void)setTitleLabel:(UILabel *)titleLabel {
    _titleLabel = titleLabel;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupSubViewsConstraint {
    if (self.showType == WDPopMenuTypeNormal) {
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addConstraints:@[
                                           [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:15],
                                           [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
                                           ]];
        
        [self.contentView addConstraints:@[
                                           [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.iconImageView attribute:NSLayoutAttributeTrailing multiplier:1 constant:10],
                                           [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
                                           ]];
    } else if (self.showType == WDPopMenuTypeOnlyTitle){
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addConstraints:@[
                                           [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
                                           [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
                                           ]];
    } else {
        [self.contentView addConstraints:@[
                                           [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
                                           [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
                                           ]];
    }
}
@end

typedef NS_ENUM(NSInteger, ArrowDirection) {
    ArrowDirectionRight = 0,
    ArrowDirectionBottom,
    ArrowDirectionLeft,
    ArrowDirectionTop,
};

#define CORNER_RADIUS   8   // 默认矩形框圆角半径
#define ARROW_WIDTH     30  // 默认箭头宽带
#define ARROW_HEIGHT    12  // 默认箭头高度
#define ARROW_DIRECTION 1   // 默认箭头方向，向下
#define ARROW_POSITION  0.5 // 默认箭头相对位置，居中
#define ARROW_RADIUS    3   // 默认箭头指向处的圆角半径

@interface WudanLayer : NSObject
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat arrowRadius;
@property (nonatomic, assign) CGFloat arrowHeight;
@property (nonatomic, assign) CGFloat arrowWidth;
@property (nonatomic, assign) ArrowDirection arrowDirection;
@property (nonatomic, assign) CGFloat arrowPosition;
@property (nonatomic, assign) CGSize size;

- (instancetype)initWithSize:(CGSize)size;
- (CAShapeLayer *)layer;
@end

@implementation WudanLayer

#pragma mark - preparation
- (NSMutableArray *)keyPoints {
    NSMutableArray *points = [NSMutableArray array];
    CGPoint beginPoint;
    CGPoint topPoint;
    CGPoint endPoint;
    CGFloat validWidthForTopPoint = _size.width - 2 * _cornerRadius - _arrowWidth;
    CGFloat validHeightForTopPoint = _size.height - 2 * _cornerRadius - _arrowWidth;
    CGFloat x = 0, y = 0;
    CGFloat width = _size.width, height = _size.height;
    
    switch (_arrowDirection)
    {
        case ArrowDirectionRight:
        {
            width -= _arrowHeight;
            topPoint = CGPointMake(_size.width , _size.height / 2 + validHeightForTopPoint*(_arrowPosition - 0.5));
            beginPoint = CGPointMake(topPoint.x - _arrowHeight, topPoint.y - _arrowWidth/2);
            endPoint = CGPointMake(beginPoint.x, beginPoint.y + _arrowWidth);
        }
            break;
        case ArrowDirectionBottom:
        {
            height -= _arrowHeight;
            
            topPoint = CGPointMake(_size.width / 2 + validWidthForTopPoint*(_arrowPosition - 0.5), _size.height);
            beginPoint = CGPointMake(topPoint.x + _arrowWidth/2, topPoint.y - _arrowHeight);
            endPoint = CGPointMake(beginPoint.x - _arrowWidth, beginPoint.y);
        }
            break;
        case ArrowDirectionLeft:
        {
            x = _arrowHeight;
            width -= _arrowHeight;
            
            topPoint = CGPointMake(0, _size.height / 2 + validHeightForTopPoint*(_arrowPosition - 0.5));
            beginPoint = CGPointMake(topPoint.x + _arrowHeight, topPoint.y + _arrowWidth/2);
            endPoint = CGPointMake(beginPoint.x, beginPoint.y - _arrowWidth);
        }
            break;
        case ArrowDirectionTop:
        {
            y = _arrowHeight;
            height -= _arrowHeight;
            
            topPoint = CGPointMake(_size.width / 2 + validWidthForTopPoint*(_arrowPosition - 0.5), 0);
            beginPoint = CGPointMake(topPoint.x - _arrowWidth/2, topPoint.y + _arrowHeight);
            endPoint = CGPointMake(beginPoint.x + _arrowWidth, beginPoint.y);
        }
            break;
    }
    
    points = [NSMutableArray arrayWithObjects: [NSValue valueWithCGPoint:beginPoint],
              [NSValue valueWithCGPoint:topPoint],
              [NSValue valueWithCGPoint:endPoint],
              nil];
    CGPoint bottomRight = CGPointMake(x + width, y + height);
    CGPoint bottomLeft = CGPointMake(x, y + height);
    CGPoint topLeft = CGPointMake(x, y);
    CGPoint topRight = CGPointMake(x + width, y);
    NSMutableArray *rectPoints = [NSMutableArray arrayWithObjects: [NSValue valueWithCGPoint:bottomRight],
                                  [NSValue valueWithCGPoint:bottomLeft],
                                  [NSValue valueWithCGPoint:topLeft],
                                  [NSValue valueWithCGPoint:topRight],
                                  nil];
    int rectPointIndex = (int)_arrowDirection;
    for(int i = 0; i < 4; ++i) {
        [points addObject:[rectPoints objectAtIndex:rectPointIndex]];
        rectPointIndex = (rectPointIndex + 1) % 4;
    }
    return points;
}

#pragma mark - Draw bubblePath
- (CGPathRef)bubblePath {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    NSMutableArray *points = [self keyPoints];
    CGPoint currentPoint = [[points objectAtIndex:6] CGPointValue];
    CGContextMoveToPoint(ctx, currentPoint.x, currentPoint.y);
    CGPoint pointA, pointB;
    CGFloat radius;
    int i = 0;
    while(1) {
        if (i > 6)
            break;
        radius = i < 3 ?  _arrowRadius : _cornerRadius;
        pointA = [[points objectAtIndex:i] CGPointValue];
        pointB = [[points objectAtIndex:(i + 1) % 7] CGPointValue];
        CGContextAddArcToPoint(ctx, pointA.x, pointA.y, pointB.x, pointB.y, radius);
        i = i + 1;
    }
    CGContextClosePath(ctx);
    CGPathRef path = CGContextCopyPath(ctx);
    CGContextRelease(ctx);
    return path;
}

- (CAShapeLayer *)layer{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = [self bubblePath];
    return layer;
}

#pragma mark - Setup
- (void)setDefaultProperty {
    _cornerRadius   = CORNER_RADIUS;
    _arrowWidth     = ARROW_WIDTH;
    _arrowHeight    = ARROW_HEIGHT;
    _arrowDirection = ARROW_DIRECTION;
    _arrowPosition  = ARROW_POSITION;
    _arrowRadius    = ARROW_RADIUS;
}

#pragma mark - Init
- (instancetype)initWithSize:(CGSize)size {
    if(self = [super init]) {
        [self setDefaultProperty];
        _size = size;
    }
    return self;
}
@end

@interface WDPopMenu () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) void (^selectedItemComplete)(NSInteger currentIndex);
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGPoint beginPosition;
@property (nonatomic, strong) UIColor *cellColor;
@property (nonatomic, copy, readwrite) NSArray<NSString *> *titles;
@property (nonatomic, copy, readwrite) NSArray<NSString *> *iconImageNames;
@end

@implementation WDPopMenu

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.tableView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTappedTarget:)];
        [self.backgroundView addGestureRecognizer:tap];
    }
    return self;
}

+ (void)showPopMenuWithIconImageNames:(NSArray<NSString *> *)iconImageNames
                       originPosition:(CGPoint)position
                 selectedItemComplete:(void(^)(NSInteger currentIndex))complete {
    
    [self showPopMenuWithIconImageNames:iconImageNames
                         originPosition:position
                      needSeparatorLine:YES
                   selectedItemComplete:complete];
}

+ (void)showPopMenuWithIconImageNames:(NSArray<NSString *> *)iconImageNames
                       originPosition:(CGPoint)position
                    needSeparatorLine:(BOOL)isNeedSeparatorLine
                 selectedItemComplete:(void(^)(NSInteger currentIndex))complete {
    
    [self showPopMenuWithIconImageNames:iconImageNames
                                 titles:nil
                         originPosition:position
                      needSeparatorLine:isNeedSeparatorLine
                   selectedItemComplete:complete];
}

+ (void)showPopMenuWithTitles:(NSArray<NSString *> *)titles
               originPosition:(CGPoint)position
         selectedItemComplete:(void(^)(NSInteger currentIndex))complete {
    
    [self showPopMenuWithTitles:titles
                 originPosition:position
              needSeparatorLine:YES
           selectedItemComplete:complete];
}

+ (void)showPopMenuWithTitles:(NSArray<NSString *> *)titles
               originPosition:(CGPoint)position
            needSeparatorLine:(BOOL)isNeedSeparatorLine
         selectedItemComplete:(void(^)(NSInteger currentIndex))complete {
    
    [self showPopMenuWithIconImageNames:nil
                                 titles:titles
                         originPosition:position
                      needSeparatorLine:isNeedSeparatorLine
                   selectedItemComplete:complete];
}

+ (void)showPopMenuWithIconImageNames:(NSArray<NSString *> * _Nullable)iconImageNames
                               titles:(NSArray<NSString *> * _Nullable)titles
                       originPosition:(CGPoint)position
                 selectedItemComplete:(void(^)(NSInteger currentIndex))complete {
    
    [self showPopMenuWithIconImageNames:iconImageNames
                                 titles:titles
                         originPosition:position
                      needSeparatorLine:YES
                   selectedItemComplete:complete];
}

+ (void)showPopMenuWithIconImageNames:(NSArray<NSString *> * _Nullable)iconImageNames
                               titles:(NSArray<NSString *> * _Nullable)titles
                       originPosition:(CGPoint)position
                    needSeparatorLine:(BOOL)isNeedSeparatorLine
                 selectedItemComplete:(void(^)(NSInteger currentIndex))complete {
    
    [self showPopMenuWithIconImageNames:iconImageNames
                                 titles:titles
                         originPosition:position
                           heightOfItem:0
                            widthOfView:0
                  backgroundColorOfView:[UIColor whiteColor]
                      needSeparatorLine:isNeedSeparatorLine
                   selectedItemComplete:complete];
}

+ (void)showPopMenuWithIconImageNames:(NSArray<NSString *> * _Nullable)iconImageNames
                               titles:(NSArray<NSString *> * _Nullable)titles
                       originPosition:(CGPoint)position
                         heightOfItem:(CGFloat)height
                          widthOfView:(CGFloat)width
                backgroundColorOfView:(UIColor *)color
                    needSeparatorLine:(BOOL)isNeedSeparatorLine
                 selectedItemComplete:(void(^)(NSInteger currentIndex))complete {
    
    [self showPopMenuWithIconImageNames:iconImageNames
                                 titles:titles
                         originPosition:position
                           heightOfItem:height
                            widthOfView:width
                  backgroundColorOfView:color
                       titleLabelOfItem:nil
                      needSeparatorLine:isNeedSeparatorLine
                   selectedItemComplete:complete];
}

+ (void)showPopMenuWithIconImageNames:(NSArray<NSString *> * _Nullable)iconImageNames
                               titles:(NSArray<NSString *> * _Nullable)titles
                       originPosition:(CGPoint)position
                         heightOfItem:(CGFloat)height
                          widthOfView:(CGFloat)width
                backgroundColorOfView:(UIColor *)color
                     titleLabelOfItem:(UILabel * _Nullable)titleLabel
                    needSeparatorLine:(BOOL)isNeedSeparatorLine
                 selectedItemComplete:(void(^)(NSInteger currentIndex))complete {
    
    WDPopMenu *v                = [[WDPopMenu alloc] init];
    v.iconImageNames            = iconImageNames;
    v.titles                    = titles;
    v.beginPosition             = position;
    v.itemHeight                = height == 0 ? 45 : height;
    v.viewWidth                 = width == 0 ? [[UIScreen mainScreen] bounds].size.width / 2 : width;
    v.tableView.backgroundColor = color;
    v.cellColor                 = color;
    v.titleLabel                = titleLabel;
    v.selectedItemComplete      = complete;
    v.tableView.rowHeight       = v.itemHeight;
    if (isNeedSeparatorLine) {
        v.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    } else {
        v.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    }
    [v.tableView reloadData];
    [v showView];
}

- (void)backgroundTappedTarget:(id)sender {
    [self hidenView];
}

- (void)showView {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.backgroundView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [self setupViewAndArrowShape];
    [self showAnimation];
}

- (void)setupViewAndArrowShape {
    CGRect toFrame = CGRectZero;
    toFrame.size.width = self.viewWidth;
    if (self.iconImageNames.count == 0 || self.iconImageNames == nil) {
        toFrame.size.height = self.itemHeight * self.titles.count + 15;
    } else if (self.titles == nil || self.titles.count == 0) {
        toFrame.size.height = self.itemHeight * self.iconImageNames.count + 15;
    } else {
        toFrame.size.height = self.itemHeight * self.titles.count + 15;
    }
    
    WudanLayer *bbLayer = [[WudanLayer alloc] initWithSize:toFrame.size];
    
    if (self.beginPosition.x + self.viewWidth / 2 > WD_SCREEN_WIDTH) {
        toFrame.origin.x = WD_SCREEN_WIDTH - 10 - self.viewWidth;
        bbLayer.arrowDirection = ArrowDirectionTop;
        bbLayer.arrowPosition = (self.beginPosition.x - toFrame.origin.x + 15) / self.viewWidth;
        self.layer.anchorPoint = CGPointMake(bbLayer.arrowPosition, 0);
    } else if (self.beginPosition.x - self.viewWidth / 2 < 0){
        toFrame.origin.x = 10;
        bbLayer.arrowDirection = ArrowDirectionTop;
        bbLayer.arrowPosition = (self.beginPosition.x - toFrame.origin.x - 15) / self.viewWidth;
        self.layer.anchorPoint = CGPointMake(bbLayer.arrowPosition, 0);
    } else {
        toFrame.origin.x = self.beginPosition.x - self.viewWidth / 2;
        bbLayer.arrowDirection = ArrowDirectionTop;
        bbLayer.arrowPosition = (self.beginPosition.x - toFrame.origin.x) / self.viewWidth;
        self.layer.anchorPoint = CGPointMake(bbLayer.arrowPosition, 0);
    }
    
    if (self.beginPosition.y + toFrame.size.height > WD_SCREEN_HEIGHT) {
        toFrame.origin.y = self.beginPosition.y - toFrame.size.height - 15;
        bbLayer.arrowDirection = ArrowDirectionBottom;
        self.layer.anchorPoint = CGPointMake(bbLayer.arrowPosition, 1);
    } else {
        toFrame.origin.y = self.beginPosition.y + 15;
    }
    
    self.tableView.frame = CGRectZero;
    self.frame = CGRectMake(self.beginPosition.x, self.beginPosition.y, 0, 0);
    self.alpha = 0;
    self.frame = toFrame;
    if (self.beginPosition.y + toFrame.size.height > WD_SCREEN_HEIGHT) {
        self.tableView.contentInset = UIEdgeInsetsZero;
    } else {
        self.tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    }
    self.tableView.frame = CGRectMake(0, 0, toFrame.size.width, toFrame.size.height);
    
    bbLayer.cornerRadius = 8;
    bbLayer.arrowHeight = 15;
    bbLayer.arrowWidth = 30;
    bbLayer.arrowRadius = 0;
    [self.layer setMask:[bbLayer layer]];
}

- (void)showAnimation {
    self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.35 animations:^{
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        self.alpha = 1;
        self.layer.affineTransform = CGAffineTransformIdentity;
    }];
}

- (void)hidenView {
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0;
        self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.layer.affineTransform = CGAffineTransformIdentity;
        [self.backgroundView removeFromSuperview];
    }];
}

#pragma mark - UITableView DataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.titles.count > 0) {
        return self.titles.count;
    }
    
    if (self.iconImageNames.count > 0){
        return self.iconImageNames.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDPopMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WDPopMenuCell"];
    if (!cell) {
        cell = [[WDPopMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WDPopMenuCell"];
    }
    
    if (self.iconImageNames.count == 0 || self.iconImageNames == nil) {
        cell.showType = WDPopMenuTypeOnlyTitle;
        cell.titleLabel.text = self.titles[indexPath.row];
        
    } else if (self.titles == nil || self.titles.count == 0) {
        cell.showType = WDPopMenuTypeOnlyIcon;
        cell.iconImageView.image = [UIImage imageNamed:self.iconImageNames[indexPath.row]];
    } else {
        cell.showType = WDPopMenuTypeNormal;
        cell.iconImageView.image = [UIImage imageNamed:self.iconImageNames[indexPath.row]];
        cell.titleLabel.text = self.titles[indexPath.row];
    }
    if (self.titleLabel) {
        cell.titleLabel.textColor = self.titleLabel.textColor;
        cell.titleLabel.textAlignment = self.titleLabel.textAlignment;
        cell.titleLabel.font = self.titleLabel.font;
    }
    
    cell.contentView.backgroundColor = self.cellColor;
    
    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        cell.separatorInset = UIEdgeInsetsMake(0, self.bounds.size.width, 0, 0);
    } else {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return cell;
}

#pragma mark - UITableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self hidenView];
    self.selectedItemComplete(indexPath.row);
}

#pragma mark - Setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView                 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        _tableView.scrollEnabled   = NO;
    }
    return _tableView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return _backgroundView;
}
@end
