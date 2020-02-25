//
//  SystemViewController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/10.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "SystemViewController.h"
#import "WWTableView.h"
#import "WWTableViewCell.h"
#import "JXActionSheet.h"



@interface SystemViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) WWTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end


@interface SystemViewCell : WWTableViewCell

@property (nonatomic,strong) UILabel *nameLabel;
-(void)makeCellData:(NSString*)title;


@end


@implementation SystemViewController
- (void)setupTableView
{
    self.tableView = [[WWTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UIColorClearColor;
    [self.view addSubview:self.tableView];
    [self.tableView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[SystemViewCell class] forCellReuseIdentifier:[SystemViewCell getCellIDStr]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    [self setupTableView];
    
    
    NSArray *array = @[
                       @[@{
                             @"title":@"个人资料"
                             },],
                       @[@{
                             @"title":@"账户与安全"
                             },@{
                             @"title":@"版本检测"
                             },],
                       @[@{
                             @"title":@"退出登录"
                             },],
                       ];
    self.dataArray = [NSMutableArray arrayWithArray:array];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [self.dataArray objectAtIndex:section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SystemViewCell getCellIDStr] forIndexPath:indexPath];
    cell.lineHidden=NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = [self.dataArray objectAtIndex:indexPath.section];
    NSDictionary *dict = [array objectAtIndex:indexPath.row];
    NSString *title = [dict objectForKey:@"title"];
    [cell makeCellData:title];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //个人资料
        [TargetEngine controller:nil pushToController:PushTargetPersonalInforView WithTargetId:nil];
    }else if (indexPath.section == 2){
        //退出登录
        [self loginOut];
    }else{
        if (indexPath.row == 0) {
            //账户安全
            [TargetEngine controller:nil pushToController:PushTargetAccountSecurity WithTargetId:nil];

        }else{
            //版本更新
        }
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
   
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
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

- (void)loginOut
{
    JXActionSheet *sheet = [[JXActionSheet alloc] initWithTitle:@"确定退出吗？" cancelTitle:@"点错了" otherTitles:@[@"确定退出"]];
    sheet.destructiveButtonIndex = 0;
    [sheet showView];
    [sheet dismissForCompletionHandle:^(NSInteger clickedIndex, BOOL isCancel) {
        if (isCancel) {
            return ;
        }
//        [self didLoginOut];
    }];
}
- (void)didLoginOut
{
    [_kUserModel loginOutWhenSuccessed:^{
        
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isClickLoginOut"];
        [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"isClickLoginOut"];
        
        [self.navigationController popToRootViewControllerAnimated:YES];

    }];
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


@implementation SystemViewCell

-(void)dosetup
{
    [super dosetup];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _nameLabel = [UILabel new];
    _nameLabel.text = @"";
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
    
}
-(void)makeCellData:(NSString*)title
{
    _nameLabel.text = title;
}

@end
