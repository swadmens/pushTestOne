//
//  MineCollectsController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/28.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "MineCollectsController.h"
#import "WWTableView.h"
#import "RequestSence.h"
#import "FootprintIndexCell.h"
#import "PetCircleRequestSence.h"

@interface MineCollectsController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isHadFirst; // 是否第一次加载了
}
@property (nonatomic, strong) WWTableView *tableView;


@property (nonatomic, strong) PetCircleRequestSence *requetSence;


@property (nonatomic,strong) UILabel *searchLabel;

@property (nonatomic,strong) NSMutableArray *dataArray;//通讯录数据源
@property (strong, nonatomic) NSMutableArray *searchDataSource;/**<搜索结果数据源*/

/// 没有内容
@property (nonatomic, strong) UIView *noDataView;

@end

@implementation MineCollectsController
- (void)setupNoDataView
{
    self.noDataView = [self setupnoDataContentViewWithTitle:nil andImageNamed:@"pet_circle_empty_image" andTop:@"60"];
    
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

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setupTableView
{
    self.tableView = [[WWTableView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 88;
    [self.view addSubview:self.tableView];
    [self.tableView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
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
    self.title = @"我的收藏";
    
    [self setupTableView];
    [self setupNoDataView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    FootprintIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:[FootprintIndexCell getCellIDStr] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lineHidden=NO;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [TargetEngine controller:nil pushToController:PushTargetFootprintDetails WithTargetId:nil];
}
-(void)reloadDataIfNeed
{
    [self loadNewData];
}
-(void)reloadMoreDataIfNeed
{
    [self loadMoreData];
}
- (void)loadNewData
{
    //    [_kHUDManager showActivityInView:nil withTitle:nil];
    
    self.requetSence.page = 1;
    [self loadData];
}
- (void)loadMoreData
{
    [self loadData];
}
-(void)loadData
{
    [self.requetSence sendRequest];
}
- (PetCircleRequestSence *)requetSence
{
    if (!_requetSence) {
        _requetSence = [[PetCircleRequestSence alloc] init];
        __unsafe_unretained typeof(self) weak_self = self;
        _requetSence.successBlock = ^(id obj) {
            [weak_self requestSuccessed:obj];
        };
        _requetSence.errorBlock = ^(NSError *error) {
            [weak_self requsetFailed:error];
        };
    }
    return _requetSence;
}
- (void)requestSuccessed:(id)obj
{
    if (obj==nil) {
        return;
    }
    _isHadFirst = YES;
    [_kHUDManager hideAfter:0.1 onHide:nil];
    [[GCDQueue globalQueue] queueBlock:^{
        NSDictionary *data = [obj objectForKey:@"data"];
        
        NSArray *user_dynamics = [data objectForKey:@"user_dynamics"];
        NSMutableArray *userTemp = [NSMutableArray arrayWithCapacity:user_dynamics.count];
        NSMutableArray *userFullTemp = [NSMutableArray arrayWithCapacity:user_dynamics.count];
        
        [user_dynamics enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            //            PetCircleModel *model = [PetCircleModel makePetCircleModel:dic];
            //            [userTemp addObject:model];
            //            NSDictionary *fullDic = @{
            //                                      @"fulltext":@"1",
            //                                      };
            //            FullTextMomentModel *fullModel = [FullTextMomentModel makeFullTextMomentModelData:fullDic];
            //            [userFullTemp addObject:fullModel];
        }];
        
        
        if (self.requetSence.page == 1) {
            
            NSArray *recommend_friends = [data objectForKey:@"recommend_friends"];
            if (recommend_friends.count > 0 && [self.requetSence.type isEqualToString:@"2"]) {
                NSMutableArray *recomTemp = [NSMutableArray arrayWithCapacity:recommend_friends.count];
                [recommend_friends enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
                    //                    RecommendFriendsModel *model = [RecommendFriendsModel makeRecommendFriendsModelModel:dic];
                    //                    [recomTemp addObject:model];
                }];
                //                [self.RecommendArray removeAllObjects];
                //                self.RecommendArray = [NSMutableArray arrayWithArray:recomTemp];
                
            }else{
                //                [self.RecommendArray removeAllObjects];
            }
            
            [self.dataArray removeAllObjects];
            //            [self.dataFullArray removeAllObjects];
        }
        
        [self.dataArray addObjectsFromArray:userTemp];
        //        [self.dataFullArray addObjectsFromArray:userFullTemp];
        
        
        
        [[GCDQueue mainQueue] queueBlock:^{
            
     
            [self.tableView reloadData];
            
        }];
    }];
}
- (void)requsetFailed:(NSError *)error
{
    _isHadFirst = YES;
    [_kHUDManager hideAfter:0.1 onHide:nil];
    [[GCDQueue mainQueue] queueBlock:^{
        //        self.tableView.loadingMoreEnable = NO;
        //        [self.tableView stopLoading];
        [self changeNoDataViewHiddenStatus];
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
        //        self.isFrist = NO;
    } else {
        self.tableView.hidden = NO;
        self.noDataView.hidden = YES;
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
