//
//  SystemMessagesCell.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/7.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "SystemMessagesCell.h"

@interface SystemMessagesCell ()

@property (nonatomic,strong) UIImageView *titleImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *dateLabel;

@end


@implementation SystemMessagesCell

- (void)dosetup {
    [super dosetup];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _titleImageView = [UIImageView new];
//    _titleImageView.clipsToBounds = YES;
//    _titleImageView.layer.cornerRadius = 22.5;
    _titleImageView.image = UIImageWithFileName(@"msg_icon_images");
    [self.contentView addSubview:_titleImageView];
    [_titleImageView leftToView:self.contentView withSpace:15];
    [_titleImageView topToView:self.contentView withSpace:10];
    [_titleImageView bottomToView:self.contentView withSpace:10];
//    [_titleImageView addWidth:45];
//    [_titleImageView addHeight:45];
    
    
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"系统消息";
    _titleLabel.textColor = kColorMainTextColor;
    _titleLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel addCenterY:-10 toView:_titleImageView];
    [_titleLabel leftToView:_titleImageView withSpace:10];
    
    
    _detailLabel = [UILabel new];
    _detailLabel.text = @"参与官方活动";
    _detailLabel.textColor = kColorMainViceTextColor;
    _detailLabel.font = [UIFont customFontWithSize:kFontSizeTwelve];
    [self.contentView addSubview:_detailLabel];
    [_detailLabel addCenterY:10 toView:_titleImageView];
    [_detailLabel leftToView:_titleImageView withSpace:10];
    
    
    
    _dateLabel = [UILabel new];
    _dateLabel.text = @"12-22";
    _dateLabel.textColor = kColorMainViceTextColor;
    _dateLabel.font = [UIFont customFontWithSize:kFontSizeTen];
    [self.contentView addSubview:_dateLabel];
    [_dateLabel yCenterToView:_titleLabel];
    [_dateLabel rightToView:self.contentView withSpace:15];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
