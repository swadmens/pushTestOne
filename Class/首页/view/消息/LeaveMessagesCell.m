//
//  LeaveMessagesCell.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/7.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "LeaveMessagesCell.h"

@interface LeaveMessagesCell ()

@property (nonatomic,strong) UIImageView *titleImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *dateLabel;

@property (nonatomic,strong) UIImageView *rightImageView;


@end
@implementation LeaveMessagesCell

- (void)dosetup {
    [super dosetup];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _titleImageView = [UIImageView new];
    _titleImageView.clipsToBounds = YES;
    _titleImageView.layer.cornerRadius = 22.5;
    _titleImageView.image = [UIImage imageWithColor:[UIColor greenColor]];
    [self.contentView addSubview:_titleImageView];
    [_titleImageView leftToView:self.contentView withSpace:15];
    [_titleImageView topToView:self.contentView withSpace:10];
    [_titleImageView addWidth:45];
    [_titleImageView addHeight:45];
    
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"好友";
    _titleLabel.textColor = kColorMainTextColor;
    _titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel addCenterY:-10 toView:_titleImageView];
    [_titleLabel leftToView:_titleImageView withSpace:10];
    
    
    _detailLabel = [UILabel new];
    _detailLabel.text = @"啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊";
    _detailLabel.textColor = kColorSecondTextColor;
    _detailLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
    [self.contentView addSubview:_detailLabel];
    [_detailLabel addCenterY:10 toView:_titleImageView];
    [_detailLabel leftToView:_titleImageView withSpace:10];
    [_detailLabel addWidth:kScreenWidth - 155];
    
    
    
    _dateLabel = [UILabel new];
    _dateLabel.text = @"回复了你的评论 11-11";
    _dateLabel.textColor = kColorMainViceTextColor;
    _dateLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [self.contentView addSubview:_dateLabel];
    [_dateLabel topToView:_detailLabel withSpace:4];
    [_dateLabel leftToView:_titleImageView withSpace:10];

    
    
    _rightImageView = [UIImageView new];
    _rightImageView.clipsToBounds = YES;
    _rightImageView.layer.cornerRadius = 5;
    _rightImageView.image = [UIImage imageWithColor:[UIColor greenColor]];
    [self.contentView addSubview:_rightImageView];
    [_rightImageView rightToView:self.contentView withSpace:12];
    [_rightImageView topToView:self.contentView withSpace:10];
    [_rightImageView bottomToView:self.contentView withSpace:10];
    [_rightImageView addWidth:62];
    [_rightImageView addHeight:62];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
