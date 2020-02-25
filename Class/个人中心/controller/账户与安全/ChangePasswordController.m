//
//  ChangePasswordController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/11.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "ChangePasswordController.h"

@interface ChangePasswordController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *oldKeyTextField;
@property (nonatomic,strong) UITextField *keyTextField;

@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重置密码";
    [self creadUI];
}
-(void)creadUI
{
    UILabel *label1 = [UILabel new];
    label1.text = @"请输入账号的登录密码";
    label1.textColor = kColorMainViceTextColor;
    label1.font = [UIFont customFontWithSize:kFontSizeFourteen];
    [self.view addSubview:label1];
    [label1 leftToView:self.view withSpace:15];
    [label1 topToView:self.view withSpace:15];
    
    
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView alignTop:@"45" leading:@"0" bottom:nil trailing:@"0" toView:self.view];
    [backView addHeight:90];
    
    
    UILabel *label2 = [UILabel new];
    label2.text = @"旧密码";
    label2.textColor = kColorMainTextColor;
    label2.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [backView addSubview:label2];
    [label2 leftToView:backView withSpace:23];
    [label2 topToView:backView withSpace:13];
    
    
    _oldKeyTextField = [UITextField new];
    _oldKeyTextField.placeholder = @"请输入旧密码";
    _oldKeyTextField.textColor = kColorMainTextColor;
    _oldKeyTextField.font = [UIFont customFontWithSize:kFontSizeFourteen];
    _oldKeyTextField.secureTextEntry = YES;
    _oldKeyTextField.delegate = self;
    _oldKeyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backView addSubview:_oldKeyTextField];
    [_oldKeyTextField yCenterToView:label2];
    [_oldKeyTextField leftToView:label2 withSpace:25];
    [_oldKeyTextField addWidth:kScreenWidth-128];
    [_oldKeyTextField addHeight:35];
    
    
    UILabel *label3 = [UILabel new];
    label3.text = @"新密码";
    label3.textColor = kColorMainTextColor;
    label3.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [backView addSubview:label3];
    [label3 leftToView:backView withSpace:23];
    [label3 bottomToView:backView withSpace:13];
    
    
    _keyTextField = [UITextField new];
    _keyTextField.placeholder = @"请输入新密码";
    _keyTextField.textColor = kColorMainTextColor;
    _keyTextField.font = [UIFont customFontWithSize:kFontSizeFourteen];
    _keyTextField.secureTextEntry = YES;
    _keyTextField.delegate = self;
    _keyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backView addSubview:_keyTextField];
    [_keyTextField yCenterToView:label3];
    [_keyTextField leftToView:label3 withSpace:25];
    [_keyTextField addWidth:kScreenWidth-128];
    [_keyTextField addHeight:35];
    
    
    UILabel *lineLabel = [UILabel new];
    lineLabel.backgroundColor = kColorLineColor;
    [backView addSubview:lineLabel];
    [lineLabel yCenterToView:backView];
    [lineLabel addWidth:kScreenWidth-17];
    [lineLabel leftToView:backView withSpace:17];
    [lineLabel addHeight:1];
    
    
    UIButton *nextButton = [UIButton new];
    [nextButton setBGColor:kColorMainColor forState:UIControlStateNormal];
    [nextButton setTitle:@"确定" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    nextButton.clipsToBounds = YES;
    nextButton.layer.cornerRadius = 5;
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    [nextButton topToView:backView withSpace:30];
    [nextButton xCenterToView:self.view];
    [nextButton addWidth:kScreenWidth-30];
    [nextButton addHeight:45];
    
    
    UIButton *forgetBtn = [UIButton new];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:kColorMainViceTextColor forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeTwelve];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    [forgetBtn xCenterToView:self.view];
    [forgetBtn topToView:nextButton withSpace:15];
    
}
//点击重置密码
-(void)nextButtonClick
{
    
}
//忘记密码
-(void)forgetBtnClick
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
