//
//  IndexViewController.m
//  YanGang
//
//  Created by 汪伟 on 2018/11/7.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "IndexViewController.h"
#import "HotPlacesView.h"
#import "CustomAnnotationView.h"
#import "ConversionLocation.h"


@interface IndexViewController ()<BMKMapViewDelegate,CLLocationManagerDelegate,UIGestureRecognizerDelegate,BMKGeoFenceManagerDelegate,BMKLocationServiceDelegate>

@property(nonatomic,strong) BMKMapView *mapView;
@property (nonatomic,strong) BMKLocationService* locService;
@property (nonatomic) CLLocationCoordinate2D coordinateMine;

@property (nonatomic,strong) HotPlacesView *hotPlaceView;
@property (nonatomic,strong) UIView *coverView;

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *pointArr;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"听";
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.leftBarButtonItem = nil;
    self.FDPrefersNavigationBarHidden = YES;
    
    
    _mapView = [BMKMapView new];
    [self.view addSubview:_mapView];
    [_mapView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];

    //地图缩放级别
    [_mapView setZoomLevel:16.5];

    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = BMKUserTrackingModeNone;


    //隐藏比例尺和指南针,精度圈
    _mapView.showMapScaleBar = NO;
    _mapView.rotateEnabled = NO;   //此属性用于地图旋转手势的开启和关闭

//    //隐藏精度圈
//    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
//    param.isAccuracyCircleShow = NO;
//    [_mapView updateLocationViewWithParam:param];

    _mapView.overlookEnabled = YES;
    _mapView.delegate = self;
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    
    
    BMKPointAnnotation* annotation1 = [[BMKPointAnnotation alloc]init];
    annotation1.coordinate = CLLocationCoordinate2DMake(23.138188, 113.382376);
    annotation1.subtitle = @"111";
    
    BMKPointAnnotation* annotation2 = [[BMKPointAnnotation alloc]init];
    annotation2.coordinate = CLLocationCoordinate2DMake(23.132474, 113.387644);
    annotation2.subtitle = @"222";
    
    BMKPointAnnotation* annotation3 = [[BMKPointAnnotation alloc]init];
    annotation3.coordinate = CLLocationCoordinate2DMake(23.126874, 113.373540);
    annotation3.subtitle = @"333";
    
    BMKPointAnnotation* annotation4 = [[BMKPointAnnotation alloc]init];
    annotation4.coordinate = CLLocationCoordinate2DMake(23.118609, 113.371546);
    annotation4.subtitle = @"444";
    
    BMKPointAnnotation* annotation5 = [[BMKPointAnnotation alloc]init];
    annotation5.coordinate = CLLocationCoordinate2DMake(23.136007, 113.374304);
    annotation5.subtitle = @"555";
    
    BMKPointAnnotation* annotation6 = [[BMKPointAnnotation alloc]init];
    annotation6.coordinate = CLLocationCoordinate2DMake(23.127671, 113.383923);
    annotation6.subtitle = @"666";
    
    BMKPointAnnotation* annotation7 = [[BMKPointAnnotation alloc]init];
    annotation7.coordinate = CLLocationCoordinate2DMake(23.133757, 113.379611);
    annotation7.subtitle = @"777";
    
    BMKPointAnnotation* annotation8 = [[BMKPointAnnotation alloc]init];
    annotation8.coordinate = CLLocationCoordinate2DMake(23.128615, 113.395449);
    annotation8.subtitle = @"888";
    
    NSArray *annotations = @[annotation1,annotation2,annotation3,annotation4,annotation5,annotation6,annotation7,annotation8];
    
    [_mapView addAnnotations:annotations];
    
    
    
    [self creadUI];
    
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    
//    //判断用户是否在中国
//    BOOL isChina = [ConversionLocation isLocationOutOfChina:userLocation.location.coordinate];
//    if (isChina) {//在中国
//        //百度坐标转GCJ坐标再转WGS坐标
//        CLLocationCoordinate2D clCoord = [ConversionLocation transformFromBaiduToGCJ:userLocation.location.coordinate];
//        self.coordinateMine = [ConversionLocation transformFromGCJToWGS:clCoord];
//        self.mapView.centerCoordinate = [ConversionLocation transformFromGCJToWGS:clCoord];
//    }else{
        self.mapView.centerCoordinate = userLocation.location.coordinate;
        self.coordinateMine = userLocation.location.coordinate;
//    }
    
    [_locService stopUserLocationService];
}
- (void)didStopLocatingUser
{
//    [self startLoadDataRequest];
}


-(void)creadUI
{
    
    _coverView = [UIView new];
    _coverView.hidden = YES;
    _coverView.userInteractionEnabled = YES;
    _coverView.backgroundColor = UIColorFromRGB(0x000000, 0.5);
    _coverView.frame = CGRectMake(-0, 0, kScreenWidth, kScreenHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:_coverView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCoverViewClick:)];
    [_coverView addGestureRecognizer:tap];
    
    
    UIButton *uploadBtn = [UIButton new];
    [uploadBtn setImage:UIImageWithFileName(@"index_mid_adds") forState:UIControlStateNormal];
    [uploadBtn setBGColor:kColorMainColor forState:UIControlStateNormal];
    [self.view addSubview:uploadBtn];
    [uploadBtn xCenterToView:self.view];
    [uploadBtn bottomToView:self.view withSpace:10];
    [uploadBtn addWidth:58];
    [uploadBtn addHeight:58];
    [uploadBtn addTarget:self action:@selector(uploadDataClick) forControlEvents:UIControlEventTouchUpInside];
    uploadBtn.clipsToBounds = YES;
    uploadBtn.layer.cornerRadius = 29;
    
    
    //当前位置
    UIView *dqMineView = [UIView new];
    dqMineView.layer.shadowColor = [UIColor blackColor].CGColor;
    dqMineView.layer.shadowOffset = CGSizeMake(0, 0);
    dqMineView.layer.shadowOpacity = 0.1f;
    dqMineView.backgroundColor = UIColorClearColor;
    [self.view addSubview:dqMineView];
    [dqMineView bottomToView:self.view withSpace:65];
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
   
    
    //热门按钮
    UIView *hotsView = [UIView new];
    hotsView.layer.shadowColor = [UIColor blackColor].CGColor;
    hotsView.layer.shadowOffset = CGSizeMake(0, 0);
    hotsView.layer.shadowOpacity = 0.1f;
    hotsView.backgroundColor = UIColorClearColor;
    [self.view addSubview:hotsView];
    [hotsView topToView:self.view withSpace:35];
    [hotsView leftToView:self.view withSpace:10];
    [hotsView addWidth:40];
    [hotsView addHeight:40];
    
    
    UIButton *hotBtn = [UIButton new];
    hotBtn.clipsToBounds = YES;
    hotBtn.layer.cornerRadius = 20;
    [hotBtn setBGColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [hotBtn setImage:UIImageWithFileName(@"index_hots_image") forState:UIControlStateNormal];
    [hotBtn addTarget:self action:@selector(hotClassClick) forControlEvents:UIControlEventTouchUpInside];
    [hotsView addSubview:hotBtn];
    [hotBtn alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:hotsView];
    
    
    
    
    UIView *topRightView = [UIView new];
    topRightView.layer.cornerRadius = 20;
    topRightView.backgroundColor = [UIColor whiteColor];
    topRightView.layer.shadowColor = [UIColor blackColor].CGColor;
    topRightView.layer.shadowOffset = CGSizeMake(0, 0);
    topRightView.layer.shadowOpacity = 0.1f;
    [self.view addSubview:topRightView];
    [topRightView topToView:self.view withSpace:35];
    [topRightView rightToView:self.view withSpace:10];
    [topRightView addWidth:40];
    [topRightView addHeight:130];
    
    
    //附近的足迹按钮
    UIButton *NearbeyBtn = [UIButton new];
    [NearbeyBtn setImage:UIImageWithFileName(@"index_nearby_image") forState:UIControlStateNormal];
    [NearbeyBtn addTarget:self action:@selector(NearbeyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topRightView addSubview:NearbeyBtn];
    [NearbeyBtn topToView:topRightView withSpace:10];
    [NearbeyBtn xCenterToView:topRightView];
    
    
    //消息按钮
    UIButton *messageBtn = [UIButton new];
    [messageBtn setImage:UIImageWithFileName(@"index_msg_image") forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(MessageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topRightView addSubview:messageBtn];
    [messageBtn centerToView:topRightView];
    
    
    //设置按钮
    UIButton *ShowSystemBtn = [UIButton new];
    [ShowSystemBtn setImage:UIImageWithFileName(@"index_system_image") forState:UIControlStateNormal];
    [ShowSystemBtn addTarget:self action:@selector(ShowSystemsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topRightView addSubview:ShowSystemBtn];
    [ShowSystemBtn bottomToView:topRightView withSpace:10];
    [ShowSystemBtn xCenterToView:topRightView];
    
    
    
}
-(void)uploadDataClick
{
//    [_kHUDManager showMsgInView:nil withTitle:@"点击上传足迹" isSuccess:YES];
    
    //如果登录了跳转足迹发布页，如果未登录跳转登录页
//    if (_kUserModel.isLogined) {
//        [TargetEngine controller:nil pushToController:PushTargetReleaseFootprints WithTargetId:nil];
//    }else{
        [_kUserModel showLoginView];
//    }

}
-(void)mineCenterClick
{
    self.mapView.centerCoordinate = self.coordinateMine;

}
//热门
-(void)hotClassClick
{
    _hotPlaceView = [HotPlacesView new];
    _hotPlaceView.frame = CGRectMake(-270, 0, 270, kScreenHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:_hotPlaceView];
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.hidden = NO;
        self.hotPlaceView.frame = CGRectMake(0, 0, 270, kScreenHeight);
    }];
    __unsafe_unretained typeof(self) weak_self = self;
    _hotPlaceView.timeSystemClick = ^{
        [weak_self hideCoverViewClick:nil];
        [TargetEngine controller:nil pushToController:PushTargetTimeSystem WithTargetId:nil];
    };
}
-(void)hideCoverViewClick:(UITapGestureRecognizer*)tp
{
    self.coverView.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.hotPlaceView.frame = CGRectMake(-270, 0, 270, kScreenHeight);
    }];
}
//附近的人
-(void)NearbeyBtnClick
{
    [TargetEngine controller:nil pushToController:PushTargetNearbyPeoples WithTargetId:nil];
}
//消息
-(void)MessageBtnClick
{
    [TargetEngine controller:nil pushToController:PushTargetMessagesView WithTargetId:nil];
}
//设置按钮
-(void)ShowSystemsBtnClick
{
    [TargetEngine controller:nil pushToController:PushTargetShowTimeSystem WithTargetId:nil];    
}

//单击地图空白处获取经纬度
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    DLog(@"经度 ===  %f,纬度  ===  %f",coordinate.longitude,coordinate.latitude);
}

//大头针
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKUserLocation class]]) {//定位蓝点
        return nil;
    }
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        BMKPointAnnotation *ano = annotation;
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
//        NSMutableArray *tempPon = [NSMutableArray arrayWithCapacity:_dataArray.count];
//        [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NearThrMapModel *models = obj;
//            if ([ano.subtitle isEqualToString:models.device_id]) {
//                [annotationView makeViewData:models];
//                [tempPon addObject:annotationView];
//            }
//        }];
//
//        self.pointArr = [NSMutableArray arrayWithArray:tempPon];
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(2, 2,40, 50);
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.enabled = YES;
        annotationView.userInteractionEnabled = YES;
        //如果想传值，我们可以这样
        btn.tag = [ano.subtitle integerValue];
        [annotationView addSubview:btn];
        
        return annotationView;
        
    }
    return nil;
}
-(void)btnAction:(UIButton *)sender
{
    
    [TargetEngine controller:nil pushToController:PushTargetFootprintDetails WithTargetId:nil];

    
//    NSString *titles = [NSString stringWithFormat:@"点击了%ld号大头针",(long)sender.tag];
//    [_kHUDManager showMsgInView:nil withTitle:titles isSuccess:YES];
    
    
//    //这样就可以输出你想要传的ID值了
//    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NearThrMapModel *model = (NearThrMapModel*)obj;
//        if (sender.tag == [model.device_id integerValue] ) {
//            self.selectModel = [self.dataArray objectAtIndex:idx];
//        }
//    }];
//
//    //跳转到足迹详情页
//    NSString *pushid = [NSString stringWithFormat:@"%@&%@",self.selectModel.user_id,@"pet_circle_friends"];
//    [TargetEngine controller:nil pushToController:PushTargetFamiliarFriendInfor WithTargetId:pushid];
    
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
