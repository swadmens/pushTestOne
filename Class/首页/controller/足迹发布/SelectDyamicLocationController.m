//
//  SelectDyamicLocationController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/28.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "SelectDyamicLocationController.h"
#import "SelectDyamicLocationCell.h"
#import "WWTableView.h"

@interface SelectDyamicLocationController ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>

@property(nonatomic,strong) BMKMapView *mapView;
@property (nonatomic,strong) BMKGeoCodeSearch *search;
@property (nonatomic,strong) BMKPoiSearch *search2;

@property(nonatomic,strong) BMKPointAnnotation *annotation;//大头针
@property(nonatomic,strong) NSString *mapCoordinate;
@property(nonatomic,strong) BMKGeoFenceManager *geoFenceManager;
@property (nonatomic,strong) BMKLocationService* locService;


@property (nonatomic, strong) WWTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *choseArray;


@property (nonatomic, strong) NSString *region;
@property (nonatomic) CLLocationCoordinate2D coordinateMine;
@property (nonatomic,assign) CLLocationCoordinate2D centerPointSelf;

@end

@implementation SelectDyamicLocationController

-(void)setupTableView
{
    self.tableView = [[WWTableView alloc] init];
    self.tableView.frame = CGRectMake(0,kScreenHeight, kScreenWidth, 240);
    self.tableView.backgroundColor = kColorBackgroundColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60.0;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[SelectDyamicLocationCell class] forCellReuseIdentifier:[SelectDyamicLocationCell getCellIDStr]];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectDyamicLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:[SelectDyamicLocationCell getCellIDStr] forIndexPath:indexPath];
    cell.lineHidden = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BMKPoiInfo *poi = [self.dataArray objectAtIndex:indexPath.row];
    [cell makeCellData:poi.name withDetail:poi.address];
    
    NSString *chose = [_choseArray objectAtIndex:indexPath.row];
    [cell makeChoseCell:chose];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_choseArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.choseArray replaceObjectAtIndex:idx withObject:@"0"];
    }];
    
    [_choseArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    [self.tableView reloadData];
    
    BMKPoiInfo *poi = [self.dataArray objectAtIndex:indexPath.row];
    self.region = poi.name;
    self.coordinateMine = poi.pt;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择地点";
    
    //右上角
    UIButton *button = [UIButton new];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [button setTitleColor:kColorMainTextColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sureChosePlaceClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBut;
    

    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    _mapView = [BMKMapView new];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    [_mapView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    
    //地图缩放级别
    [_mapView setZoomLevel:17];
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    
    
    //隐藏比例尺和指南针
    _mapView.showMapScaleBar = NO;
    
    //隐藏精度圈
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
    param.isAccuracyCircleShow = NO;
    [_mapView updateLocationViewWithParam:param];
    
    
    //初始化大头针
    self.annotation = [[BMKPointAnnotation alloc]init];
    
    
    //添加点击手势识别
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
    [gestureRecognizer setDelegate:self];
    [_mapView addGestureRecognizer:gestureRecognizer];
    
    
    //选择地址处理
    _choseArray = [NSMutableArray arrayWithObjects:@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    
    _search = [[BMKGeoCodeSearch alloc]init];
    _search.delegate = self;
    
    
    //当前位置
    UIView *dqMineView = [UIView new];
    dqMineView.layer.shadowColor = [UIColor blackColor].CGColor;
    dqMineView.layer.shadowOffset = CGSizeMake(0, 0);
    dqMineView.layer.shadowOpacity = 0.1f;
    dqMineView.backgroundColor = UIColorClearColor;
    [self.view addSubview:dqMineView];
    [dqMineView bottomToView:self.view withSpace:255];
    [dqMineView rightToView:self.view withSpace:10];
    [dqMineView addWidth:40];
    [dqMineView addHeight:40];
    
    
    UIButton *mineBtn = [UIButton new];
    mineBtn.clipsToBounds = YES;
    mineBtn.layer.cornerRadius = 20;
    [mineBtn setBGColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mineBtn setImage:UIImageWithFileName(@"index_center_image") forState:UIControlStateNormal];
    [mineBtn addTarget:self action:@selector(mineCenterClick) forControlEvents:UIControlEventTouchUpInside];
    [dqMineView addSubview:mineBtn];
    [mineBtn alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:dqMineView];
    
    
    //附近位置搜索
    [self setupTableView];
}
-(void)mineCenterClick
{
    self.mapView.centerCoordinate = self.centerPointSelf;
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _search.delegate = nil;
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    self.centerPointSelf = userLocation.location.coordinate;
    
    self.mapView.centerCoordinate = self.centerPointSelf;
    [self initSearchResult:self.centerPointSelf.latitude AndLongitude:self.centerPointSelf.longitude];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(0,kScreenHeight - 304, kScreenWidth, 240);
    }];
    
    [_locService stopUserLocationService];
}

//单击地图
#pragma mark - 允许多手势响应
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
//点击地图时的回调
-(void)gestureAction:(UIGestureRecognizer *)gestureRecognizer {
    //    CGPoint point = [gestureRecognizer locationOfTouch:0 inView:_mapView];
    //    NSLog(@"Tap at:%f,%f", point.x, point.y);
    [self.mapView removeAnnotation:self.annotation];
    //坐标转换
    CGPoint touchPoint = [gestureRecognizer locationInView:_mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
    
    self.annotation.coordinate = touchMapCoordinate;
    NSLog(@"longitude ======== %f",touchMapCoordinate.longitude);
    NSLog(@"latitude ======== %f",touchMapCoordinate.latitude);
    
    [self.mapView addAnnotation:self.annotation];
    
    [self initSearchResult:touchMapCoordinate.latitude AndLongitude:touchMapCoordinate.longitude];
}

//点击地图，搜索附近位置信息
-(void)initSearchResult:(CLLocationDegrees)latitude AndLongitude:(CLLocationDegrees)longitude
{
    if (_search == nil) {
        
        [[TCNewAlertView shareInstance] showAlert:NSLocalizedString(@"locationFailed", nil) message:NSLocalizedString(@"unableObtainLocInfo", nil) cancelTitle:nil viewController:nil confirm:^(NSInteger buttonTag) {
        } buttonTitles:NSLocalizedString(@"sure", nil), nil];
        
        return;
    }
    
    //    _search2 =[[BMKPoiSearch alloc]init];
    //    _search2.delegate = self;    //发起检索
    //    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    //    option.pageIndex = 1;  //当前索引页
    //    option.pageCapacity = 10; //分页量
    //    option.location = CLLocationCoordinate2DMake(latitude, longitude);
    //    option.keyword = @"街道";
    //    option.radius = 300000;
    //    BOOL flag = [_search2 poiSearchNearBy:option];
    //    if(flag)     {
    //        NSLog(@"周边检索发送成功");
    //    }    else     {
    //        NSLog(@"周边检索发送失败");
    //    }
    
    
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D)CLLocationCoordinate2DMake(latitude, longitude);
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_search reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //        在此处理正常结果
        
        //        BMKPoiInfo *poiFirst = [BMKPoiInfo new];
        //        poiFirst.name = result.addressDetail.city;
        //        poiFirst.address = @"";
        //        poiFirst.pt = self.annotation.coordinate;
        
        _dataArray = [NSMutableArray arrayWithArray:poiResultList.poiInfoList];
        
        //        [_dataArray insertObject:poiFirst atIndex:0];
        
        [self.tableView reloadData];
        
        //默认选择第一个数据
        BMKPoiInfo *poi = [self.dataArray firstObject];
        self.region = poi.name;
        self.coordinateMine = poi.pt;
        
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}
//实现Deleage处理回调结果
//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //        在此处理正常结果
        
        BMKPoiInfo *poiFirst = [BMKPoiInfo new];
        poiFirst.name = result.addressDetail.city;
        poiFirst.address = @"";
        poiFirst.pt = self.annotation.coordinate;
        
        _dataArray = [NSMutableArray arrayWithArray:result.poiList];
        
        [_dataArray insertObject:poiFirst atIndex:0];
        
        [self.tableView reloadData];
        
        //默认选择第一个数据
        BMKPoiInfo *poi = [self.dataArray firstObject];
        self.region = poi.name;
        self.coordinateMine = poi.pt;
        
    }
    else {
        DLog(@"抱歉，未找到结果");
    }
}
//确定选择地点
-(void)sureChosePlaceClick
{
//    //判断用户是否在中国
//    BOOL isChina = [ConversionLocation isLocationOutOfChina:self.coordinateMine];
//    if (isChina) {//在中国
//        //百度坐标转GCJ坐标再转WGS坐标
//        CLLocationCoordinate2D clCoord = [ConversionLocation transformFromBaiduToGCJ:self.coordinateMine];
//        self.coordinateMine = [ConversionLocation transformFromGCJToWGS:clCoord];
//    }
//
    [self.delegate sendValue:self.coordinateMine withid:self.region];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
