//
//  MineCenterTopView.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/24.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "MineCenterTopView.h"

@interface MineCenterTopView ()

@property (nonatomic,strong) UIButton *iconButton;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *friendsLabel;
@property (nonatomic,strong) UILabel *numberLabel;

@end

@implementation MineCenterTopView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI
{
    UIImageView *bigImageView = [UIImageView new];
    bigImageView.userInteractionEnabled = YES;
    bigImageView.image = UIImageWithFileName(@"mine_back_image");
    [self addSubview:bigImageView];
    [bigImageView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self];
    
    //    UIImage *image = [UIImage imageWithColor:[UIColor blackColor]];
    
    
    CGFloat widths = 75;
    
    _iconButton = [UIButton new];
    _iconButton.clipsToBounds = YES;
    _iconButton.layer.cornerRadius = widths/2;
    //    [_iconButton setImage:image forState:UIControlStateNormal];
    [_iconButton setBGColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_iconButton addTarget:self action:@selector(myInfoButton) forControlEvents:UIControlEventTouchUpInside];
    [bigImageView addSubview:_iconButton];
    [_iconButton leftToView:bigImageView withSpace:10];
    //    [_iconButton addCenterY:kScreenWidth/12 toView:bigImageView];
    //    [_iconButton yCenterToView:bigImageView];
    [_iconButton bottomToView:bigImageView withSpace:12];
    [_iconButton addWidth:widths];
    [_iconButton addHeight:widths];
    
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"MARK";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont customFontWithSize:kFontSizeEighTeen];
    [bigImageView addSubview:_titleLabel];
    [_titleLabel addCenterY:-14 toView:_iconButton];
    [_titleLabel leftToView:_iconButton withSpace:10];
    
    
    _friendsLabel = [UILabel new];
    _friendsLabel.text = @"好友13";
    _friendsLabel.textColor = [UIColor whiteColor];
    _friendsLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [bigImageView addSubview:_friendsLabel];
    [_friendsLabel leftToView:_iconButton withSpace:10];
    [_friendsLabel addCenterY:14 toView:_iconButton];
    
    
    _numberLabel = [UILabel new];
    _numberLabel.text = @"江湖指数23";
    _numberLabel.textColor = [UIColor whiteColor];
    _numberLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [bigImageView addSubview:_numberLabel];
    [_numberLabel leftToView:_friendsLabel withSpace:25];
    [_numberLabel yCenterToView:_friendsLabel];
    
    
    
    UIButton *grButton = [UIButton new];
    [grButton setTitle:@"个人主页" forState:UIControlStateNormal];
    [grButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    grButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeTwelve];
    [grButton addTarget:self action:@selector(mineHomeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bigImageView addSubview:grButton];
    [grButton yCenterToView:bigImageView];
    [grButton rightToView:bigImageView withSpace:35];
    
    
    UIImageView *rightImageView = [UIImageView new];
    rightImageView.image = UIImageWithFileName(@"mine_right_arrows_white");
    [bigImageView addSubview:rightImageView];
    [rightImageView yCenterToView:bigImageView];
    [rightImageView rightToView:bigImageView withSpace:15];
    
}

//点击头像跳转个人资料
-(void)myInfoButton
{
    [TargetEngine controller:nil pushToController:PushTargetPersonalInforView WithTargetId:nil];
}
-(void)mineHomeBtnClick
{
    [TargetEngine controller:nil pushToController:PushTargetMyHomePageView WithTargetId:nil];
}
@end
