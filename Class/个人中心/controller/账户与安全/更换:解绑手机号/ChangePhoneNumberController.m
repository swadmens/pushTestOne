//
//  ChangePhoneNumberController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/25.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "ChangePhoneNumberController.h"

@interface ChangePhoneNumberController ()<UITextFieldDelegate>


@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,strong) UIButton *codeButton;
@property (nonatomic,strong) UIButton *sureButton;


@end

@implementation ChangePhoneNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更换手机号";
    [self setupView];
}
-(void)setupView
{
    UILabel *label1 = [UILabel new];
    label1.text = @"手机号";
    label1.textColor = kColorMainTextColor;
    label1.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [self.view addSubview:label1];
    [label1 leftToView:self.view withSpace:40];
    [label1 topToView:self.view withSpace:50];
    
    
    _phoneTextField = [UITextField new];
    _phoneTextField.placeholder = @"11位手机号码";
    _phoneTextField.textColor = kColorMainTextColor;
    _phoneTextField.font = [UIFont customFontWithSize:kFontSizeFourteen];
    _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextField.delegate = self;
    [self.view addSubview:_phoneTextField];
    [_phoneTextField yCenterToView:label1];
    [_phoneTextField leftToView:label1 withSpace:15];
    [_phoneTextField addWidth:kScreenWidth - 135];
    

    
    UILabel *lineLabel = [UILabel new];
    lineLabel.backgroundColor = kColorLineColor;
    [self.view addSubview:lineLabel];
    [lineLabel leftToView:self.view withSpace:40];
    [lineLabel topToView:label1 withSpace:15];
    [lineLabel addWidth:kScreenWidth - 76];
    [lineLabel addHeight:1];
    
    
    UILabel *label2 = [UILabel new];
    label2.text = @"验证码";
    label2.textColor = kColorMainTextColor;
    label2.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [self.view addSubview:label2];
    [label2 leftToView:self.view withSpace:40];
    [label2 topToView:label1 withSpace:55];
    
    
    _codeTextField = [UITextField new];
    _codeTextField.placeholder = @"注意查收短信";
    _codeTextField.textColor = kColorMainTextColor;
    _codeTextField.font = [UIFont customFontWithSize:kFontSizeFourteen];
    _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _codeTextField.delegate = self;
    [self.view addSubview:_codeTextField];
    [_codeTextField yCenterToView:label2];
    [_codeTextField leftToView:label2 withSpace:15];
    [_codeTextField addWidth:kScreenWidth - 222];
    
    
    
    _codeButton = [UIButton new];
    [_codeButton setBGColor:kColorMainColor forState:UIControlStateNormal];
    [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _codeButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeTwelve];
    [_codeButton addTarget:self action:@selector(sendCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _codeButton.clipsToBounds = YES;
    _codeButton.layer.cornerRadius = 5;
    [self.view addSubview:_codeButton];
    [_codeButton yCenterToView:label2];
    [_codeButton rightToView:self.view withSpace:35];
    [_codeButton addWidth:75];
    [_codeButton addHeight:30];
    
    
    
    UILabel *lineLabel2 = [UILabel new];
    lineLabel2.backgroundColor = kColorLineColor;
    [self.view addSubview:lineLabel2];
    [lineLabel2 leftToView:self.view withSpace:40];
    [lineLabel2 topToView:_codeButton withSpace:10];
    [lineLabel2 addWidth:kScreenWidth - 76];
    [lineLabel2 addHeight:1];
    
    
    _sureButton = [UIButton new];
    [_sureButton setBGColor:UIColorFromRGB(0xd8d8d8, 1) forState:UIControlStateDisabled];
    [_sureButton setBGColor:kColorMainColor forState:UIControlStateNormal];
    [_sureButton setTitle:@"提交" forState:UIControlStateNormal];
    [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [_sureButton addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _sureButton.clipsToBounds = YES;
    _sureButton.layer.cornerRadius = 5;
    [self.view addSubview:_sureButton];
    [_sureButton xCenterToView:self.view];
    [_sureButton topToView:lineLabel2 withSpace:45];
    [_sureButton addWidth:kScreenWidth - 76];
    [_sureButton addHeight:45];
    
    
    ///监听文本框输入状态，确定按钮是否可以点击
    RAC(_sureButton,enabled) = [RACSignal combineLatest:@[_phoneTextField.rac_textSignal,_codeTextField.rac_textSignal] reduce:^id _Nullable(NSString * account,NSString * password){
        return @(account.length == 11 && (password.length > 0));
    }];
    
}
-(void)sendCodeBtnClick
{
    [self startTimer];
}
- (void)startTimer
{
    __block int timeout = 60; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
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



-(void)nextBtnClick
{
//    [TargetEngine controller:self pushToController:PushTargetChangePhoneNumber WithTargetId:nil];
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
