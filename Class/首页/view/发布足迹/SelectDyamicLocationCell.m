//
//  SelectDyamicLocationCell.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/28.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "SelectDyamicLocationCell.h"
#import "UIImageView+WebCache.h"

@interface  SelectDyamicLocationCell()

@property(nonatomic,strong) UILabel *nameLabel;//地点名称
@property(nonatomic,strong) UILabel *detailPlaceLabel;//详细地址

@property(nonatomic,strong) UIImageView *choseImageView;//选择

@end
@implementation SelectDyamicLocationCell
-(void)dosetup
{
    [super dosetup];
    self.contentView.backgroundColor = kColorBackgroundColor;
    
    _nameLabel=[UILabel new];
    _nameLabel.textColor=kColorMainTextColor;
    _nameLabel.font=[UIFont customFontWithSize:kFontSizeFifty];
    [_nameLabel sizeToFit];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel topToView:self.contentView withSpace:15];
    [_nameLabel leftToView:self.contentView withSpace:15];
    
    
    _detailPlaceLabel = [UILabel new];
    _detailPlaceLabel.textColor = kColorMainViceTextColor;
    _detailPlaceLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    _detailPlaceLabel.numberOfLines = 0;
    [_detailPlaceLabel sizeToFit];
    [self.contentView addSubview:_detailPlaceLabel];
    [_detailPlaceLabel topToView:_nameLabel withSpace:2];
    [_detailPlaceLabel leftToView:self.contentView withSpace:15];
    [_detailPlaceLabel bottomToView:self.contentView withSpace:10];
    [_detailPlaceLabel addWidth:kScreenWidth - 65];
    
    _choseImageView = [UIImageView new];
    _choseImageView.image = UIImageWithFileName(@"choose_right_images");
    [self.contentView addSubview:_choseImageView];
    [_choseImageView yCenterToView:self.contentView];
    [_choseImageView rightToView:self.contentView withSpace:15];
    
}
-(void)makeCellData:(NSString*)name withDetail:(NSString*)detail
{
    _nameLabel.text = name;
    _detailPlaceLabel.text = detail;
}
-(void)makeChoseCell:(NSString*)chose
{
    if ([chose isEqualToString:@"1"]) {
        _choseImageView.hidden = NO;
    }else{
        _choseImageView.hidden = YES;
    }
}

@end

