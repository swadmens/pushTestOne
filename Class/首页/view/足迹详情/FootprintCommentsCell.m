//
//  FootprintCommentsCell.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/20.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "FootprintCommentsCell.h"
#import <UIImageView+YYWebImage.h>


@interface FootprintCommentsCell ()

@property (nonatomic,strong) UILabel *detailLabel;//正文


@end

@implementation FootprintCommentsCell

- (void)dosetup {
    [super dosetup];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _detailLabel = [UILabel new];
    _detailLabel.text = @"巽寮湾气候温和，年平均气温21.7℃，即使在冬季，水温也不是特别低，一年四季都很适合游玩。";
    _detailLabel.textColor = kColorMainTextColor;
    _detailLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
    _detailLabel.numberOfLines = 0;
    [self.contentView addSubview:_detailLabel];
    [_detailLabel leftToView:self.contentView withSpace:50];
    [_detailLabel topToView:self.contentView withSpace:3];
    [_detailLabel bottomToView:self.contentView withSpace:10];
    [_detailLabel addWidth:kScreenWidth - 80];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
