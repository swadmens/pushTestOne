//
//  AccountSecurityController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/11.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "AccountSecurityController.h"
#import "WWTableView.h"
#import "WWTableViewCell.h"

@interface AccountSecurityController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) WWTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UIView *converView;
@property (nonatomic,strong) UIView *bottomView;

@end

@interface AccountSecurityCell : WWTableViewCell

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *detailLabel;

-(void)makeCellData:(NSString*)title withDetail:(NSString*)detail;

@end



@implementation AccountSecurityController

- (void)setupTableView
{
    self.tableView = [[WWTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UIColorClearColor;
    [self.view addSubview:self.tableView];
    [self.tableView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AccountSecurityCell class] forCellReuseIdentifier:[AccountSecurityCell getCellIDStr]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账户与安全";
    [self setupTableView];
    [self setupChangePhoneView];
    
    NSArray *array =@[@{
                          @"title":@"重置密码",@"details":@" "
                             },@{
                             @"title":@"邮箱",@"details":@"XXXXXXXXXX@163.com"
                             },@{
                             @"title":@"手机号码",@"details":@"150670XXXXX"
                             },];
    self.dataArray = [NSMutableArray arrayWithArray:array];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountSecurityCell *cell = [tableView dequeueReusableCellWithIdentifier:[AccountSecurityCell getCellIDStr] forIndexPath:indexPath];
    cell.lineHidden=NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    NSString *title = [dict objectForKey:@"title"];
    NSString *details = [dict objectForKey:@"details"];
    [cell makeCellData:title withDetail:details];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
        if (indexPath.row == 0) {
          //重置密码
            [TargetEngine controller:nil pushToController:PushTargetChangePassword WithTargetId:nil];
        }else if (indexPath.row == 1){
           
        }else{
            
            _converView.hidden = NO;
            
            [UIView animateWithDuration:0.3 animations:^{
                self.bottomView.frame = CGRectMake(0, kScreenHeight - 96, kScreenWidth,  96);
            }];
            
        }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*headerView=[UIView new];
    headerView.backgroundColor=kColorBackgroundColor;
    
    UILabel *label = [UILabel new];
    label.text = @"密码设置";
    label.textColor = kColorMainViceTextColor;
    label.font = [UIFont customFontWithSize:kFontSizeFourteen];
    [headerView addSubview:label];
    [label leftToView:headerView withSpace:10];
    [label bottomToView:headerView withSpace:10];
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView*footerView=[UIView new];
    footerView.backgroundColor=UIColorClearColor;
    
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

//更换/解绑手机号
-(void)setupChangePhoneView
{
    _converView = [UIView new];
    _converView.hidden = YES;
    _converView.userInteractionEnabled = YES;
    _converView.backgroundColor = UIColorFromRGB(0x000000, 0.5);
    _converView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 96);
    [[UIApplication sharedApplication].keyWindow addSubview:_converView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCoverViewClick:)];
    [_converView addGestureRecognizer:tap];
    
    
    
    _bottomView = [UIView new];
    _bottomView.userInteractionEnabled = YES;
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth,  96);
    [[UIApplication sharedApplication].keyWindow addSubview:_bottomView];
    
    
    UIView *view1 = [UIView new];
    view1.userInteractionEnabled = YES;
    view1.backgroundColor = UIColorClearColor;
    [_bottomView addSubview:view1];
    [view1 alignTop:@"0" leading:@"0" bottom:nil trailing:@"0" toView:_bottomView];
    [view1 addHeight:48];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePhoneNum:)];
    [view1 addGestureRecognizer:tap1];
    
    
    UIImageView *imageView1 = [UIImageView new];
    imageView1.image = UIImageWithFileName(@"account_change_image");
    [view1 addSubview:imageView1];
    [imageView1 addCenterY:4 toView:view1];
    [imageView1 leftToView:view1 withSpace:14];
    
    UILabel *label1 = [UILabel new];
    label1.text = @"更换手机号";
    label1.textColor = kColorMainTextColor;
    label1.font = [UIFont customFontWithSize:kFontSizeFifty];
    [view1 addSubview:label1];
    [label1 yCenterToView:imageView1];
    [label1 leftToView:imageView1 withSpace:9];
    
    
    
    UIView *view2 = [UIView new];
    view2.userInteractionEnabled = YES;
    view2.backgroundColor = UIColorClearColor;
    [_bottomView addSubview:view2];
    [view2 alignTop:nil leading:@"0" bottom:@"0" trailing:@"0" toView:_bottomView];
    [view2 addHeight:48];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(unbundingPhoneNum:)];
    [view2 addGestureRecognizer:tap2];
    
    
    UIImageView *imageView2 = [UIImageView new];
    imageView2.image = UIImageWithFileName(@"account_unbunding_image");
    [view2 addSubview:imageView2];
    [imageView2 addCenterY:-4 toView:view2];
    [imageView2 leftToView:view2 withSpace:14];
    
    UILabel *label2 = [UILabel new];
    label2.text = @"解绑手机号";
    label2.textColor = UIColorFromRGB(0xed0000, 1);
    label2.font = [UIFont customFontWithSize:kFontSizeFifty];
    [view2 addSubview:label2];
    [label2 yCenterToView:imageView2];
    [label2 leftToView:imageView2 withSpace:9];
    
    
    
}
-(void)hideCoverViewClick:(UITapGestureRecognizer*)tp
{
    _converView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth,  96);
    }];
}

//更改手机号
-(void)changePhoneNum:(UITapGestureRecognizer*)tp
{
    [self hideCoverViewClick:nil];
}
//解绑手机号
-(void)unbundingPhoneNum:(UITapGestureRecognizer*)tp
{
    [self hideCoverViewClick:nil];
    
    [[TCNewAlertView shareInstance] showAlert:@"解绑手机号" message:@"解绑后您将不能再通过该手机号登录，确定要解绑吗？" cancelTitle:@"取消" viewController:nil confirm:^(NSInteger buttonTag) {
        if (buttonTag == 0) {
            //确定解绑，跳转下一页
            [TargetEngine controller:self pushToController:PushTargetSafetyInspection WithTargetId:nil];
        }
        
    } buttonTitles:@"确定", nil];
    
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


@implementation AccountSecurityCell

-(void)dosetup
{
    [super dosetup];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _nameLabel = [UILabel new];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel leftToView:self.contentView withSpace:15];
    [_nameLabel yCenterToView:self.contentView];
    
    
  
    
    
    UIImageView *rightImageView = [[UIImageView alloc] init];
    rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    rightImageView.image = UIImageWithFileName(@"chevron-right-12");
    [self.contentView addSubview:rightImageView];
    [rightImageView yCenterToView:self.contentView];
    [rightImageView rightToView:self.contentView withSpace:15];
    
    
    _detailLabel = [UILabel new];
    _detailLabel.text = @"";
    _detailLabel.textColor = kColorMainViceTextColor;
    _detailLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
    [self.contentView addSubview:_detailLabel];
    [_detailLabel rightToView:rightImageView withSpace:5];
    [_detailLabel yCenterToView:self.contentView];
    
}
-(void)makeCellData:(NSString*)title withDetail:(NSString*)detail
{
    _nameLabel.text = title;
    _detailLabel.text = detail;
}

@end


