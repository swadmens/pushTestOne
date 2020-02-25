//
//  MyFriendsCell.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/7.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "MyFriendsCell.h"

@interface MyFriendsCell ()

@property (nonatomic,strong) UIImageView *titleImageView;
@property (nonatomic,strong) UILabel *titleLabel;

@end


@implementation MyFriendsCell

- (void)dosetup {
    [super dosetup];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _titleImageView = [UIImageView new];
    _titleImageView.clipsToBounds = YES;
    _titleImageView.layer.cornerRadius = 22.5;
    _titleImageView.image = [UIImage imageWithColor:[UIColor blueColor]];
    [self.contentView addSubview:_titleImageView];
    [_titleImageView leftToView:self.contentView withSpace:15];
    [_titleImageView topToView:self.contentView withSpace:12];
    [_titleImageView bottomToView:self.contentView withSpace:12];
    [_titleImageView addWidth:45];
    [_titleImageView addHeight:45];
    
    
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"匆匆而过";
    _titleLabel.textColor = kColorMainTextColor;
    _titleLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel yCenterToView:_titleImageView];
    [_titleLabel leftToView:_titleImageView withSpace:10];
    
    

}


@end
