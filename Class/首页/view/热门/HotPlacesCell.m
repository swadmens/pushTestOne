//
//  HotPlacesCell.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/6.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "HotPlacesCell.h"

@interface HotPlacesCell ()

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *iconLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *numLabel;

@end

@implementation HotPlacesCell

- (void)dosetup {
    [super dosetup];
    // Initialization code

    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView leftToView:self.contentView withSpace:18];
    [_iconImageView topToView:self.contentView withSpace:8];
    [_iconImageView bottomToView:self.contentView withSpace:8];
    [_iconImageView addWidth:25];
    [_iconImageView addHeight:20];
    
    
    _iconLabel = [UILabel new];
    _iconLabel.hidden = YES;
    _iconLabel.text = @"4";
    _iconLabel.textColor = kColorMainTextColor;
    _iconLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [self.contentView addSubview:_iconLabel];
    [_iconLabel leftToView:self.contentView withSpace:25];
    [_iconLabel topToView:self.contentView withSpace:12];
    [_iconLabel bottomToView:self.contentView withSpace:12];
    

    _nameLabel = [UILabel new];
    _nameLabel.text = @"热门人选";
    _nameLabel.textColor = kColorMainTextColor;
    _nameLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel yCenterToView:_iconImageView];
    [_nameLabel leftToView:self.contentView withSpace:60];
    
    _numLabel = [UILabel new];
    _numLabel.text = @"9999";
    _numLabel.textColor = kColorMainTextColor;
    _numLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [self.contentView addSubview:_numLabel];
    [_numLabel yCenterToView:_nameLabel];
    [_numLabel rightToView:self.contentView withSpace:15];
    
    
}
-(void)makeCellData:(NSInteger)index
{
    _iconImageView.hidden = index > 2;
    _iconLabel.hidden = index < 3;
    
    if (index == 0) {
        _iconImageView.image = UIImageWithFileName(@"index_first_image");
    }else if (index == 1){
        _iconImageView.image = UIImageWithFileName(@"index_second_image");
    }else if (index == 2){
        _iconImageView.image = UIImageWithFileName(@"index_three_image");
    }else{
        _iconLabel.text = [NSString stringWithFormat:@"%ld",index+1];
    }
    
}

@end
