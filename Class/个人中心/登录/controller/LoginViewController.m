//
//  LoginViewController.m
//  YuLaLa
//
//  Created by 汪伟 on 2018/5/19.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "LoginViewController.h"
#import <RACSignal.h>

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIScrollView *sView;
@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,strong) UIView *normalView;
@property (nonatomic,strong) UIView *codeView;

@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UITextField *keyTextField;

@property (nonatomic,strong) UILabel *lineLabel1;
@property (nonatomic,strong) UILabel *lineLabel2;

@property (nonatomic,strong) UIButton *codeButton;
@property (nonatomic,strong) UIButton *loginStyleBtn;

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.FDPrefersNavigationBarHidden=YES;
//    self.isSmsLogin = NO;
    
    
    
    UIImage *aimage = UIImageWithFileName(@"login_close_images");
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:aimage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(action_goback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button topToView:self.view withSpace:30];
    [button leftToView:self.view withSpace:15];
    
    
    UIButton *rightBtn = [UIButton new];
    [rightBtn setTitle:@"先去逛逛" forState:UIControlStateNormal];
    [rightBtn setTitleColor:kColorMainColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [rightBtn addTarget:self action:@selector(otherLookClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    [rightBtn yCenterToView:button];
    [rightBtn rightToView:self.view withSpace:15];
    
    
    _sView = [UIScrollView new];
    _sView.backgroundColor = kColorBackgroundColor;
    [self.view addSubview:_sView];
    [_sView alignTop:@"60" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    
    _sView.contentSize = CGSizeMake(kScreenWidth, 580);
    
    CGFloat width = 88;
    
    _iconImageView = [UIImageView new];
    _iconImageView.image = UIImageWithFileName(@"login_logo_icon");
//    _iconImageView.clipsToBounds = YES;
//    _iconImageView.layer.cornerRadius = 24;
    [_sView addSubview:_iconImageView];
    [_iconImageView xCenterToView:_sView];
    [_iconImageView topToView:_sView withSpace:15];
//    [_iconImageView addWidth:width];
//    [_iconImageView addHeight:width];
    

    
    [self creadNoramlView];
    [self creadBottomView];
    [self creadCodeView];

}

//账户密码登录页面
-(void)creadNoramlView
{
    _normalView = [UIView new];
//    _normalView.layer.cornerRadius = 12;
    _normalView.backgroundColor = UIColorClearColor;
//    _normalView.layer.shadowColor = [UIColor blackColor].CGColor;
//    _normalView.layer.shadowOffset = CGSizeMake(0, 0);
//    _normalView.layer.shadowOpacity = 0.1f;
    [_sView addSubview:_normalView];
    [_normalView topToView:_iconImageView withSpace:10];
    [_normalView leftToView:_sView withSpace:20];
    [_normalView addWidth:kScreenWidth-20];
    [_normalView addHeight:245];
    
    
    UILabel *zhLabel = [UILabel new];
    zhLabel.text = @"手机号";
    zhLabel.textColor = kColorMainColor;
    zhLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [_normalView addSubview:zhLabel];
    [zhLabel leftToView:_normalView withSpace:20];
    [zhLabel topToView:_normalView withSpace:25];
    
    
    _nameTextField = [UITextField new];
    _nameTextField.delegate = self;
    _nameTextField.backgroundColor = UIColorClearColor;
    _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_normalView addSubview:_nameTextField];
    [_nameTextField leftToView:_normalView withSpace:20];
    [_nameTextField rightToView:_normalView withSpace:40];
    [_nameTextField topToView:zhLabel];
    [_nameTextField addHeight:30];
    
    
    _lineLabel1 = [UILabel new];
    _lineLabel1.backgroundColor = kColorLineColor;
    [_normalView addSubview:_lineLabel1];
    [_lineLabel1 leftToView:_normalView withSpace:20];
    [_lineLabel1 rightToView:_normalView withSpace:40];
    [_lineLabel1 addHeight:1];
    [_lineLabel1 topToView:_nameTextField];
    
    
    UILabel *keyLabel = [UILabel new];
    keyLabel.text = @"密码";
    keyLabel.textColor = kColorMainTextColor;
    keyLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [_normalView addSubview:keyLabel];
    [keyLabel leftToView:_normalView withSpace:20];
    [keyLabel topToView:_nameTextField withSpace:15];
    
    
    _keyTextField = [UITextField new];
    _keyTextField.delegate = self;
    _keyTextField.backgroundColor = UIColorClearColor;
    _keyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _keyTextField.secureTextEntry = YES;
    [_normalView addSubview:_keyTextField];
    [_keyTextField leftToView:_normalView withSpace:20];
    [_keyTextField rightToView:_normalView withSpace:40];
    [_keyTextField topToView:keyLabel];
    [_keyTextField addHeight:30];
    
    
    _lineLabel2 = [UILabel new];
    _lineLabel2.backgroundColor = kColorLineColor;
    [_normalView addSubview:_lineLabel2];
    [_lineLabel2 leftToView:_normalView withSpace:20];
    [_lineLabel2 rightToView:_normalView withSpace:40];
    [_lineLabel2 addHeight:1];
    [_lineLabel2 topToView:_keyTextField];
    
    
    UIButton *forgetButton=[UIButton new];
    [forgetButton setTitleColor:kColorMainViceTextColor forState:UIControlStateNormal];
    [forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [forgetButton addTarget:self action:@selector(resetPassword) forControlEvents:UIControlEventTouchUpInside];
    forgetButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeFourteen];
    [_normalView addSubview:forgetButton];
    [forgetButton leftToView:_normalView withSpace:20];
    [forgetButton topToView:_lineLabel2 withSpace:10];
    
    
    
//    UIView *loginView = [UIView new];
//    loginView.layer.shadowColor = [UIColor blackColor].CGColor;
//    loginView.layer.shadowOffset = CGSizeMake(0, 6);
//    loginView.layer.shadowOpacity = 0.1f;
//    loginView.backgroundColor = UIColorClearColor;
//    [_normalView addSubview:loginView];
//    [loginView xCenterToView:_normalView];
//    [loginView bottomToView:_normalView withSpace:25];
//    [loginView addWidth:kScreenWidth-80];
//    [loginView addHeight:50];
    
    
    UIButton *loginButton = [UIButton new];
    loginButton.layer.cornerRadius = 5;
    loginButton.clipsToBounds = YES;
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setBGColor:kColorMainColor forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(starLoaginButton) forControlEvents:UIControlEventTouchUpInside];
    loginButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeNineTeen];
    [_normalView addSubview:loginButton];
//    [loginButton alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:loginView];
    [loginButton leftToView:_normalView withSpace:20];
    [loginButton bottomToView:_normalView];
    [loginButton addWidth:kScreenWidth-80];
    [loginButton addHeight:50];
    
    
    
    
//    [[_nameTextField.rac_textSignal
//      filter:^BOOL(id value){
//          NSString*text = value;
//          return text.length == 0;
//      }]
//     subscribeNext:^(id x){
//         self.lineLabel1.backgroundColor = kColorLineColor;
//     }];
//
//
//    [[_keyTextField.rac_textSignal
//      filter:^BOOL(id value){
//          NSString*text = value;
//          return text.length == 0;
//      }]
//     subscribeNext:^(id x){
//         self.lineLabel2.backgroundColor = kColorLineColor;
//     }];
    
    
    
   
    
}
-(void)creadCodeView
{
    _codeView = [UIView new];
    _codeView.hidden = YES;
//    _codeView.layer.cornerRadius = 12;
    _codeView.backgroundColor = UIColorClearColor;
//    _codeView.layer.shadowColor = [UIColor blackColor].CGColor;
//    _codeView.layer.shadowOffset = CGSizeMake(0, 0);
//    _codeView.layer.shadowOpacity = 0.1f;
    [_sView addSubview:_codeView];
    [_codeView topToView:_iconImageView withSpace:20];
    [_codeView leftToView:_sView withSpace:20];
    [_codeView addWidth:kScreenWidth-20];
    [_codeView addHeight:245];
    
    
    UILabel *zhLabel = [UILabel new];
    zhLabel.text = @"手机号";
    zhLabel.textColor = kColorMainTextColor;
    zhLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [_codeView addSubview:zhLabel];
    [zhLabel leftToView:_codeView withSpace:20];
    [zhLabel topToView:_codeView withSpace:25];
    
    
    _nameTextField = [UITextField new];
    _nameTextField.delegate = self;
    _nameTextField.backgroundColor = UIColorClearColor;
    _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_codeView addSubview:_nameTextField];
    [_nameTextField leftToView:zhLabel withSpace:18];
    [_nameTextField rightToView:_codeView withSpace:40];
    [_nameTextField yCenterToView:zhLabel];
    [_nameTextField addHeight:30];
    
    
    _lineLabel1 = [UILabel new];
    _lineLabel1.backgroundColor = kColorLineColor;
    [_codeView addSubview:_lineLabel1];
    [_lineLabel1 leftToView:_codeView withSpace:20];
    [_lineLabel1 rightToView:_codeView withSpace:40];
    [_lineLabel1 addHeight:1];
    [_lineLabel1 topToView:_nameTextField withSpace:10];
    
    
    UILabel *keyLabel = [UILabel new];
    keyLabel.text = @"验证码";
    keyLabel.textColor = kColorMainTextColor;
    keyLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [_codeView addSubview:keyLabel];
    [keyLabel leftToView:_codeView withSpace:20];
    [keyLabel topToView:_lineLabel1 withSpace:18];
    
    
    _keyTextField = [UITextField new];
    _keyTextField.delegate = self;
    _keyTextField.backgroundColor = UIColorClearColor;
    _keyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _keyTextField.secureTextEntry = YES;
    [_codeView addSubview:_keyTextField];
    [_keyTextField leftToView:keyLabel withSpace:18];
    [_keyTextField rightToView:_codeView withSpace:120];
    [_keyTextField yCenterToView:keyLabel];
    [_keyTextField addHeight:30];
    
    
    _lineLabel2 = [UILabel new];
    _lineLabel2.backgroundColor = kColorLineColor;
    [_codeView addSubview:_lineLabel2];
    [_lineLabel2 leftToView:_codeView withSpace:18];
    [_lineLabel2 rightToView:_codeView withSpace:18];
    [_lineLabel2 addHeight:1];
    [_lineLabel2 topToView:_keyTextField withSpace:10];
    
    
    _codeButton=[UIButton new];
    _codeButton.clipsToBounds = YES;
    _codeButton.layer.cornerRadius = 5;
    [_codeButton setBGColor:kColorMainColor forState:UIControlStateNormal];
    [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
//    _codeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_codeButton addTarget:self action:@selector(getCodeClick) forControlEvents:UIControlEventTouchUpInside];
    _codeButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeFourteen];
    [_codeView addSubview:_codeButton];
    [_codeButton yCenterToView:keyLabel];
    [_codeButton rightToView:_codeView withSpace:40];
    [_codeButton addWidth:76];
    [_codeButton addHeight:30];
    
    
    
//    UIView *loginView = [UIView new];
//    loginView.layer.shadowColor = [UIColor blackColor].CGColor;
//    loginView.layer.shadowOffset = CGSizeMake(0, 6);
//    loginView.layer.shadowOpacity = 0.1f;
//    loginView.backgroundColor = UIColorClearColor;
//    [_codeView addSubview:loginView];
//    [loginView xCenterToView:_codeView];
//    [loginView bottomToView:_codeView withSpace:25];
//    [loginView addWidth:166];
//    [loginView addHeight:50];
    
    
    UIButton *loginButton = [UIButton new];
    loginButton.layer.cornerRadius = 6;
    loginButton.clipsToBounds = YES;
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setBGColor:kColorMainColor forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(starLoaginButton) forControlEvents:UIControlEventTouchUpInside];
    loginButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeNineTeen];
//    [loginView addSubview:loginButton];
//    [loginButton alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:loginView];
    [_codeView addSubview:loginButton];
    [loginButton leftToView:_codeView withSpace:20];
    [loginButton bottomToView:_codeView withSpace:30];
    [loginButton addWidth:kScreenWidth-80];
    [loginButton addHeight:50];
    
}
//底图视图
-(void)creadBottomView
{
    /// 登录方式
    _loginStyleBtn=[UIButton new];
    [_loginStyleBtn setTitleColor:kColorMainColor forState:UIControlStateNormal];
    [_loginStyleBtn setTitle:@"短信验证码登陆" forState:UIControlStateNormal];
    _loginStyleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_loginStyleBtn addTarget:self action:@selector(changeLoginStyle) forControlEvents:UIControlEventTouchUpInside];
    _loginStyleBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeFourteen];
    [self.sView addSubview:_loginStyleBtn];
    [_loginStyleBtn topToView:_iconImageView withSpace:260];
    [_loginStyleBtn leftToView:self.sView withSpace:kScreenWidth-135];
    
    
    /// 立即注册
    UIButton *registerButton=[UIButton new];
    [registerButton addTarget:self action:@selector(gotoRegisterController) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:kColorMainTextColor forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeFourteen];
    [self.sView addSubview:registerButton];
    [registerButton yCenterToView:_loginStyleBtn];
    [registerButton leftToView:self.sView withSpace:40];
    
    
    
    UILabel *label1=[UILabel new];
    label1.text = @"第三方登录";
    label1.textColor=kColorMainViceTextColor;
    label1.font=[UIFont customFontWithSize:kFontSizeFourteen];
    label1.textAlignment = NSTextAlignmentCenter;
    [label1 sizeToFit];
    [self.sView addSubview:label1];
    [label1 xCenterToView:self.sView];
    [label1 topToView:_loginStyleBtn withSpace:38];
    
    
    CGFloat laFloat = [WWPublicMethod widthForLabel:label1.text fontSize:[UIFont customFontWithSize:kFontSizeFifty]];
    CGFloat width = kScreenWidth - laFloat - 15;
    
    UILabel *leftLine=[UILabel new];
    leftLine.backgroundColor=kColorLineColor;
    [self.sView addSubview:leftLine];
    [leftLine addHeight:1];
    [leftLine yCenterToView:label1];
    [leftLine addWidth:width / 2];
    [leftLine leftToView:self.sView withSpace:0];
    
    UILabel *rightLine=[UILabel new];
    rightLine.backgroundColor=kColorLineColor;
    [self.sView addSubview:rightLine];
    [rightLine addHeight:1];
    [rightLine yCenterToView:label1];
    [rightLine leftToView:label1 withSpace:10];
    [rightLine addWidth:width / 2];
    
    
    UIButton *wechatButton=[UIButton new];
    [wechatButton setBackgroundImage:UIImageWithFileName(@"icon_WX") forState:UIControlStateNormal];
    [wechatButton addTarget:self action:@selector(wechatLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.sView addSubview:wechatButton];
    [wechatButton addCenterX:26 toView:self.sView];
    [wechatButton topToView:label1 withSpace:34];
    
    
    
    UIButton *sinaButton=[UIButton new];
    [sinaButton setBackgroundImage:UIImageWithFileName(@"icon_WB") forState:UIControlStateNormal];
    [sinaButton addTarget:self action:@selector(SinaWeiboLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.sView addSubview:sinaButton];
    [sinaButton yCenterToView:wechatButton];
    [sinaButton addCenterX:-26 toView:self.sView];
}
-(void)action_goback
{
    [_kHUDManager showMsgInView:nil withTitle:@"返回上一页" isSuccess:YES];
    [_kUserModel hideLoginViewWithBlock:nil];
}

-(void)changeLoginStyle
{
    //    [self.view removeFromSuperview];
    [_kHUDManager showMsgInView:nil withTitle:@"切换登录方式" isSuccess:YES];
    
    _loginStyleBtn.selected = !_loginStyleBtn.selected;
    
    _normalView.hidden = _loginStyleBtn.selected;
    _codeView.hidden = !_loginStyleBtn.selected;
    
    [_loginStyleBtn setTitle:_loginStyleBtn.selected?@"账户密码登陆":@"短信验证码登陆" forState:UIControlStateNormal];
    
}
-(void)gotoRegisterController
{
    //    [self.view removeFromSuperview];
    [_kHUDManager showMsgInView:nil withTitle:@"注册" isSuccess:YES];
    [TargetEngine controller:nil pushToController:PushTargetRegisteredView WithTargetId:nil];
}
-(void)wechatLoginButton
{
    //    [self.view removeFromSuperview];
    [_kHUDManager showMsgInView:nil withTitle:@"微信登录" isSuccess:YES];
}

-(void)SinaWeiboLoginButton
{
    //    [self.view removeFromSuperview];
    [_kHUDManager showMsgInView:nil withTitle:@"微博登录" isSuccess:YES];
}
-(void)otherLookClick
{
    [_kHUDManager showMsgInView:nil withTitle:@"先去逛逛" isSuccess:YES];
    [_kUserModel hideLoginViewWithBlock:nil];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:_nameTextField]) {
        _lineLabel1.backgroundColor = kColorMainColor;
    }else{
        _lineLabel2.backgroundColor = kColorMainColor;
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:_nameTextField]) {
        if (textField.text.length == 0) {
            _lineLabel1.backgroundColor = kColorLineColor;
        }
    }else{
        if (textField.text.length == 0) {
            _lineLabel2.backgroundColor = kColorLineColor;
        }
    }
}
//获取验证码
-(void)getCodeClick
{
    __block int timeout = 60; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeButton setTitle:@"重新发送" forState:UIControlStateNormal];
                self.codeButton.userInteractionEnabled = YES;
                
            });
        }else{
            //            int minutes = timeout / 60;
            //            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *startTime = [NSString stringWithFormat:@"%@s", strTime];
                [self.codeButton setTitle:startTime forState:UIControlStateNormal];
                self.codeButton.userInteractionEnabled = NO;
                
                timeout--;
            });
        }
    });
    dispatch_resume(_timer);
}
//登录
-(void)starLoaginButton
{
    
}
//忘记密码
-(void)resetPassword
{
    
}
@end
