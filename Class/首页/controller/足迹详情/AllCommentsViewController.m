//
//  AllCommentsViewController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/20.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "AllCommentsViewController.h"
#import "WWTableView.h"
#import "FootprintCommentsCell.h"
#import "LGXHorizontalButton.h"

@interface AllCommentsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) WWTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation AllCommentsViewController

-(void)setupBottomView
{
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    [footerView alignTop:nil leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    [footerView addHeight:50];
    
    UIButton *rightBtn3 = [UIButton new];
    [rightBtn3 setTitle:@"发布" forState:UIControlStateNormal];
    [rightBtn3 setTitleColor:kColorMainColor forState:UIControlStateNormal];
    rightBtn3.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
    [rightBtn3 addTarget:self action:@selector(releaseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:rightBtn3];
    [rightBtn3 yCenterToView:footerView];
    [rightBtn3 rightToView:footerView withSpace:22];
    
    
    
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
    [contentField addWidth:kScreenWidth - 75];
    [contentField addHeight:30];
}

-(void)releaseBtnClick
{
    
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
    [_tableView alignTop:@"0" leading:@"0" bottom:@"52" trailing:@"0" toView:self.view];
    [_tableView registerClass:[FootprintCommentsCell class] forCellReuseIdentifier:[FootprintCommentsCell getCellIDStr]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"全部评论 15";
    [self setupTabelView];
    [self setupBottomView];

}
#pragma mark - UITabelViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSDictionary *dic =[self.dataArray objectAtIndex:section];
    //    NSArray *arr = [dic objectForKey:@"details"];
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    FootprintCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:[FootprintCommentsCell getCellIDStr] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

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
    detaLabel.text = @"12-22";
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
   
    UIView *footView = [UIView new];
    footView.backgroundColor = UIColorClearColor;
    
    return footView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
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
