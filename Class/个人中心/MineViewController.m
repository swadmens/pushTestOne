//
//  MineViewController.m
//  YanGang
//
//  Created by 汪伟 on 2018/11/7.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "MineViewController.h"
#import "MineCenterTopView.h"
#import "WWTableView.h"
#import "MineCenterCell.h"

static NSString *_normalHeaderIdentifier = @"mine.center.header.normal";

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    BOOL _isHadFirst; // 是否第一次加载了
}
@property (nonatomic, strong) WWTableView *tableView;

@property (nonatomic,strong) NSArray *iconArray;
@property (nonatomic,strong) NSArray *titleArray;


@end

@implementation MineViewController
- (void)setupTableView
{
    self.tableView = [[WWTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 88;
    [self.view addSubview:self.tableView];
    [self.tableView alignTop:@"-20" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MineCenterCell class] forCellReuseIdentifier:[MineCenterCell getCellIDStr]];
    //    self.tableView.refreshEnable = YES;
    //    __unsafe_unretained typeof(self) weak_self = self;
    //    self.tableView.actionHandle = ^(WWScrollingState state){
    //        switch (state) {
    //                case WWScrollingStateRefreshing:
    //            {
    //                //                [weak_self loadNewData];
    //            }
    //                break;
    //                case WWScrollingStateLoadingMore:
    //            {
    //                //                [weak_self loadMoreData];
    //            }
    //                break;
    //            default:
    //                break;
    //        }
    //    };
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我";
    self.FDPrefersNavigationBarHidden = YES;
    [self setupTableView];
    
//    UIImage *aimage = UIImageWithFileName(@"icon_back_gray");
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setImage:aimage forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(action_goback) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    [button topToView:self.view withSpace:30];
//    [button leftToView:self.view withSpace:15];
    
    self.iconArray = @[@"mine_friend_images",@"mine_collect_images",@"mine_system_images"];
    self.titleArray = @[@"我的好友",@"我的收藏",@"设置"];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.iconArray.count;
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MineCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:[MineCenterCell getCellIDStr] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lineHidden = NO;
    
    NSString *icons = [self.iconArray objectAtIndex:indexPath.row];
    NSString *titles = [self.titleArray objectAtIndex:indexPath.row];
    
    [cell makeCellData:icons withTitle:titles];
    
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MineCenterTopView *headerView = [[MineCenterTopView alloc]initWithReuseIdentifier:_normalHeaderIdentifier];
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kScreenWidth/2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [TargetEngine controller:nil pushToController:PushTargetMyFriendsView WithTargetId:nil];

    }else if (indexPath.row == 1)
    {
        //我的收藏
        [TargetEngine controller:nil pushToController:PushTargetMineCollects WithTargetId:nil];

    }else{
        [TargetEngine controller:nil pushToController:PushTargetSystemView WithTargetId:nil];
    }
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
