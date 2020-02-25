//
//  LikeMessagesCell.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/7.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "LikeMessagesCell.h"

@interface LikeMessagesCell ()

@property (nonatomic,strong) UIImageView *titleImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *dateLabel;

@end

@implementation LikeMessagesCell

- (void)dosetup {
    [super dosetup];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _titleImageView = [UIImageView new];
    _titleImageView.clipsToBounds = YES;
    _titleImageView.layer.cornerRadius = 22.5;
    _titleImageView.image = [UIImage imageWithColor:[UIColor blackColor]];
    [self.contentView addSubview:_titleImageView];
    [_titleImageView leftToView:self.contentView withSpace:15];
    [_titleImageView topToView:self.contentView withSpace:10];
    [_titleImageView bottomToView:self.contentView withSpace:10];
    [_titleImageView addWidth:45];
    [_titleImageView addHeight:45];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"好友赞了你的足迹";
    _titleLabel.textColor = kColorMainTextColor;
    _titleLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel addCenterY:-10 toView:_titleImageView];
    [_titleLabel leftToView:_titleImageView withSpace:10];
    
    
    
    UIImageView *likesImage = [UIImageView new];
    likesImage.image = UIImageWithFileName(@"msg_click_likes_image");
    [self.contentView addSubview:likesImage];
    [likesImage addCenterY:10 toView:_titleImageView];
    [likesImage leftToView:_titleImageView withSpace:10];
    
    
    _detailLabel = [UILabel new];
    _detailLabel.text = @"+1";
    _detailLabel.textColor = kColorMainViceTextColor;
    _detailLabel.font = [UIFont customFontWithSize:kFontSizeTwelve];
    [self.contentView addSubview:_detailLabel];
    [_detailLabel yCenterToView:likesImage];
    [_detailLabel leftToView:likesImage withSpace:5];
    
    
    
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
