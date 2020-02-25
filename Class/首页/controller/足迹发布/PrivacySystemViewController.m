//
//  PrivacySystemViewController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/24.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "PrivacySystemViewController.h"
#import "WWTableView.h"

@interface PrivacySystemViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) WWTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@interface PrivacySystemCell : WWTableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *chooseImageView;

-(void)makeCellData:(NSDictionary*)dic;

@end

@implementation PrivacySystemViewController
-(void)steupTableView
{
    _tableView = [[WWTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.userInteractionEnabled = YES;
    _tableView.clipsToBounds = YES;
    _tableView.estimatedRowHeight = 45;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    [_tableView registerClass:[PrivacySystemCell class] forCellReuseIdentifier:[PrivacySystemCell getCellIDStr]];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"隐私设置";
    
    
    //右上角
    UIButton *button = [UIButton new];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [button setTitleColor:kColorMainTextColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBut;
    
    
    NSArray *arr =@[
                    @[
                        @{@"title":@"所有人可见",@"choose":@(NO)},
                        @{@"title":@"我的好友可见",@"choose":@(YES)},
                        @{@"title":@"私密（仅自己可见）",@"choose":@(YES)},
                        @{@"title":@"陌生人可见",@"choose":@(YES)},
                        @{@"title":@"不给谁看",@"choose":@(YES)},
                        ],
                    @[
                        @{@"title":@"所有人可评论",@"choose":@(NO)},
                        @{@"title":@"我的好友可评论",@"choose":@(YES)},
                        @{@"title":@"陌生人可评论",@"choose":@(YES)},
                        @{@"title":@"不给谁评论",@"choose":@(YES)},
                        ]
                    ];

    self.dataArray = [NSMutableArray arrayWithArray:arr];
    
    [self steupTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [self.dataArray objectAtIndex:section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *array = [self.dataArray objectAtIndex:indexPath.section];
    
    PrivacySystemCell *cell = [tableView dequeueReusableCellWithIdentifier:[PrivacySystemCell getCellIDStr] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lineHidden = NO;
    
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    [cell makeCellData:dic];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [self.dataArray objectAtIndex:indexPath.section];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:array];
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [mutDic setObject:@(YES) forKey:@"choose"];
        [tempArray replaceObjectAtIndex:idx withObject:mutDic];
    }];
    
    NSDictionary *dic = [tempArray objectAtIndex:indexPath.row];
    NSDictionary *newDic = @{@"title":[dic objectForKey:@"title"],@"choose":@(NO)};
    [tempArray replaceObjectAtIndex:indexPath.row withObject:newDic];
    [self.dataArray replaceObjectAtIndex:indexPath.section withObject:tempArray];
    DLog(@"数据源 ==  %@",self.dataArray);
    [self.tableView reloadData];
        
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*headerView = [UIView new];
    headerView.backgroundColor = UIColorClearColor;
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView*footerView = [UIView new];
    footerView.backgroundColor = UIColorClearColor;
    
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

//完成
-(void)doneButtonClick
{
    [_kHUDManager showMsgInView:nil withTitle:@"选择好了" isSuccess:YES];
    [self.navigationController popViewControllerAnimated:YES];
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

@implementation PrivacySystemCell

-(void)dosetup
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"最近一天";
    _titleLabel.textColor = UIColorFromRGB(0x000000, 1);
    _titleLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel topToView:self.contentView withSpace:14];
    [_titleLabel bottomToView:self.contentView withSpace:14];
    [_titleLabel leftToView:self.contentView withSpace:15];
    
    
    _chooseImageView = [UIImageView new];
    _chooseImageView.image = UIImageWithFileName(@"choose_right_images");;
    [self.contentView addSubview:_chooseImageView];
    [_chooseImageView yCenterToView:_titleLabel];
    [_chooseImageView rightToView:self.contentView withSpace:15];
  
    
}
-(void)makeCellData:(NSDictionary*)dic
{
    _titleLabel.text = [dic objectForKey:@"title"];
    BOOL isHide = [[dic objectForKey:@"choose"] boolValue];
    _chooseImageView.hidden = isHide;
}
@end
