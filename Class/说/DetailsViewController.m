//
//  DetailsViewController.m
//  YanGang
//
//  Created by 汪伟 on 2018/11/7.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "DetailsViewController.h"
#import "FootprintNearbyController.h"
#import "FootprintFocusController.h"
#import "FootprintRecommendController.h"
#import "LGXMenuView.h"
#import "TabContentView.h"


@interface DetailsViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UISearchBar *searchButton;


@property (nonatomic,strong) LGXMenuView *menSelView;

@property (nonatomic,strong)TabContentView *tabContent;


@end

@implementation DetailsViewController
- (UISearchBar *)searchButton
{
    if (!_searchButton) {
        _searchButton = [UISearchBar new];
    }
    return _searchButton;
}
- (void)setupViews
{
    
    /// 顶部搜索的
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor clearColor];
    CGFloat height = kNavigationSearchHeight;
    self.contentView.frame = CGRectMake(0, 0, kScreenWidth - 30, height);
    self.navigationItem.titleView = self.contentView;
    
    self.searchButton = [UISearchBar new];
    self.searchButton.placeholder = @"搜索足迹";
    self.searchButton.barStyle = UISearchBarStyleMinimal;
    self.searchButton.delegate = self;
    UITextField *searchField1 = [self.searchButton valueForKey:@"_searchField"];
    searchField1.backgroundColor = kColorBackgroundColor;
    searchField1.textColor=kColorMainViceTextColor;
    searchField1.font=[UIFont customFontWithSize:kFontSizeFourteen];
    searchField1.layer.cornerRadius=4;
    searchField1.layer.masksToBounds=YES;
    [searchField1 setValue:kColorMainViceTextColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.searchButton setTintColor:kColorMainViceTextColor];
    [self.contentView addSubview:self.searchButton];
    self.searchButton.frame=CGRectMake(40, 0, kScreenWidth - 120, 32);
    
    
    //    //延迟将输入框变为第一响应者，解决一些IQKey的问题
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [searchField1 becomeFirstResponder];
    //    });
    
    //右上角，添加
    UIImage *addImage = UIImageWithFileName(@"says_adds_image");
    CGSize size = addImage.size;
    UIButton *button = [UIButton new];
    [button setImage:addImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    button.frame = CGRectMake(kScreenWidth - 65, -5, size.width, size.height);
    
    
    
    //左上角，消息
    UIImage *msgImage = UIImageWithFileName(@"says_msg_image");
    CGSize msgSize = msgImage.size;
    UIButton *msgButton = [UIButton new];
    [msgButton setImage:msgImage forState:UIControlStateNormal];
    [msgButton addTarget:self action:@selector(msgButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:msgButton];
    msgButton.frame = CGRectMake(0, 5, msgSize.width, msgSize.height);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"说";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=nil;
//    self.FDPrefersNavigationBarHidden = YES;
    
    [self setupViews];
    [self setupTopTitleView];

}

- (void)setupTopTitleView
{
    if (self.menSelView != nil) {
        return;
    }
    NSArray *arr = @[
                     @"附近",
                     @"关注",
                     @"推荐",
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
    
    NSString *topSpace = @"0";
    if (IS_IPHONEX) {
        topSpace = @"15";
    }
    
    [self.menSelView alignTop:topSpace leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    

    _tabContent=[[TabContentView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tabContent];
    [_tabContent topToView:self.menSelView];
    [_tabContent leftToView:self.view];
    [_tabContent rightToView:self.view];
    [_tabContent bottomToView:self.view];
    
    
    NSMutableArray *contents=[[NSMutableArray alloc]initWithCapacity:4];
  
    
    FootprintNearbyController *newVc=[FootprintNearbyController new];
//    newVc.type = @"0";
    
    
    FootprintFocusController *hotVc=[FootprintFocusController new];
//    hotVc.type = @"1";
    
    FootprintRecommendController *nearVc=[FootprintRecommendController new];
//    nearVc.type = @"2";
    
    [contents addObject:newVc];
    [contents addObject:hotVc];
    [contents addObject:nearVc];
    
    
    [_tabContent configParam:contents Index:0 block:^(NSInteger index) {
        self.menSelView.currentIndex = index;
    }];
    
}

/// 点击了
- (void)didMenuChosedIndex:(NSInteger)index
{
    [_tabContent updateTab:index];
}
//点击了添加
-(void)addButtonClick
{
    //如果登录了跳转足迹发布页，如果未登录跳转登录页
    //    if (_kUserModel.isLogined) {
    [TargetEngine controller:nil pushToController:PushTargetReleaseFootprints WithTargetId:nil];
    //    }else{
    //        [_kUserModel showLoginView];
    //    }
}
//点击了消息
-(void)msgButtonClick
{
    [TargetEngine controller:nil pushToController:PushTargetMessagesView WithTargetId:nil];
}


@end
