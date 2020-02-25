//
//  FriendsFootprintController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/19.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "FriendsFootprintController.h"
#import "FriendsFootprintHeaderView.h"
#import "WWTableView.h"
#import "FootprintIndexCell.h"

static NSString *_normalHeaderIdentifier = @"foot.header.normal";


@interface FriendsFootprintController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    BOOL _isHadFirst; // 是否第一次加载了
}
@property (nonatomic, strong) WWTableView *tableView;

@end

@implementation FriendsFootprintController

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
    [self.tableView registerClass:[FootprintIndexCell class] forCellReuseIdentifier:[FootprintIndexCell getCellIDStr]];
    self.tableView.refreshEnable = YES;
    __unsafe_unretained typeof(self) weak_self = self;
    self.tableView.actionHandle = ^(WWScrollingState state){
        switch (state) {
                case WWScrollingStateRefreshing:
            {
                //                [weak_self loadNewData];
            }
                break;
                case WWScrollingStateLoadingMore:
            {
                //                [weak_self loadMoreData];
            }
                break;
            default:
                break;
        }
    };
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.FDPrefersNavigationBarHidden = YES;
    [self setupTableView];
    
    UIImage *aimage = UIImageWithFileName(@"icon_back_gray");
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:aimage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(action_goback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button topToView:self.view withSpace:30];
    [button leftToView:self.view withSpace:15];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return 2;
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FootprintIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:[FootprintIndexCell getCellIDStr] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FriendsFootprintHeaderView *headerView = [[FriendsFootprintHeaderView alloc]initWithReuseIdentifier:@"headerViewMy"];
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kScreenWidth/2;
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
