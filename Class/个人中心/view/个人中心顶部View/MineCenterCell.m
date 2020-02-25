//
//  MineCenterCell.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/24.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "MineCenterCell.h"


@interface MineCenterCell ()


@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *titleLabel;


@end


@implementation MineCenterCell

- (void)dosetup {
    [super dosetup];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    
    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView topToView:self.contentView withSpace:18];
    [_iconImageView bottomToView:self.contentView withSpace:18];
    [_iconImageView leftToView:self.contentView withSpace:18];
    
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = kColorMainTextColor;
    _titleLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel yCenterToView:self.contentView];
    [_titleLabel leftToView:_iconImageView withSpace:15];
    
    
    UIImageView *rightImageView = [UIImageView new];
    rightImageView.image = UIImageWithFileName(@"mine_right_arrows");
    [self.contentView addSubview:rightImageView];
    [rightImageView yCenterToView:self.contentView];
    [rightImageView rightToView:self.contentView withSpace:15];
    
    
}
-(void)makeCellData:(NSString*)icon withTitle:(NSString*)title
{
    _iconImageView.image = UIImageWithFileName(icon);
    _titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
