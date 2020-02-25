//
//  MyFriendsViewController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/7.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "MyFriendsViewController.h"
#import "MyFriendsCell.h"
#import "WWTableView.h"
#import "RequestSence.h"

@interface MyFriendsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    BOOL _isHadFirst; // 是否第一次加载了
}
@property (nonatomic, strong) WWTableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *searchDataSource;


@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UISearchBar *searchButton;

@property (assign, nonatomic) BOOL isSearch;

/// 没有内容
@property (nonatomic, strong) UIView *noDataView;

@end

@implementation MyFriendsViewController
- (UISearchBar *)searchButton
{
    if (!_searchButton) {
        _searchButton = [UISearchBar new];
    }
    return _searchButton;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)searchDataSource
{
    if (!_searchDataSource) {
        _searchDataSource = [NSMutableArray array];
    }
    return _searchDataSource;
}
- (void)setupViews
{
    /// 顶部搜索的
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = kColorBackSecondColor;
    self.contentView.frame = CGRectMake(0, 0, kScreenWidth, 60);
    [self.view addSubview:self.contentView];
    
    self.searchButton = [UISearchBar new];
    self.searchButton.placeholder = @"搜索全部联系人";
    self.searchButton.barStyle = UISearchBarStyleMinimal;
    self.searchButton.delegate = self;
    UITextField *searchField1 = [self.searchButton valueForKey:@"_searchField"];
    searchField1.backgroundColor = [UIColor whiteColor];
    searchField1.textColor = kColorMainViceTextColor;
    searchField1.font = [UIFont customFontWithSize:kFontSizeFourteen];
    searchField1.layer.cornerRadius = 4;
    searchField1.layer.masksToBounds = YES;
    [searchField1 setValue:kColorMainViceTextColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.searchButton setTintColor:kColorMainViceTextColor];
    [self.contentView addSubview:self.searchButton];
    UIImage *image = [UIImage imageWithColor:[UIColor clearColor]];
    UIImage *searchBGImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 30.0, 0.0, 40.0) resizingMode:UIImageResizingModeStretch];
    [self.searchButton setBackgroundImage:searchBGImage];
    self.searchButton.frame = CGRectMake(8, 15, kMainScreenSize.width-16, 32);
    
}
- (void)setupNoDataView
{
    self.noDataView = [self setupnoDataContentViewWithTitle:nil andImageNamed:@"empty_txl_addfriend" andTop:@"112"];
    // label
    UILabel *tipLabel = [self getNoDataTipLabel];
    
    UILabel *titleLabel=[UILabel new];
    titleLabel.text = @"暂无好友";
    titleLabel.numberOfLines = 0;
    titleLabel.textColor=kColorMainTextColor;
    titleLabel.font=[UIFont customFontWithSize:kFontSizeFourteen];
    [titleLabel sizeToFit];
    [self.noDataView addSubview:titleLabel];
    [titleLabel addCenterX:0 toView:self.noDataView];
    [titleLabel topToView:tipLabel withSpace:-8];
}
- (void)setupTableView
{
    self.tableView = [[WWTableView alloc] init];
    self.tableView.backgroundColor = kColorBackSecondColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    [self.view addSubview:self.tableView];
    [self.tableView alignTop:@"60" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MyFriendsCell class] forCellReuseIdentifier:[MyFriendsCell getCellIDStr]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"联系人";
    
//    //右上角
//    UIButton *button = [UIButton new];
//    [button setTitle:@"消息" forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
//    [button setTitleColor:kColorMainColor forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(messageButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem = rightBut;
    
    
    [self setupViews];
    [self setupTableView];
    
}
-(void)messageButtonClick
{
    
}

#pragma mark - UITabeleViewDataSource
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (!_isSearch) {
//        return [[self.letterResultArr objectAtIndex:section] count];
//    }else{
//        return self.searchDataSource.count;
//    }
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyFriendsCell getCellIDStr] forIndexPath:indexPath];
    cell.lineHidden=NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    if (!_isSearch) {
//        MinePetFriendsModel *model= [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//        [cell makeCellData:model];
//    }else{
//        MinePetFriendsModel *model= [self.searchDataSource  objectAtIndex:indexPath.row];
//        [cell makeCellData:model];
//    }
    
    return cell;
    
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
