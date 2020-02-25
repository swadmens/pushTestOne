//
//  RegisteredViewController.m
//  YuLaLa
//
//  Created by 汪伟 on 2018/5/21.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "RegisteredViewController.h"
#import "RegisteredViewCell.h"
#import "LGXSMSEngine.h"
#import "WWTableView.h"
#import "RequestSence.h"
#import "LoginButtonCell.h"
#import "RegisterSence.h"
#import "AssociatedRegistRequest.h"
#import "LGXButton.h"
#import "SharedClient.h"



@interface RegisteredViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic, strong) WWTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *placeArray;

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, strong) NSString *codeNum;
@property (nonatomic, strong) NSString *password;


@property (nonatomic,strong) NSString *sendCode;
@property(nonatomic,strong) NSString *token;

@property (nonatomic, strong) RegisterSence *registSence;
@property(nonatomic,strong) AssociatedRegistRequest *assRegistSence;

@property (nonatomic, strong) NSString *region;//当前定位城市
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (strong, nonatomic) CLLocationManager* locationManager;

//@property (nonatomic,strong) NSDictionary *sortedNameDict;
//@property(nonatomic,strong) NSString *openid;
//@property(nonatomic,strong) NSString *code;
//@property(nonatomic,strong) NSString *nickname;
//@property(nonatomic,strong) NSString *headimgurl;

@property (strong, nonatomic)  LGXButton *agreeButton;


@end

@implementation RegisteredViewController

-(void)setupTableView
{
    self.tableView = [[WWTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = kColorBackgroundColor;
    [self.view addSubview:self.tableView];
    [self.tableView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.tableView registerClass:[RegisteredViewCell class] forCellReuseIdentifier:[RegisteredViewCell getCellIDStr]];
    [self.tableView registerClass:[LoginButtonCell class] forCellReuseIdentifier:[LoginButtonCell getCellIDStr]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    
    NSArray *nameArr = @[@"昵称",@"手机号",@"验证码",@"密码"];
    self.dataArray = [NSMutableArray arrayWithArray:nameArr];
    
    NSArray *placeArr = @[@"请输入昵称",@"请输11位手机号码",@"注意查收短信",@"请设置密码"];
    self.placeArray = [NSMutableArray arrayWithArray:placeArr];
    
    
    
    [self setupTableView];
    [self startLocation];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.row == 4){
        LoginButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:[LoginButtonCell getCellIDStr] forIndexPath:indexPath];
//        cell.lineHidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell makeCellData:@"注册"];
        [cell setLoginButtonClick:^{
            //找回密码
            [self firstChenckYanZhengMa];
        }];
        
        return cell;
        
    }else{
        RegisteredViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RegisteredViewCell getCellIDStr] forIndexPath:indexPath];
//        cell.lineHidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *icon = [self.dataArray objectAtIndex:indexPath.row];
        NSString *place = [self.placeArray objectAtIndex:indexPath.row];
        
        [cell makeCellData:icon withPlace:place withTag:indexPath.row withStyle:self.sendCode];
        
        cell.replacTextFieldText = ^(NSString *text) {
            if (indexPath.row == 0) {
                self.nickName = text;
            }else if(indexPath.row == 1){
                self.phoneNum = text;
            }else if(indexPath.row == 2){
                self.codeNum = text;
            }else{
                self.password = text;
            }
        };
        cell.replacSendCodeButton = ^{
            //发送验证码
            [self action_getVers];
        };
        return cell;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 145;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *iconImageView = [UIImageView new];
//    iconImageView.clipsToBounds = YES;
//    iconImageView.layer.cornerRadius = 37.5;
    iconImageView.image = UIImageWithFileName(@"regist_icon_image");
    [headerView addSubview:iconImageView];
    [iconImageView centerToView:headerView];
//    [iconImageView addWidth:75];
//    [iconImageView addHeight:75];
    

    return headerView;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor clearColor];
    
    
    UILabel *texts = [UILabel new];
    texts.text = @"点击”注册“按钮即表示同意";
    texts.font = [UIFont customFontWithSize:kFontSizeThirteen];
    texts.textColor = kColorSecondTextColor;
    [texts sizeToFit];
    [footerView addSubview:texts];
    [texts xCenterToView:footerView];
    [texts topToView:footerView withSpace:15];
    
    
    self.agreeButton=[LGXButton new];
    [self.agreeButton setTitle:@"《注册服务协议》" forState:UIControlStateNormal];
    [self.agreeButton setTitleColor:kColorMainColor forState:UIControlStateNormal];
    self.agreeButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [self.agreeButton addTarget:self action:@selector(goxieyi) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:self.agreeButton];
    [self.agreeButton xCenterToView:footerView];
    [self.agreeButton topToView:texts];
    [self.agreeButton addBottomLineByColor:kColorMainColor];
   
    
    
    return footerView;
}
/// 去查看协议
- (void)goxieyi
{
//    NSString *url = [NSString stringWithFormat:@"%@/website/protocol/about_dynamic",[SharedClient domainURL]];
//    [TargetEngine controller:nil pushToController:PushTargetWebView WithTargetId:url];
}

#pragma mark - Location
-(void)startLocation{
    
    if ([CLLocationManager locationServicesEnabled]) {//判断定位操作是否被允许
        
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;//遵循代理
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        self.locationManager.distanceFilter = 10.0f;
        
        [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8以上版本定位需要）
        
        [self.locationManager startUpdatingLocation];//开始定位
        
    }else{//不能定位用户的位置的情况再次进行判断，并给与用户提示
        
        //1.提醒用户检查当前的网络状况
        
        //2.提醒用户打开定位开关
        
    }
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //当前所在城市的坐标值
    CLLocation *currLocation = [locations lastObject];
    DLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    self.longitude = [NSString stringWithFormat:@"%.0f",currLocation.coordinate.longitude];
    self.latitude = [NSString stringWithFormat:@"%.0f",currLocation.coordinate.latitude];
    //根据经纬度反向地理编译出地址信息
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *address = [placemark addressDictionary];
            
            self.region = [NSString stringWithFormat:@"%@ %@ %@",[address objectForKey:@"Country"],[address objectForKey:@"State"],[address objectForKey:@"City"]];
        }
        
    }];
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    self.longitude = @"0";
    self.latitude = @"0";
    self.region = @"0";
    if ([error code] == kCLErrorDenied){
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
}

#pragma mark - 获取验证码
/// 获取验证码
- (void)getVerificationCodeWithPhone:(NSString *)phoneNumber result:(SMSFinishedResultHandler)result
{
    [self.view endEditing:YES];
    
    NSString *theString = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([WWPublicMethod isNumberString:theString] == NO) { // 不是电话号码
        [_kHUDManager showMsgInView:nil withTitle:@"手机号码有误" isSuccess:NO];
        
        if (result) {
            result(NO);
        }
        return;
    }
    [_kHUDManager showActivityInView:nil withTitle:@"正在获取"];
    
    RequestSence *sence = [[RequestSence alloc] init];
    sence.pathURL = @"phonecode";
    
    NSMutableDictionary *parDic=[NSMutableDictionary dictionaryWithDictionary:[MyMD5 updataDic:phoneNumber]];
    [parDic setObject:@"reg" forKey:@"type"];
//    [parDic setObject:self.zone_number forKey:@"zone_number"];
    
    sence.params = parDic;
    
    sence.successBlock = ^(id obj) {
        [_kHUDManager showSuccessInView:nil withTitle:[obj objectForKey:@"msg"] hideAfter:_kHUDDefaultHideTime onHide:nil];
        if (result) {
            result(YES);
        }
    };
    sence.errorBlock = ^(NSError *error){
        id obj = error.userInfo;
        [_kHUDManager showMsgInView:nil withTitle:[obj objectForKey:@"msg"] isSuccess:NO];
    };
    [sence sendRequest];
    
}
- (void)action_getVers
{
    [self getVerificationCodeWithPhone:self.phoneNum result:^(BOOL success) {
        if (success) {
            //开始获取验证码，并显示倒计时，在cell内进行
            self.sendCode = @"startSendCode";
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - 提交之前先检查验证码
- (void)firstChenckYanZhengMa
{
    if ([self checkWithUName:self.phoneNum andYanzheng:self.codeNum andPassword:self.password] == NO) {
        return;
    }
    
    RequestSence *sence = [[RequestSence alloc] init];
    sence.pathURL = @"phonecode/check";
    sence.params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                   @"phone":self.phoneNum,
                                                                   @"code" :self.codeNum,
                                                                   @"type" :@"reg",
//                                                                   @"zone_number" :self.zone_number,
                                                                   }];
    sence.successBlock = ^(id obj) {
        [_kHUDManager showSuccessInView:nil withTitle:[obj objectForKey:@"msg"] hideAfter:_kHUDDefaultHideTime onHide:nil];
        
        NSDictionary *dicObj=(NSDictionary*)[obj objectForKey:@"data"];
        
        self.token=[NSString stringWithFormat:@"%@",[dicObj objectForKey:@"token"]];
        
        
        if (self.thirdId.length>10){
            [self registerAssWithUName:self.phoneNum pwd:self.password];
        }else{
            [self registerWithUName:self.phoneNum pwd:self.password];
        }
        
        
    };
    sence.errorBlock = ^(NSError *error){
        NSString *msg=[error.userInfo objectForKey:@"msg"];
        [_kHUDManager showMsgInView:nil withTitle:msg isSuccess:YES];
    };
    
    [sence sendRequest];
    
}
#pragma mark - 输入检测
- (BOOL)checkWithUName:(NSString *)uname andYanzheng:(NSString *)code andPassword:(NSString*)password
{
    if ([WWPublicMethod isStringEmptyText:uname] == NO) {
        [_kHUDManager showMsgInView:nil withTitle:@"手机号有误，请重新填写！" isSuccess:NO];
        
        return NO;
    }
    
    if ([WWPublicMethod isStringEmptyText:code] == NO) {
        [_kHUDManager showMsgInView:nil withTitle:@"请输入验证码" isSuccess:NO];
        return NO;
    }
    
    if ([WWPublicMethod isStringEmptyText:password] == NO || password.length < 6) { // 密码要求6位
        [_kHUDManager showMsgInView:nil withTitle:@"请输入不小于6位数的密码" isSuccess:NO];
        return NO;
    }
    
    return YES;
}



#pragma mark - 注册
/// 注册
- (void)registerWithUName:(NSString *)phone pwd:(NSString *)upwd
{
    [_kHUDManager showActivityInView:nil withTitle:@"注册中..."];
    self.registSence.phone = phone;
    self.registSence.pwd = upwd;
    self.registSence.token = self.token;
//    self.registSence.zone_number = self.zone_number;
    
    [self.registSence sendRequest];
}
- (RegisterSence *)registSence
{
    if (!_registSence) {
        _registSence = [[RegisterSence alloc] init];
        __unsafe_unretained typeof(self) weak_self = self;
        _registSence.successBlock = ^(id obj) {
            [weak_self finishedRegister:obj];
        };
        _registSence.errorBlock = ^(NSError *error) {
            [weak_self errorToRegister:error];
        };
    }
    return _registSence;
}
- (void)finishedRegister:(id)obj
{
    //处理加密数据
    NSDictionary *data=[obj objectForKey:@"data"];
    NSString *ec_salt=[data objectForKey:@"ec_salt"];
    NSString *user_id=[data objectForKey:@"user_id"];
    
    NSString *login_key=[NSString stringWithFormat:@"%@%@",MD5(self.password),ec_salt];
    NSString *passwd = MD5(self.password);
    
    //处理完加密数据后正常登录
    NSDictionary *dic = @{
                          @"user_id":user_id,
                          @"ec_salt":ec_salt,
                          @"passwd":passwd,
                          @"login_key":MD5(login_key),
                          @"region":self.region,
                          @"longitude":self.longitude,
                          @"latitude":self.latitude,
                          @"mobile_phone":self.phoneNum,
                          };
    [_kUserModel loginWithUser_id:dic];
}
- (void)errorToRegister:(NSError *)error
{
    NSString *msg = [error.userInfo objectForKey:@"msg"];
    if (msg) {
        [_kHUDManager showMsgInView:nil withTitle:msg isSuccess:YES];
        
    } else {
        [_kHUDManager showFailedInView:nil withTitle:@"请求失败" hideAfter:_kHUDDefaultHideTime onHide:nil];
    }
}

//关联注册
- (void)registerAssWithUName:(NSString *)phone pwd:(NSString *)upwd
{
    [_kHUDManager showActivityInView:nil withTitle:@"注册中"];
    self.assRegistSence.phone = phone;
    self.assRegistSence.pwd = upwd;
    self.assRegistSence.token = self.token;
//    self.assRegistSence.zone_number = self.zone_number;

//    self.assRegistSence.openid=self.openid;
//    self.assRegistSence.nickname=self.nickname;
//    self.assRegistSence.headimgurl=self.headimgurl;
//    self.assRegistSence.ThirdCode=self.code;
    
    [self.assRegistSence sendRequest];
    
}
- (AssociatedRegistRequest *)assRegistSence
{
    if (!_assRegistSence) {
        _assRegistSence = [[AssociatedRegistRequest alloc] init];
        __unsafe_unretained typeof(self) weak_self = self;
        _assRegistSence.successBlock = ^(id obj) {
            [_kHUDManager hideAfter:0.1 onHide:nil];
            [weak_self finishedAssRegister:obj];
        };
        _assRegistSence.errorBlock = ^(NSError *error) {
            [_kHUDManager hideAfter:0.1 onHide:nil];
            [weak_self errorToAssRegister:error];
        };
    }
    return _assRegistSence;
}
- (void)finishedAssRegister:(id)obj
{
    /// 配置第三方登录信息
    _kUserModel.loginAcount = self.phoneNum;
    [_kUserModel setupInfoData:obj];
    _kUserModel.isLogined = YES;
    [_kUserModel hideLoginViewWithBlock:nil];
    
}
- (void)errorToAssRegister:(NSError *)error
{
    NSString *msg = [error.userInfo objectForKey:@"msg"];
    if (msg) {
        [_kHUDManager showMsgInView:nil withTitle:msg isSuccess:YES];
        
    } else {
        [_kHUDManager showFailedInView:nil withTitle:@"请求失败" hideAfter:_kHUDDefaultHideTime onHide:nil];
    }
}



@end
