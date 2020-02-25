//
//  FriendsFootprintHeaderView.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/29.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "FriendsFootprintHeaderView.h"

@interface FriendsFootprintHeaderView ()

@property (nonatomic,strong) UIButton *iconButton;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *friendsLabel;
@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,strong) UILabel *contentLabel;

@end

@implementation FriendsFootprintHeaderView

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
    
    _iconButton = [UIButton new];
    _iconButton.clipsToBounds = YES;
    _iconButton.layer.cornerRadius = 31;
    //    [_iconButton setImage:image forState:UIControlStateNormal];
    [_iconButton setBGColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_iconButton addTarget:self action:@selector(myInfoButton) forControlEvents:UIControlEventTouchUpInside];
    [bigImageView addSubview:_iconButton];
    [_iconButton leftToView:bigImageView withSpace:10];
    //    [_iconButton addCenterY:kScreenWidth/12 toView:bigImageView];
    //    [_iconButton yCenterToView:bigImageView];
    [_iconButton bottomToView:bigImageView withSpace:44];
    [_iconButton addWidth:62];
    [_iconButton addHeight:62];
    
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"MARK";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont customFontWithSize:kFontSizeEighTeen];
    [bigImageView addSubview:_titleLabel];
    [_titleLabel addCenterY:-12 toView:_iconButton];
    [_titleLabel leftToView:_iconButton withSpace:10];
    
    
    _friendsLabel = [UILabel new];
    _friendsLabel.text = @"好友13";
    _friendsLabel.textColor = [UIColor whiteColor];
    _friendsLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [bigImageView addSubview:_friendsLabel];
    [_friendsLabel leftToView:_iconButton withSpace:10];
    [_friendsLabel addCenterY:12 toView:_iconButton];
    
    
    _numberLabel = [UILabel new];
    _numberLabel.text = @"江湖指数23";
    _numberLabel.textColor = [UIColor whiteColor];
    _numberLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [bigImageView addSubview:_numberLabel];
    [_numberLabel leftToView:_friendsLabel withSpace:25];
    [_numberLabel yCenterToView:_friendsLabel];
    
    
    UILabel *lineLabel = [UILabel new];
    lineLabel.backgroundColor = [UIColor whiteColor];
    [bigImageView addSubview:lineLabel];
    [lineLabel leftToView:_iconButton withSpace:10];
    [lineLabel topToView:_friendsLabel withSpace:12];
    [lineLabel addHeight:1];
    [lineLabel addWidth:kScreenWidth/2];
    
    
    _contentLabel = [UILabel new];
    _contentLabel.text = @"简介：哈哈哈哈哈哈哈哈哈哈哈哈哈";
    _contentLabel.textColor = [UIColor whiteColor];
    _contentLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [bigImageView addSubview:_contentLabel];
    [_contentLabel leftToView:_iconButton withSpace:10];
    [_contentLabel topToView:lineLabel withSpace:10];
    
    
    
    
}

//点击头像跳转个人资料
-(void)myInfoButton
{
    [TargetEngine controller:nil pushToController:PushTargetPersonalInforView WithTargetId:nil];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

