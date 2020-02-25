
//
//  FootprintDetailsViewController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/6.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "FootprintDetailsViewController.h"
#import "WWTableView.h"
#import "FootprintDetailsCell.h"
#import "FootprintCommentsCell.h"
#import "LGXHorizontalButton.h"
#import "LGXThirdEngine.h"
#import "ShareSDKMethod.h"

@interface FootprintDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) WWTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *placeLabel;
@property (nonatomic,strong) UIImageView *titleImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *dateLabel;

@property (nonatomic,assign) BOOL isMyself;//是否是自己的
@property (nonatomic, strong) LGXShareParams *shareParams;


@end

@implementation FootprintDetailsViewController

-(void)setupNavView
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    [headerView alignTop:@"0" leading:@"0" bottom:nil trailing:@"0" toView:self.view];
    [headerView addHeight:65];
    
    
    UIImage *aimage = UIImageWithFileName(@"icon_back_gray");
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:aimage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(action_goback) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
    [button bottomToView:headerView withSpace:13];
    [button leftToView:headerView withSpace:13];
    
    
    
    _titleImageView = [UIImageView new];
    _titleImageView.image = [UIImage imageWithColor:[UIColor blackColor]];
    _titleImageView.clipsToBounds = YES;
    _titleImageView.layer.cornerRadius = 15;
    [headerView addSubview:_titleImageView];
    [_titleImageView yCenterToView:button];
    [_titleImageView leftToView:button withSpace:15];
    [_titleImageView addWidth:30];
    [_titleImageView addHeight:30];
    
    
    _nameLabel = [UILabel new];
    _nameLabel.text = @"MARK";
    _nameLabel.textColor = kColorMainTextColor;
    _nameLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
    [headerView addSubview:_nameLabel];
    [_nameLabel leftToView:_titleImageView withSpace:8];
    [_nameLabel addCenterY:-8 toView:_titleImageView];
    
    
    _dateLabel = [UILabel new];
    _dateLabel.text = @"10-10";
    _dateLabel.textColor = kColorMainViceTextColor;
    _dateLabel.font = [UIFont customFontWithSize:kFontSizeTwelve];
    [headerView addSubview:_dateLabel];
    [_dateLabel leftToView:_titleImageView withSpace:8];
    [_dateLabel addCenterY:8 toView:_titleImageView];
    
    
    
    UIButton *rightBtn1 = [UIButton new];
    [rightBtn1 setImage:UIImageWithFileName(@"detail_share_images") forState:UIControlStateNormal];
    [rightBtn1 setTitleColor:kColorMainColor forState:UIControlStateNormal];
    rightBtn1.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [rightBtn1 addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:rightBtn1];
    [rightBtn1 yCenterToView:button];
    [rightBtn1 rightToView:headerView withSpace:15];
    
    
    UIButton *rightBtn2 = [UIButton new];
    rightBtn2.clipsToBounds = YES;
    rightBtn2.layer.cornerRadius = 10;
    [rightBtn2 setBGColor:kColorMainColor forState:UIControlStateNormal];
    [rightBtn2 setTitle:@"关注" forState:UIControlStateNormal];
    [rightBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn2.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [rightBtn2 addTarget:self action:@selector(focusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:rightBtn2];
    [rightBtn2 yCenterToView:button];
    [rightBtn2 rightToView:rightBtn1 withSpace:10];
    [rightBtn2 addWidth:55];
    [rightBtn2 addHeight:20];
}
-(void)setupBottomView
{
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    [footerView alignTop:nil leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    [footerView addHeight:50];
    
    UIButton *rightBtn1 = [UIButton new];
    [rightBtn1 setImage:UIImageWithFileName(@"detail_likes_images") forState:UIControlStateNormal];
    [rightBtn1 setTitleColor:kColorMainColor forState:UIControlStateNormal];
    rightBtn1.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [rightBtn1 addTarget:self action:@selector(likeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:rightBtn1];
    [rightBtn1 yCenterToView:footerView];
    [rightBtn1 rightToView:footerView withSpace:12];
    
    
    UIButton *rightBtn2 = [UIButton new];
    [rightBtn2 setImage:UIImageWithFileName(@"detail_collect_images") forState:UIControlStateNormal];
    [rightBtn2 setTitleColor:kColorMainColor forState:UIControlStateNormal];
    rightBtn2.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [rightBtn2 addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:rightBtn2];
    [rightBtn2 yCenterToView:footerView];
    [rightBtn2 rightToView:rightBtn1 withSpace:22];
    
    
    UIButton *rightBtn3 = [UIButton new];
    [rightBtn3 setTitle:@"发布" forState:UIControlStateNormal];
    [rightBtn3 setTitleColor:kColorMainColor forState:UIControlStateNormal];
    rightBtn3.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [rightBtn3 addTarget:self action:@selector(releaseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:rightBtn3];
    [rightBtn3 yCenterToView:footerView];
    [rightBtn3 rightToView:rightBtn2 withSpace:22];
    
    
    
    UITextField *contentField = [UITextField new];
    contentField.placeholder = @"   快和大家分享你想说的~";
    contentField.backgroundColor = kColorBackSecondColor;
    contentField.textColor = kColorMainTextColor;
    contentField.font = [UIFont customFontWithSize:kFontSizeTwelve];
    contentField.clipsToBounds = YES;
    contentField.layer.cornerRadius = 15;
    [footerView addSubview:contentField];
    [contentField yCenterToView:footerView];
    [contentField leftToView:footerView withSpace:13];
    [contentField addWidth:kScreenWidth - 165];
    [contentField addHeight:30];
    
    
    
}
-(void)setupTabelView
{
    _tableView = [[WWTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.userInteractionEnabled = YES;
    _tableView.clipsToBounds = YES;
    _tableView.estimatedRowHeight = 45;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView alignTop:@"65" leading:@"0" bottom:@"52" trailing:@"0" toView:self.view];
    [_tableView registerClass:[FootprintDetailsCell class] forCellReuseIdentifier:[FootprintDetailsCell getCellIDStr]];
    [_tableView registerClass:[FootprintCommentsCell class] forCellReuseIdentifier:[FootprintCommentsCell getCellIDStr]];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.FDPrefersNavigationBarHidden = YES;
    
    [self setupTabelView];
    [self setupNavView];
    [self setupBottomView];

}
//分享
-(void)shareBtnClick
{
    [_kHUDManager showMsgInView:nil withTitle:@"分享的操作！！！" isSuccess:YES];
    
    [TargetEngine controller:self pushToController:PushTargetFooterprintsToReport WithTargetId:nil];
    
    
    return;
    //分享里面的内容
    self.shareParams = [[LGXShareParams alloc] init];
//    [self.shareParams makeShreParamsByData:self.model.share];
    
    
    [ShareSDKMethod ShareTextActionWithParams:self.shareParams IsBlack:!_isMyself IsReport:!_isMyself IsDelete:_isMyself Black:^{
        DLog(@"拉黑");
//        [self shiedTheContentClick];
    } Report:^{
        DLog(@"举报");
//        [self deleteTheContentClick];
    } Delete:^{
        DLog(@"删除");
//        [self deleteTheContentClick];
    } Result:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
    }];
}
//关注
-(void)focusBtnClick
{
    
}
//点赞
-(void)likeBtnClick
{
    
}
//收藏
-(void)collectBtnClick
{
    
}
//发布
-(void)releaseBtnClick
{
    
}

#pragma mark - UITabelViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSDictionary *dic =[self.dataArray objectAtIndex:section];
    //    NSArray *arr = [dic objectForKey:@"details"];
    if (section == 0) {
        return 3;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        FootprintDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:[FootprintDetailsCell getCellIDStr] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        FootprintCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:[FootprintCommentsCell getCellIDStr] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
  
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerView = [UIView new];
        headerView.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [UILabel new];
        _titleLabel.text = @"惠州巽寮湾一日游";
        _titleLabel.textColor = kColorMainTextColor;
        _titleLabel.font = [UIFont customFontWithSize:kFontSizeEighTeen];
        [headerView addSubview:_titleLabel];
        [_titleLabel yCenterToView:headerView];
        [_titleLabel leftToView:headerView withSpace:13];
        
        UIImageView *loImageView = [UIImageView new];
        loImageView.image = UIImageWithFileName(@"detail_location_images");
        [headerView addSubview:loImageView];
        [loImageView leftToView:_titleLabel withSpace:5];
        [loImageView addCenterY:2 toView:headerView];
        
        
        _placeLabel = [UILabel new];
        _placeLabel.text = @"惠州巽寮湾";
        _placeLabel.textColor = kColorMainViceTextColor;
        _placeLabel.font = [UIFont customFontWithSize:kFontSizeTwelve];
        [headerView addSubview:_placeLabel];
        [_placeLabel addCenterY:4 toView:headerView];
        [_placeLabel leftToView:loImageView withSpace:5];
        
        
        
        return headerView;
    }else{
        UIView *headerView = [UIView new];
        headerView.backgroundColor = [UIColor whiteColor];
        
       
        
        UIImageView *loImageView = [UIImageView new];
        loImageView.image = [UIImage imageWithColor:[UIColor redColor]];
        loImageView.clipsToBounds = YES;
        loImageView.layer.cornerRadius = 16;
        [headerView addSubview:loImageView];
        [loImageView leftToView:headerView withSpace:12];
        [loImageView yCenterToView:headerView];
        [loImageView addWidth:32];
        [loImageView addHeight:32];
        
        UILabel *nameLabel = [UILabel new];
        nameLabel.text = @"MARK";
        nameLabel.textColor = kColorMainColor;
        nameLabel.font = [UIFont customFontWithSize:kFontSizeFourteen];
        [headerView addSubview:nameLabel];
        [nameLabel addCenterY:-8 toView:headerView];
        [nameLabel leftToView:loImageView withSpace:5];
        
        
        UILabel *detaLabel = [UILabel new];
        detaLabel.text = @"12-12";
        detaLabel.textColor = kColorMainViceTextColor;
        detaLabel.font = [UIFont customFontWithSize:kFontSizeTwelve];
        [headerView addSubview:detaLabel];
        [detaLabel addCenterY:8 toView:headerView];
        [detaLabel leftToView:loImageView withSpace:5];
        
        
        UIButton *moreBtn = [UIButton new];
        [moreBtn setImage:UIImageWithFileName(@"comment_more_image") forState:UIControlStateNormal];
        [headerView addSubview:moreBtn];
        [moreBtn yCenterToView:nameLabel];
        [moreBtn rightToView:headerView withSpace:5];
        [moreBtn addWidth:40];
        [moreBtn addHeight:30];
        
        
        
        LGXHorizontalButton *likeBtn = [LGXHorizontalButton new];
        [likeBtn setImage:UIImageWithFileName(@"comment_likes_image") forState:UIControlStateNormal];
        [likeBtn setTitle:@"99" forState:UIControlStateNormal];
        [likeBtn setTitleColor:kColorSecondTextColor forState:UIControlStateNormal];
        likeBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
        [headerView addSubview:likeBtn];
        [likeBtn yCenterToView:nameLabel];
        [likeBtn rightToView:moreBtn withSpace:5];
        
        return headerView;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *footView = [UIView new];
        footView.backgroundColor = [UIColor whiteColor];
        [footView addTopLineByColor:kColorLineColor];
        
        UILabel *lineLabel = [UILabel new];
        lineLabel.backgroundColor = kColorMainColor;
        lineLabel.clipsToBounds = YES;
        lineLabel.layer.cornerRadius = 2;
        [footView addSubview:lineLabel];
        [lineLabel leftToView:footView withSpace:12];
        [lineLabel yCenterToView:footView];
        [lineLabel addWidth:4];
        [lineLabel addHeight:15];
        
        
        UILabel *commentLabel = [UILabel new];
        commentLabel.text = @"评论 15";
        commentLabel.textColor = kColorSecondTextColor;
        commentLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
        [footView addSubview:commentLabel];
        [commentLabel yCenterToView:footView];
        [commentLabel leftToView:lineLabel withSpace:5];
        
        
        
        return footView;
    }else  if (section == 4){
        UIView *footView = [UIView new];
        footView.backgroundColor = [UIColor whiteColor];
        [footView addTopLineByColor:kColorLineColor];

        
        UIButton *moreBtn = [UIButton new];
        [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [moreBtn setTitleColor:kColorMainColor forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
        [moreBtn addTarget:self action:@selector(lookMoreButton) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:moreBtn];
        [moreBtn centerToView:footView];
        
        
        return footView;
    }else{
        UIView *footView = [UIView new];
        footView.backgroundColor = UIColorClearColor;
    
        
        return footView;
    }
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 || section == 4) {
        return 45;
    }
    return 0.1;
}
-(void)lookMoreButton
{
    [TargetEngine controller:nil pushToController:PushTargetAllComments WithTargetId:nil];
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
