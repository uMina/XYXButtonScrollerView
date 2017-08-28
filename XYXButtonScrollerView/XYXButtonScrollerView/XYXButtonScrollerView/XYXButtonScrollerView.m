//
//  XYXButtonScrollerView.m
//  XYXButtonScrollerView
//
//  Created by Teresa on 2017/8/28.
//  Copyright © 2017年 Teresa. All rights reserved.
//

#import "XYXButtonScrollerView.h"

static int buttonTagFlag = 1000;
static CGFloat leftGap = 8.0;
static CGFloat buttonHeight = 44.0;

@protocol XYXButtonScrollerViewDelegate

-(void)switchButtonDidSelectedAt:(int)index;

@end

@interface XYXButtonScrollerView()

@property(nonatomic,strong) UIView *orangeLine;
@property(nonatomic,strong) NSMutableArray<UIButton*> *buttons;
@property(nonatomic,assign) CGFloat buttonWidth;
@property(nonatomic,assign) int selectedButtonTag;
@property(nonatomic,assign) id <XYXButtonScrollerViewDelegate> theDelegate;

@end

@implementation XYXButtonScrollerView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, buttonHeight);
        [self setup];
    }
    return self;
}

-(void)setup{
    self.buttonWidth = 75.0;
    self.selectedButtonTag = buttonTagFlag;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.buttons = [NSMutableArray new];
    self.orangeLine = [UIView new];
}

-(void)setTitles:(NSArray<NSString *> *)titles{
    
    for (UIView *item in self.subviews) {
        [item removeFromSuperview];
    }
    
    if ( titles == nil || [titles count] <= 0) {
        return ;
    }
    
    self.contentSize = CGSizeMake(self.buttonWidth * titles.count + leftGap*2, self.frame.size.height);
    
    for (int idx = 0; idx < titles.count; idx++) {
        UIButton *btn = [self createButton];
        btn.frame = CGRectMake(idx*self.buttonWidth+leftGap, 0, self.buttonWidth, self.frame.size.height);
        btn.tag = idx + buttonTagFlag;
        [btn setTitle:titles[idx] forState:UIControlStateNormal];
        [self addSubview:btn];
        [self.buttons addObject:btn];
        
        if (idx == 0) {
            btn.selected = YES;
        }
    }
    [self configureUnderLine];
}

-(UIButton*)createButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

-(void)configureUnderLine{
    CGRect titleLabelFrame = CGRectZero;
    [[self.buttons firstObject]layoutSubviews];
    if ([self.buttons firstObject].titleLabel != nil) {
        titleLabelFrame = [self.buttons firstObject].titleLabel.frame;
    }
    self.orangeLine.frame = CGRectMake(titleLabelFrame.origin.x+leftGap, titleLabelFrame.origin.y+titleLabelFrame.size.height+2, titleLabelFrame.size.width, 1.5);
    self.orangeLine.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.orangeLine];
}

-(void)buttonClick:(UIButton*)sender{
   
    for (UIButton *item in self.buttons) {
        if (item.tag == sender.tag) {
            item.selected = YES;
        }else{
            item.selected = NO;
        }
    }
    
    if (self.selectedButtonTag == sender.tag) {
        return;
    }
    
    int tag = (int)sender.tag - buttonTagFlag;
    if (self.theDelegate) {
        [self.theDelegate switchButtonDidSelectedAt:tag];
    }
    
    UILabel *titleLabel = sender.titleLabel;
    CGFloat animationDuration = 0.1 + labs(sender.tag - self.selectedButtonTag) * 0.05;
    [UIView animateWithDuration:animationDuration animations:^{
        self.orangeLine.frame = CGRectMake(titleLabel.frame.origin.x + tag*sender.frame.size.width + leftGap, self.orangeLine.frame.origin.y, titleLabel.frame.size.width, self.orangeLine.frame.size.height);
    }];
    
    self.selectedButtonTag = (int)sender.tag;
}

@end
