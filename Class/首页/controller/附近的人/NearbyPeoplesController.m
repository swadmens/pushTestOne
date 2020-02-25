//
//  NearbyPeoplesController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/6.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "NearbyPeoplesController.h"
#import "NearbyPeoplesCell.h"
#import "WWTableView.h"
#import "RequestSence.h"
#import "JXActionSheet.h"
#import "LGXMenuView.h"


@interface NearbyPeoplesController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate,UISearchBarDelegate>
{
    BOOL _isHadFirst; // 是否第一次加载了
}
@property (nonatomic, strong) WWTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic,assign) NSInteger page;
/// 没有内容
@property (nonatomic, strong) UIView *noDataView;

@property (nonatomic,strong) NSString *sexType;//筛选

@property (nonatomic) CLLocationCoordinate2D coordinateMine;
@property (nonatomic,strong) BMKLocationService* locService;

@property (nonatomic,strong) LGXMenuView *menSelView;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UISearchBar *searchButton;


@end

@implementation NearbyPeoplesController
- (UISearchBar *)searchButton
{
    if (!_searchButton) {
        _searchButton = [UISearchBar new];
    }
    return _searchButton;
}
- (void)setupNoDataView
{
    self.noDataView = [self setupnoDataContentViewWithTitle:nil andImageNamed:@"empty_message_image" andTop:@"45"];
    
    // label
    UILabel *tipLabel = [self getNoDataTipLabel];
    
    UILabel *titleLabel=[UILabel new];
    titleLabel.text = @"暂无数据";
    titleLabel.numberOfLines = 0;
    titleLabel.textColor=kColorMainTextColor;
    titleLabel.font=[UIFont customFontWithSize:kFontSizeFourteen];
    [titleLabel sizeToFit];
    [self.noDataView addSubview:titleLabel];
    [titleLabel addCenterX:0 toView:self.noDataView];
    [titleLabel topToView:tipLabel withSpace:-8];
    
}
- (void)setupViews
{
    /// 顶部搜索的
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = kColorBackSecondColor;
    self.contentView.frame = CGRectMake(0, 0, kMainScreenSize.width, 60);
    [self.view addSubview:self.contentView];
    
    self.searchButton = [UISearchBar new];
    self.searchButton.placeholder = @"搜索";
    self.searchButton.barStyle = UISearchBarStyleMinimal;
    self.searchButton.delegate = self;
    UITextField *searchField1 = [self.searchButton valueForKey:@"_searchField"];
    searchField1.backgroundColor = [UIColor whiteColor];
    searchField1.textColor=kColorMainViceTextColor;
    searchField1.font=[UIFont customFontWithSize:kFontSizeFourteen];
    searchField1.layer.cornerRadius=4;
    searchField1.layer.masksToBounds=YES;
    [searchField1 setValue:kColorMainViceTextColor forKeyPath:@"_placeholderLabel.textColor"];
    //    searchField1.placeholder = NSLocalizedString(@"searching", nil);
    [self.searchButton setTintColor:kColorMainViceTextColor];
    [self.contentView addSubview:self.searchButton];
    UIImage *image=[UIImage imageWithColor:[UIColor clearColor]];
    UIImage *searchBGImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 30.0, 0.0, 40.0) resizingMode:UIImageResizingModeStretch];
    [self.searchButton setBackgroundImage:searchBGImage];
    self.searchButton.frame=CGRectMake(8, 15, kMainScreenSize.width-16, 32);
    
}
- (void)setupTableView
{
    self.tableView = [[WWTableView alloc] init];
    self.tableView.backgroundColor = kColorBackSecondColor;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    [self.tableView alignTop:@"100" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[NearbyPeoplesCell class] forCellReuseIdentifier:[NearbyPeoplesCell getCellIDStr]];
    self.tableView.refreshEnable = YES;
    __unsafe_unretained typeof(self) weak_self = self;
    self.tableView.actionHandle = ^(WWScrollingState state){
        switch (state) {
                case WWScrollingStateRefreshing:
            {
                [weak_self loadNewData];
            }
                break;
                case WWScrollingStateLoadingMore:
            {
                [weak_self loadMoreData];
            }
                break;
            default:
                break;
        }
    };
}
- (void)setupTopTitleView
{
    if (self.menSelView != nil) {
        return;
    }
    NSArray *arr = @[
                     @"综合",
                     @"点击数",
                     @"时间",
                     @"回复数",
                     ];
    self.menSelView = [[LGXMenuView alloc] init];
    self.menSelView.lineColor=kColorMainColor;
    self.menSelView.textColor=kColorMainTextColor;
    self.menSelView.chosedTextColor=kColorMainColor;
    self.menSelView.choseLineFloat = 100;
    CGRect rect = self.navigationController.navigationBar.frame;
    CGFloat width = arr.count * 100.0;
    self.menSelView.frame = CGRectMake(0, 0, width, CGRectGetHeight(rect));
    __unsafe_unretained typeof(self) weak_self = self;
    self.menSelView.didChangedIndex = ^(NSInteger index) {
        [weak_self didMenuChosedIndex:index];
    };
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i =0; i<arr.count  ; i++) {
        LMenuModel *model = [[LMenuModel alloc] init];
        model.title = [arr objectAtIndex:i];
        [tempArr addObject:model];
    }
    
    [self.menSelView reloadMenuWith:[NSArray arrayWithArray:tempArr]];
    [self.view addSubview:self.menSelView];
    [self.menSelView addBottomLineByColor:kColorLineColor];
    [self.menSelView addHeight:45];
    
    NSString *topSpace = @"55";
    if (IS_IPHONEX) {
        topSpace = @"70";
    }
    
    [self.menSelView alignTop:topSpace leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    
}
- (void)didMenuChosedIndex:(NSInteger)index
{
    [_kHUDManager showMsgInView:nil withTitle:@"排序刷新数据" isSuccess:YES];
}
-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"附近的足迹";
    
    //右上角
    UIButton *button = [UIButton new];
    [button setImage:UIImageWithFileName(@"detail_share_images") forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [button setTitleColor:kColorMainTextColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(moreOptionsClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBut;
    
    self.sexType = @"2";
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    [self setupViews];
    [self setupTopTitleView];
    [self setupNoDataView];
    [self setupTableView];
}
-(void)viewWillDisappear:(BOOL)animated {
    _locService.delegate = nil;
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    //判断用户是否在中国
//    BOOL isChina = [ConversionLocation isLocationOutOfChina:userLocation.location.coordinate];
//    if (isChina) {//在中国
//        //百度坐标转GCJ坐标再转WGS坐标
//        CLLocationCoordinate2D clCoord = [ConversionLocation transformFromBaiduToGCJ:userLocation.location.coordinate];
//        self.coordinateMine = [ConversionLocation transformFromGCJToWGS:clCoord];
//    }else{
        self.coordinateMine = userLocation.location.coordinate;
//    }
    [_locService stopUserLocationService];
}
- (void)didStopLocatingUser
{
//    [self.tableView startRefresh];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.dataArray.count;
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NearbyPeoplesCell *cell = [tableView dequeueReusableCellWithIdentifier:[NearbyPeoplesCell getCellIDStr] forIndexPath:indexPath];
    cell.lineHidden=NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    NearbyTheManViewModel *model = [self.dataArray objectAtIndex:indexPath.row];
//    [cell makeCellData:model];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NearbyTheManViewModel *model = [self.dataArray objectAtIndex:indexPath.row];
//    NSString *pushid = [NSString stringWithFormat:@"%@&%@",model.user_id,@"pet_circle_friends"];
    [TargetEngine controller:nil pushToController:PushTargetFriendsFootprint WithTargetId:nil];
}

- (void)loadNewData
{
    self.page = 1;
//    [self loadData];
    [self.tableView stopLoading];
}
- (void)loadMoreData
{
//    [self loadData];
}
-(void)loadData
{
    [self startLoadDataRequest];
}
- (void)startLoadDataRequest
{
    [_kHUDManager showActivityInView:nil withTitle:nil];
    RequestSence *sence = [[RequestSence alloc] init];
    sence.pathURL = @"users/nearby";
    sence.params = [NSMutableDictionary dictionary];
    [sence.params setObject:@(self.page) forKey:@"page"];
    [sence.params setObject:@"10" forKey:@"limit"];
    [sence.params setObject:self.sexType forKey:@"sex"];
    [sence.params setObject:@(self.coordinateMine.longitude) forKey:@"longitude"];
    [sence.params setObject:@(self.coordinateMine.latitude) forKey:@"latitude"];
    NSString *sign = [WWPublicMethod makeAlphabeticOrdering:sence.params];
    [sence.params setValue:sign forKey:kSignKey];
    __unsafe_unretained typeof(self) weak_self = self;
    sence.successBlock = ^(id obj) {
        
        [weak_self handleObject:obj];
    };
    sence.errorBlock = ^(NSError *error) {
        [weak_self failedOperation];
    };
    [sence sendRequest];
}
- (void)failedOperation
{
    _isHadFirst = YES;
    [_kHUDManager hideAfter:0.1 onHide:nil];
    [_kHUDManager showMsgInView:nil withTitle:@"请求失败" isSuccess:NO];
    self.tableView.loadingMoreEnable = NO;
    [self.tableView stopLoading];
    [self changeNoDataViewHiddenStatus];
}
- (void)handleObject:(id)obj
{
    _isHadFirst = YES;
    [_kHUDManager hideAfter:0.1 onHide:nil];
    __unsafe_unretained typeof(self) weak_self = self;
    [[GCDQueue globalQueue] queueBlock:^{
        NSArray *data = [obj objectForKey:@"data"];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        if (weak_self.page == 1) {
            [weak_self.dataArray removeAllObjects];
        }
        
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dic = obj;
//            NearbyTheManViewModel *model = [NearbyTheManViewModel makeNearbyTheManViewModelData:dic];
//            [tempArray addObject:model];
        }];
        [weak_self.dataArray addObjectsFromArray:tempArray];
        
        
        [[GCDQueue mainQueue] queueBlock:^{
            
            if (tempArray.count == 0) {
                [_kHUDManager showMsgInView:nil withTitle:[obj objectForKey:@"msg"] isSuccess:YES];
            }
            [weak_self.tableView reloadData];
            if (tempArray.count >0) {
                weak_self.page++;
                weak_self.tableView.loadingMoreEnable = YES;
            } else {
                weak_self.tableView.loadingMoreEnable = NO;
            }
            [weak_self.tableView stopLoading];
            [weak_self changeNoDataViewHiddenStatus];
        }];
    }];
}
- (void)changeNoDataViewHiddenStatus
{
    if (_isHadFirst == NO) {
        return ;
    }
    
    NSInteger count = self.dataArray.count;
    if (count == 0) {
        self.tableView.hidden = YES;
        self.noDataView.hidden = NO;
    } else {
        self.tableView.hidden = NO;
        self.noDataView.hidden = YES;
    }
    
}

//右上角
-(void)moreOptionsClick
{
//    JXActionSheet *sheet = [[JXActionSheet alloc] initWithTitle:nil cancelTitle:@"取消" otherTitles:@[@"查看全部",@"只看女生",@"只看男生",]];
//    //    sheet.destructiveButtonIndex = 0;
//    [sheet showView];
//    [sheet dismissForCompletionHandle:^(NSInteger clickedIndex, BOOL isCancel) {
//        if (isCancel) {
//            return ;
//        }
//        if (clickedIndex == 0) {
//            self.sexType = @"2";
//        }else if (clickedIndex == 1){
//            self.sexType = @"0";
//        }else if (clickedIndex == 2){
//            self.sexType = @"1";
//        }
//        [self loadNewData];
//    }];
    
    
    [TargetEngine controller:nil pushToController:PushTargetNearbyAreaSystem WithTargetId:nil];
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
