//
//  ZHPopTableView.m
//  ZHPopTableViewDemo
//
//  Created by Zeaho on 2017/9/19.
//  Copyright © 2017年 Zeaho. All rights reserved.
//

#import "ZHPopTableView.h"
#import "ZHPopTableViewCell.h"

const CGFloat ZHPopTableViewHeight = 292.5f;
const CGFloat ZHPopViewAnimatinoDuration = .3f;

@interface ZHPopTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *contenView;

@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) UILabel *sectionTitileLabel;
@property (nonatomic, strong) UIButton *sectionIconButton;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZHPopTableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self _createSubviews];
        [self _configurateSubviewsDefault];
        [self _installConstraints];
    }
    return self;
}


- (void)_createSubviews {
    
    self.contenView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:[self contenView]];
    
    self.sectionView = [[UIView alloc] initWithFrame:CGRectZero];
    [[self contenView] addSubview:[self sectionView]];
    
    self.sectionTitileLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [[self sectionView] addSubview:[self sectionTitileLabel]];
    
    self.sectionIconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [[self sectionView] addSubview:[self sectionIconButton]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [[self contenView] addSubview:[self tableView]];
}

- (void)_configurateSubviewsDefault {
    
    UITapGestureRecognizer *tapBackgroundView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAnimated:)];
    [self addGestureRecognizer:tapBackgroundView];
    
    self.contenView.backgroundColor = [UIColor whiteColor];
    
    self.sectionView.backgroundColor = [UIColor whiteColor];
    
    self.sectionTitileLabel.text = @"选择舞单";
    self.sectionTitileLabel.font = [UIFont systemFontOfSize:14];
    self.sectionTitileLabel.textColor = [UIColor blackColor];
    
    [[self sectionIconButton] setImage:[UIImage imageNamed:@"文件夹(3)"] forState:UIControlStateNormal];
    [[self sectionIconButton] setTitle:@"新建歌单" forState:UIControlStateNormal];
    self.sectionIconButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.sectionIconButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [[self sectionIconButton] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.sectionIconButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [[self sectionIconButton] addTarget:self action:@selector(didClikedAddMusicListButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
    self.tableView.tableFooterView = [UIView new];
    [[self tableView] registerClass:[ZHPopTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ZHPopTableViewCell class])];
}

- (void)_installConstraints {
    
    [[self contenView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self).offset(UIEdgeInsetsMake(0, 0, 0, 0));
        make.bottom.mas_equalTo(self).offset(ZHPopTableViewHeight);
        make.height.mas_equalTo(ZHPopTableViewHeight);
    }];
    
    [[self sectionView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contenView);
        make.height.mas_equalTo(55);
    }];
    
    [[self sectionIconButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(self.sectionView).offset(UIEdgeInsetsMake(0, 0, 15, 15));
        make.width.mas_equalTo(60);
    }];
    
    [[self sectionTitileLabel] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.sectionView).offset(UIEdgeInsetsMake(10, 15, 0, 0));
        make.right.mas_equalTo(self.sectionIconButton.mas_left);
        make.height.mas_equalTo(20);
    }];
    
    [[self tableView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sectionView.mas_bottom);
        make.bottom.left.right.mas_equalTo(self.contenView);
    }];
}

#pragma mark - accessor
- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
    }
    self.sectionTitileLabel.text = title;
}

- (void)setIcon:(UIImage *)icon {
    if (_icon != icon) {
        _icon = icon;
    }
    [[self sectionIconButton] setImage:icon forState:UIControlStateNormal];
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
    }
    [[self tableView] reloadData];
}

- (BOOL)display{
    
    return [self superview] && self.contenView.frame.origin.y + self.frame.size.height == 0.f;
}

#pragma mark - publuc
- (void)showInView:(UIView *)inView {
    
    [inView addSubview:self];
    self.frame = [inView bounds];
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:ZHPopViewAnimatinoDuration animations:^{
        [[self contenView] mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self);
        }];
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1f];
        [self layoutIfNeeded];
    }];
}

- (void)dismissAnimated:(BOOL)animated {
    
    [self dismissAnimated:animated completion:nil];
}

- (void)dismissAnimated:(BOOL)animated completion:(void (^)())completion {
    
    [self layoutIfNeeded];
    void (^transform)() = ^{
        [[self contenView] mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self).offset(ZHPopTableViewHeight);
        }];
        self.backgroundColor = [UIColor clearColor];
        [self layoutIfNeeded];
    };
    
    void (^innerCompletion)() = ^{
        [self removeFromSuperview];
        
        if (completion) {
            completion();
        }
    };
    if (animated) {
        [UIView animateWithDuration:ZHPopViewAnimatinoDuration animations:transform completion:^(BOOL finished) {
            innerCompletion();
        }];
    } else {
        transform();
        innerCompletion();
    }
}


#pragma mark - action
- (void)didClikedAddMusicListButton:(UIButton *)sender {
    if ([[self delegate] respondsToSelector:@selector(createMusicPlaylist)]) {
        [[self delegate] createMusicPlaylist];
    }
}

#pragma mark - table view delegate && datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHPopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZHPopTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[ZHPopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ZHPopTableViewCell class])];
    }
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
