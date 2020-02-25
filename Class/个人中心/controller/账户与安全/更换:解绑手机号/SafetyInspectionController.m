//
//  SafetyInspectionController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/25.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "SafetyInspectionController.h"

@interface SafetyInspectionController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,strong) UIButton *codeButton;
@property (nonatomic,strong) UIButton *nextButton;

@end

@implementation SafetyInspectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"安全校验";
    
    [self setupView];
    
}
-(void)setupView
{
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"已向当前账户所绑定的手机号（1527920xxxx）\n发送验证短信，请输入验证码后继续";
    titleLabel.textColor = kColorMainViceTextColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];
    [titleLabel xCenterToView:self.view];
    [titleLabel topToView:self.view withSpace:50];
    [titleLabel addWidth:kScreenWidth-110];
    
    
    
    
    UILabel *label1 = [UILabel new];
    label1.text = @"验证码";
    label1.textColor = kColorMainTextColor;
    label1.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [self.view addSubview:label1];
    [label1 leftToView:self.view withSpace:40];
    [label1 topToView:titleLabel withSpace:55];
    
    
    _codeTextField = [UITextField new];
    _codeTextField.placeholder = @"注意查收短信";
    _codeTextField.textColor = kColorMainTextColor;
    _codeTextField.font = [UIFont customFontWithSize:kFontSizeFourteen];
    _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _codeTextField.delegate = self;
    [self.view addSubview:_codeTextField];
    [_codeTextField yCenterToView:label1];
    [_codeTextField leftToView:label1 withSpace:15];
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
    [_codeButton yCenterToView:label1];
    [_codeButton rightToView:self.view withSpace:35];
    [_codeButton addWidth:75];
    [_codeButton addHeight:30];
    
    
    
    UILabel *lineLabel = [UILabel new];
    lineLabel.backgroundColor = kColorLineColor;
    [self.view addSubview:lineLabel];
    [lineLabel leftToView:self.view withSpace:40];
    [lineLabel topToView:_codeButton withSpace:10];
    [lineLabel addWidth:kScreenWidth - 76];
    [lineLabel addHeight:1];
    
    
    _nextButton = [UIButton new];
    _nextButton.enabled = NO;
    [_nextButton setBGColor:UIColorFromRGB(0xd8d8d8, 1) forState:UIControlStateNormal];
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [_nextButton addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _nextButton.clipsToBounds = YES;
    _nextButton.layer.cornerRadius = 5;
    [self.view addSubview:_nextButton];
    [_nextButton xCenterToView:self.view];
    [_nextButton topToView:lineLabel withSpace:45];
    [_nextButton addWidth:kScreenWidth - 76];
    [_nextButton addHeight:45];
    
    
    __unsafe_unretained typeof(self) weak_self = self;

    [_codeTextField.rac_textSignal subscribeNext:^(id x){
        NSString *string = [NSString stringWithFormat:@"%@",x];
        if (string.length > 0) {
            [weak_self.nextButton setBGColor:kColorMainColor forState:UIControlStateNormal];
            weak_self.nextButton.enabled = YES;

        }else{
            [weak_self.nextButton setBGColor:UIColorFromRGB(0xd8d8d8, 1) forState:UIControlStateNormal];
            weak_self.nextButton.enabled = NO;

        }
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
    [TargetEngine controller:self pushToController:PushTargetChangePhoneNumber WithTargetId:nil];
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
