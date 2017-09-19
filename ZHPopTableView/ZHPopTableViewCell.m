//
//  ZHPopTableViewCell.m
//  ZHPopTableViewDemo
//
//  Created by Zeaho on 2017/9/19.
//  Copyright © 2017年 Zeaho. All rights reserved.
//

#import "ZHPopTableViewCell.h"

@interface ZHPopTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subtitleLabel;

@end

@implementation ZHPopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _createSubviews];
        [self _configurateSubviewsDefault];
        [self _installConstraints];
    }
    return self;
}


- (void)_createSubviews {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [[self contentView] addSubview:[self titleLabel]];
    
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [[self contentView] addSubview:[self subtitleLabel]];
}

- (void)_configurateSubviewsDefault {
    
    self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = @"默认舞单";
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.subtitleLabel.textColor = [UIColor blackColor];
    self.subtitleLabel.font = [UIFont systemFontOfSize:12];
    self.subtitleLabel.text = @"公开·1个内容";
}

- (void)_installConstraints {
    
    [[self titleLabel] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self).offset(UIEdgeInsetsMake(8, 15, 0, 8));
        make.height.mas_equalTo(15);
    }];
    
    [[self subtitleLabel] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self).offset(UIEdgeInsetsMake(0, 15, 8, 8));
        make.height.mas_equalTo(15);
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
