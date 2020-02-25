//
//  MineTopView.m
//  TaoChongYouPin
//
//  Created by icash on 16/8/19.
//  Copyright © 2016年 FusionHK. All rights reserved.
//

#import "MineTopView.h"
#import "UIButton+WebCache.h"

@interface MineTopView ()

/// 是否登录，状态由监听控制
@property (nonatomic, assign) BOOL isLoginIn;

@property (weak, nonatomic) IBOutlet UIView *topView;
/// 导航
@property (weak, nonatomic) IBOutlet UIView *navView;
/// 头像按钮
@property (weak, nonatomic) IBOutlet UIImageView *headerBGImageView;
@property (weak, nonatomic) IBOutlet UIButton *headerButton;
@property (nonatomic, strong) UIImageView *vipImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_header_width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_header_left;
#pragma mark - 右侧信息
@property (weak, nonatomic) IBOutlet UIView *userRightView;
// 昵称
@property (nonatomic, strong) UIButton *nickButton;
//用户ID
@property (nonatomic, strong) UILabel *nickId;
//我的宠物数量
@property (nonatomic, strong) UILabel *petNumLabel;
@property (nonatomic, strong) NSString *pet_number;


// VIP
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_vip_height;


// 认证
@property (weak, nonatomic) IBOutlet UIView *RZContentView;

// 未登录
@property (nonatomic, strong) UIButton *loginButton;

//

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_image_bottom;

/// 补货
@property (weak, nonatomic) IBOutlet UIView *buhuoView;

/// 我的订单等
@property (weak, nonatomic) IBOutlet UIView *orderView;
/// 全部订单
@property (nonatomic, strong) UIView *orderTopView;
/// 订单列表容器
@property (nonatomic, strong) UIView *orderContentView;


@property (nonatomic, strong) UIView *myCountTopView;

/// 其它列表容器
@property (nonatomic, strong) UIView *collectContentView;

@property (nonatomic, strong) NSArray *orderViewsList;

/// 浏览记录等
@property (weak, nonatomic) IBOutlet UIView *recordView;
@property (nonatomic, strong) NSArray *recordViewsList;


@end

@implementation MineTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self dosetup];
}
- (void)dosetup
{
    self.backgroundColor = [UIColor whiteColor];
//    self.BGImageView.image = UIImageWithFileName(@"mine_top_backimage");
    self.BGImageView.image = [UIImage imageWithColor:UIColorClearColor];

    self.BGImageView.contentMode = UIViewContentModeScaleAspectFill;
    //
    self.buhuoView.backgroundColor = kColorBackgroundColor;
    
    //
    [self setupOrderViews];
    
    //
    self.recordView.backgroundColor = [UIColor whiteColor];
    
  
    /// 头像
    [self setupUsersView];
    
    //
    @weakify(self);
    /// 登录变化监听
    RACSignal *loginSignal = [RACObserve(_kUserModel, isLogined) map:^id(NSNumber *subValue) {
        return @([subValue boolValue]);
    }];
    RAC(self,isLoginIn) = loginSignal;
    // 这个是返回的isLoginIn的非,因为hidden跟isLoginIn是相反的
    RACSignal *statusSignal = [RACObserve(self, isLoginIn) map:^id(NSNumber *subValue) {
        return @(![subValue boolValue]);
    }];
    
    RAC(self.nickButton,hidden) = statusSignal;
    RAC(self.nickId,hidden) = statusSignal;

    RAC(self.loginButton,hidden) = loginSignal; // 这个是登录时隐藏
    
    // 信息监听
    // 昵称
    [RACObserve(_kUserModel.userInfo,user_name ) subscribeNext:^(id x) {
        @strongify(self);
        NSString *nickname = _kUserModel.userInfo.user_name;
//        nickname = @"长啊长啊长啊长啊长啊长啊长啊长啊长啊长啊长啊长啊长啊长啊";
        [self.nickButton setTitle:nickname forState:UIControlStateNormal];
    }];
    
    // ID监听
    [RACObserve(_kUserModel.userInfo,user_code ) subscribeNext:^(id x) {
        @strongify(self);
        NSString *user_code = _kUserModel.userInfo.user_code;
        self.nickId.text =[NSString stringWithFormat:@"%@",user_code];
    }];
    
    
    /// 头像监听
    [RACObserve(_kUserModel.userInfo, user_avatar) subscribeNext:^(id x) {
        @strongify(self);
        NSString *url = [NSString stringWithFormat:@"%@",x];
        [self.headerButton sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:UIImageWithFileName(@"icon_header")];
    }];
    
#pragma mark - 点击监听
    // 头像点击
    [[self.headerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self goMyAcount];
    }];
    /// 昵称点击
    [[self.nickButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self goMyAcount];
    }];
    
    /// 3.0直接隐藏
    self.RZContentView.hidden = YES;
}
/// 头像和昵称点击跳转帐户
- (void)goMyAcount
{
    if ([_kUserModel checkLoginStatus] == NO) {
        return ;
    }
    /// 跳转个人资料
//    [TargetEngine controller:nil pushToController:PushTargetThePersonalData WithTargetId:nil];
}
- (CGFloat)getHeight
{
    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"MineTopView" owner:self options:nil].firstObject;
    CGFloat height = view.bounds.size.height;
    height -= self.constraint_vip_height.constant;
    return height;
}
/// 用户信息
- (void)setupUsersView
{
    
    // 头像
    [self.headerButton setTitle:@"" forState:UIControlStateNormal];
    [self.headerButton setImage:UIImageWithFileName(@"icon_header") forState:UIControlStateNormal];
    self.headerButton.clipsToBounds = YES;
    self.headerButton.imageView.clipsToBounds = YES;
    self.headerButton.layer.cornerRadius = self.constraint_header_width.constant/2.0;
    self.headerButton.layer.borderWidth = 4.0;
    self.headerButton.layer.borderColor = [UIColor clearColor].CGColor;
    
    // 右侧用户信息
    [self setupRightUserView];
}
/// 右侧用户信息
- (void)setupRightUserView
{
    // 昵称
    self.nickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.userRightView addSubview:self.nickButton];
    [self.nickButton leftToView:self.userRightView withSpace:0];
    [self.nickButton topToView:self.userRightView withSpace:0];
    [self.nickButton bottomToView:self.userRightView withSpace:0];
    [self.nickButton rightToView:self.userRightView withSpace:0];
    [self.nickButton setTitleColor:kColorMainTextColor forState:UIControlStateNormal];
    self.nickButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeNineTeen];
    self.nickButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.nickButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.nickButton lgx_remakeConstraints:^(LGXLayoutMaker *make) {
        make.bottomEdge.lgx_equalTo(self.headerButton.lgx_yCenter).lgx_floatOffset(4);
        make.leftEdge.lgx_equalTo(self.headerButton.lgx_rightEdge).lgx_floatOffset(6);
    }];
    
    //ID
    self.nickId=[UILabel new];
    self.nickId.textColor = kColorSecondTextColor;
    self.nickId.font=[UIFont customFontWithSize:kFontSizeThirteen];
    [self.nickId sizeToFit];
    [self.userRightView addSubview:self.nickId];
    [self.nickId lgx_remakeConstraints:^(LGXLayoutMaker *make) {
        make.topEdge.lgx_equalTo(self.nickButton.lgx_bottomEdge);
        make.leftEdge.lgx_equalTo(self.nickButton.lgx_leftEdge);
    }];
    
    
    //箭头
    UIImage *jtImage = UIImageWithFileName(@"chevron-right-12");
    UIButton *arButton = [UIButton new];
    [arButton setImage:jtImage forState:UIControlStateNormal];
    [arButton addTarget:self action:@selector(qrCodeClock) forControlEvents:UIControlEventTouchUpInside];
    [self.userRightView addSubview:arButton];
    [arButton yCenterToView:self.headerButton];
    [arButton rightToView:self.userRightView];
    [arButton addWidth:jtImage.size.width - 2];
    [arButton addHeight:14];
    
    //二维码
    UIButton *qrButton = [UIButton new];
    [qrButton setImage:UIImageWithFileName(@"mine_qrcode") forState:UIControlStateNormal];
    [qrButton addTarget:self action:@selector(qrCodeClock) forControlEvents:UIControlEventTouchUpInside];
    [self.userRightView addSubview:qrButton];
    [qrButton yCenterToView:self.headerButton];
    [qrButton rightToView:arButton];
    [qrButton addWidth:40];
    [qrButton addHeight:40];
    
    
    // 未登录
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.userRightView addSubview:self.loginButton];
    [self.loginButton leftToView:self.userRightView withSpace:0];
    [self.loginButton addHeight:0 withPriority:249.0];
    [self.loginButton addWidth:0 withPriority:249.0];
    [self.loginButton addCenterY:-4 toView:self.userRightView];
    
    self.loginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:kColorYellowTextColor forState:UIControlStateHighlighted];
    self.loginButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeNineTeen];
    [self.loginButton setTitle:@"登录/注册" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(action_toLogin:) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.hidden = YES;
}
- (void)action_toLogin:(id)sender
{
    [_kUserModel checkLoginStatus];
}
- (void)action_renzheng:(id)sender
{
    if ([_kUserModel checkLoginStatus]) {
//        [TargetEngine controller:nil pushToController:PushTargetRenzhengOne WithTargetId:nil];
    }
}
/// 我的宠物
- (void)setupOrderViews
{

    CGFloat totalHeigt = 135;
    
    self.orderView.backgroundColor = kColorBackSecondColor;
    [self.orderView addHeight:totalHeigt];
    [self.orderView lgx_remakeConstraints:^(LGXLayoutMaker *make) {
        make.bottomEdge.lgx_equalTo(self.lgx_bottomEdge);
    }];
    //
    self.orderTopView = [[UIView alloc] init];
    self.orderTopView.backgroundColor = [UIColor whiteColor];
    [self.orderView addSubview:self.orderTopView];
    [self.orderTopView fillToSuperViewBy:LGXEdgeInsetsMake(@0, @0, nil, @0)];
    [self.orderTopView setupHeight:40];
    [self.orderTopView addTopLineByColor:MINE_LINE_COLOR];
    
    
    self.petNumLabel = [[UILabel alloc] init];
    self.petNumLabel.text = @"头像";
    self.petNumLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    self.petNumLabel.textColor = kColorMainTextColor;
    [self.orderTopView addSubview:self.petNumLabel];
    [self.petNumLabel yCenterToView:self.orderTopView];
    [self.petNumLabel leftToView:self.orderTopView withSpace:15];
    
    
    UIButton *button = [UIButton new];
    [button setTitle:@"添加" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [button setTitleColor:kColorMainColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addPetButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.orderTopView addSubview:button];
    [button yCenterToView:self.petNumLabel];
    [button rightToView:self.orderTopView withSpace:15];
    
    
    //
    self.orderContentView = [[UIView alloc] init];
    self.orderContentView.backgroundColor = [UIColor whiteColor];
    [self.orderView addSubview:self.orderContentView];
    [self.orderContentView fillToSuperViewBy:LGXEdgeInsetsMake(@40, @0, nil, @0)];
    [self.orderContentView addHeight:95];
    
    
//    self.collectionView.backgroundColor = UIColorFromRGB(0xffffff, 0);
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//    self.collectionView.collectionViewLayout = self.flowLayout;
//    self.collectionView.showsVerticalScrollIndicator = NO;
//    self.collectionView.showsHorizontalScrollIndicator = NO;
//    [self.orderContentView addSubview:self.collectionView];
//    [self.collectionView registerClass:[MinePetCollectionViewCell class] forCellWithReuseIdentifier:[MinePetCollectionViewCell getCellIDStr]];
//    [self.collectionView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.orderContentView];
//
//
//    UIImageView *emptyImage = [UIImageView new];
//    emptyImage.hidden = YES;
//    emptyImage.image = UIImageWithFileName(@"enpty_pets_backimage");
//    [self.orderContentView addSubview:emptyImage];
//    [emptyImage xCenterToView:self.orderContentView];
//    [emptyImage topToView:self.orderContentView withSpace:-18];
//    [emptyImage addWidth:122];
//    [emptyImage addHeight:70];
//
//    UILabel *noPetLabel = [UILabel new];
//    noPetLabel.hidden = YES;
//    noPetLabel.text = NSLocalizedString(@"nhmytjcw", nil);
//    noPetLabel.textColor = kColorThirdTextColor;
//    noPetLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
//    noPetLabel.textAlignment = NSTextAlignmentCenter;
//    [self.orderContentView addSubview:noPetLabel];
//    [noPetLabel xCenterToView:self.orderContentView];
//    [noPetLabel topToView:emptyImage withSpace:8];
//
//
//    // ID监听
//    [RACObserve(_kUserModel,user_pet) subscribeNext:^(id x) {
//        if (_kUserModel.user_pet.count == 0) {
//            self.collectionView.hidden = YES;
//            emptyImage.hidden = NO;
//            noPetLabel.hidden = NO;
//        }else{
//            self.collectionView.hidden = NO;
//            emptyImage.hidden = YES;
//            noPetLabel.hidden = YES;
//        }
//    }];
    
    
}
@end






