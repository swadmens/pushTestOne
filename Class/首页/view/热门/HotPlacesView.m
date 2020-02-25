//
//  HotPlacesView.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/6.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "HotPlacesView.h"
#import "WWTableView.h"
#import "HotPlacesCell.h"

@interface HotPlacesView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) WWTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end


@implementation HotPlacesView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorMainColor;
        [self creadUI];
    }
    return self;
}
-(void)creadUI
{
    _tableView = [[WWTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.userInteractionEnabled = YES;
    _tableView.clipsToBounds = YES;
    _tableView.estimatedRowHeight = 45;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    [_tableView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self];
    [_tableView registerClass:[HotPlacesCell class] forCellReuseIdentifier:[HotPlacesCell getCellIDStr]];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSDictionary *dic =[self.dataArray objectAtIndex:section];
//    NSArray *arr = [dic objectForKey:@"details"];
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    HotPlacesCell *cell = [tableView dequeueReusableCellWithIdentifier:[HotPlacesCell getCellIDStr] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell makeCellData:indexPath.row];
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = kColorBackgroundColor;
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = @"热门回复排行top10";
    nameLabel.textColor = kColorMainTextColor;
    nameLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
    [headerView addSubview:nameLabel];
    [nameLabel leftToView:headerView withSpace:15];
    [nameLabel yCenterToView:headerView];
    
  
    UIButton *systemBtn = [UIButton new];
    [systemBtn setImage:UIImageWithFileName(@"index_left_system_image") forState:UIControlStateNormal];
    [systemBtn addTarget:self action:@selector(systemBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:systemBtn];
    [systemBtn yCenterToView:headerView];
    [systemBtn rightToView:headerView withSpace:15];
   
    
    if (section == 1) {
        nameLabel.text = @"热门点击排行top10";
        systemBtn.hidden = YES;
    }
        
    
    
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//跳转设置
-(void)systemBtnClick
{
    if (_timeSystemClick) {
        self.timeSystemClick();
    }
}
    
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
