//
//  NearbyAreaSystemController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/19.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "NearbyAreaSystemController.h"
#import "WWTableView.h"
#import "CGXPickerView.h"


@interface NearbyAreaSystemController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) WWTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;


@end
@interface NearbyAreaSystemCell : WWTableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIImageView *chooseImageView;
@property (nonatomic,strong) UIImageView *rightImageView;


-(void)makeCellData:(NSDictionary*)dic;

@end


@implementation NearbyAreaSystemController

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
    [_tableView registerClass:[NearbyAreaSystemCell class] forCellReuseIdentifier:[NearbyAreaSystemCell getCellIDStr]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"区域显示设置";
    NSArray *arr =@[
                    @[
                        @{@"title":@"列表区域足迹范围",@"choose":@(YES),@"detail":@"0 - 100米",@"rightImage":@(NO)},
                        ],
                    @[
                        @{@"title":@"最近一天",@"choose":@(NO),@"detail":@"",@"rightImage":@(YES)},
                        @{@"title":@"最近七天",@"choose":@(YES),@"detail":@"",@"rightImage":@(YES)},
                        @{@"title":@"最近一个月",@"choose":@(YES),@"detail":@"",@"rightImage":@(YES)},
                        @{@"title":@"最近三个月",@"choose":@(YES),@"detail":@"",@"rightImage":@(YES)},
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
    
    NearbyAreaSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:[NearbyAreaSystemCell getCellIDStr] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lineHidden = NO;
    
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    [cell makeCellData:dic];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [self.dataArray objectAtIndex:indexPath.section];
    
    if (indexPath.section == 1) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:array];
        
        
        [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dic = obj;
            NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            [mutDic setObject:@(YES) forKey:@"choose"];
            [tempArray replaceObjectAtIndex:idx withObject:mutDic];
        }];
        
        NSDictionary *dic = [tempArray objectAtIndex:indexPath.row];
        NSDictionary *newDic = @{@"title":[dic objectForKey:@"title"],@"choose":@(NO),@"detail":@"",@"rightImage":@(YES)};
        [tempArray replaceObjectAtIndex:indexPath.row withObject:newDic];
        [self.dataArray replaceObjectAtIndex:1 withObject:tempArray];
        DLog(@"数据源 ==  %@",self.dataArray);
        [self.tableView reloadData];
        
    }else{
       
        NSArray *arr = @[@"0 - 100米",@"0 - 500米",@"0 - 10000米",@"0 - 100000米"];
        
        
        [CGXPickerView showStringPickerWithTitle:@" " DataSource:arr DefaultSelValue:nil IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
            
            NSArray *array = @[
                             @{@"title":@"列表区域足迹范围",@"choose":@(YES),@"detail":selectValue,@"rightImage":@(NO)},
                             ];
            [self.dataArray replaceObjectAtIndex:0 withObject:array];
            [self.tableView reloadData];
            
        }];
    }
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

@implementation NearbyAreaSystemCell

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
    
    
    
    
    _rightImageView = [[UIImageView alloc] init];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    _rightImageView.image = UIImageWithFileName(@"chevron-right-12");
    [self.contentView addSubview:_rightImageView];
    [_rightImageView yCenterToView:self.contentView];
    [_rightImageView rightToView:self.contentView withSpace:15];
    
    
    _detailLabel = [UILabel new];
    _detailLabel.text = @"";
    _detailLabel.textColor = kColorMainViceTextColor;
    _detailLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
    [self.contentView addSubview:_detailLabel];
    [_detailLabel rightToView:_rightImageView withSpace:5];
    [_detailLabel yCenterToView:self.contentView];
    
    
    
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
    
    BOOL isRightImage = [[dic objectForKey:@"rightImage"] boolValue];
    _detailLabel.hidden = isRightImage;
    _rightImageView.hidden = isRightImage;
    _detailLabel.text = [dic objectForKey:@"detail"];
    
}
@end

