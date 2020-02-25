//
//  ApplyMessagesCell.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/7.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "ApplyMessagesCell.h"

@interface ApplyMessagesCell ()

@property (nonatomic,strong) UIImageView *titleImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *dateLabel;

@property (nonatomic,strong) UIButton *agreeBtn;
@property (nonatomic,strong) UIButton *refuseBtn;


@end
@implementation ApplyMessagesCell

- (void)dosetup {
    [super dosetup];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _titleImageView = [UIImageView new];
    _titleImageView.clipsToBounds = YES;
    _titleImageView.layer.cornerRadius = 22.5;
    _titleImageView.image = [UIImage imageWithColor:[UIColor redColor]];
    [self.contentView addSubview:_titleImageView];
    [_titleImageView leftToView:self.contentView withSpace:15];
    [_titleImageView topToView:self.contentView withSpace:10];
    [_titleImageView bottomToView:self.contentView withSpace:10];
    [_titleImageView addWidth:45];
    [_titleImageView addHeight:45];
    
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"好友";
    _titleLabel.textColor = kColorMainTextColor;
    _titleLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel addCenterY:-10 toView:_titleImageView];
    [_titleLabel leftToView:_titleImageView withSpace:10];
    
    
    _detailLabel = [UILabel new];
    _detailLabel.text = @"请求添加为好友";
    _detailLabel.textColor = kColorMainViceTextColor;
    _detailLabel.font = [UIFont customFontWithSize:kFontSizeTwelve];
    [self.contentView addSubview:_detailLabel];
    [_detailLabel addCenterY:10 toView:_titleImageView];
    [_detailLabel leftToView:_titleImageView withSpace:10];
    
    
    
    _dateLabel = [UILabel new];
    _dateLabel.text = @"已同意";
    _dateLabel.hidden = YES;
    _dateLabel.textColor = kColorMainViceTextColor;
    _dateLabel.font = [UIFont customFontWithSize:kFontSizeTen];
    [self.contentView addSubview:_dateLabel];
    [_dateLabel yCenterToView:_titleLabel];
    [_dateLabel rightToView:self.contentView withSpace:15];
    
    
    
    
    _refuseBtn = [UIButton new];
    _refuseBtn.clipsToBounds = YES;
    _refuseBtn.layer.cornerRadius = 2;
    _refuseBtn.layer.borderWidth = 1;
    _refuseBtn.layer.borderColor = kColorLineColor.CGColor;
    [_refuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    [_refuseBtn setTitleColor:kColorSecondTextColor forState:UIControlStateNormal];
    _refuseBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [self.contentView addSubview:_refuseBtn];
    [_refuseBtn yCenterToView:self.contentView];
    [_refuseBtn rightToView:self.contentView withSpace:13];
    [_refuseBtn addWidth:55];
    [_refuseBtn addHeight:28];
    
    
    
    
    _agreeBtn = [UIButton new];
    _agreeBtn.clipsToBounds = YES;
    _agreeBtn.layer.cornerRadius = 2;
    [_agreeBtn setBGColor:kColorMainColor forState:UIControlStateNormal];
    [_agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    _agreeBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [self.contentView addSubview:_agreeBtn];
    [_agreeBtn yCenterToView:self.contentView];
    [_agreeBtn rightToView:_refuseBtn withSpace:6];
    [_agreeBtn addWidth:55];
    [_agreeBtn addHeight:28];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
