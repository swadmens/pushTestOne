//
//  ShowTimeSystemController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/18.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "ShowTimeSystemController.h"
#import "WWTableView.h"

@interface ShowTimeSystemController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) WWTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@interface ShowTimeSystemViewCell : WWTableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *chooseImageView;
-(void)makeCellData:(NSDictionary*)dic;

@end


@implementation ShowTimeSystemController
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
    [_tableView registerClass:[ShowTimeSystemViewCell class] forCellReuseIdentifier:[ShowTimeSystemViewCell getCellIDStr]];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"显示设置";
    NSArray *arr =@[
                    @[
                        @{@"title":@"最近一天的足迹",@"choose":@(NO)},
                        @{@"title":@"最近一个月的足迹",@"choose":@(YES)},
                        @{@"title":@"最近一年的足迹",@"choose":@(YES)},
                        @{@"title":@"自定义时间",@"choose":@(YES)},
                        ],
                    @[
                        @{@"title":@"显示全部",@"choose":@(NO)},
                        @{@"title":@"只显示自己的足迹",@"choose":@(YES)},
                        @{@"title":@"只显示官方的足迹",@"choose":@(YES)},
                        @{@"title":@"只显示好友的足迹",@"choose":@(YES)},
                        @{@"title":@"只显示陌生人的足迹",@"choose":@(YES)},
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

    ShowTimeSystemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ShowTimeSystemViewCell getCellIDStr] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lineHidden = NO;
    
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    [cell makeCellData:dic];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [self.dataArray objectAtIndex:indexPath.section];

    if (indexPath.section == 0) {
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
        [self.dataArray replaceObjectAtIndex:0 withObject:tempArray];
        DLog(@"数据源 ==  %@",self.dataArray);
        [self.tableView reloadData];
        
    }else{
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:array];

        if (indexPath.row == 0) {
            [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = obj;
                NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                [mutDic setObject:@(YES) forKey:@"choose"];
                [tempArray replaceObjectAtIndex:idx withObject:mutDic];
            }];
            
            NSDictionary *dic = [tempArray objectAtIndex:0];
            NSDictionary *newDic = @{@"title":[dic objectForKey:@"title"],@"choose":@(NO)};
            [tempArray replaceObjectAtIndex:0 withObject:newDic];
            [self.dataArray replaceObjectAtIndex:1 withObject:tempArray];
            [self.tableView reloadData];
            
        }else{
            
            NSDictionary *dic = [tempArray objectAtIndex:0];
            NSDictionary *newDic = @{@"title":[dic objectForKey:@"title"],@"choose":@(YES)};
            [tempArray replaceObjectAtIndex:0 withObject:newDic];
            
            
            NSDictionary *dict = [tempArray objectAtIndex:indexPath.row];
            BOOL isChoose = [[dict objectForKey:@"choose"] boolValue];
            NSDictionary *newDict = @{@"title":[dict objectForKey:@"title"],@"choose":@(!isChoose)};
            [tempArray replaceObjectAtIndex:indexPath.row withObject:newDict];
            [self.dataArray replaceObjectAtIndex:1 withObject:tempArray];
            
            [self.tableView reloadData];
        }
        
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

@implementation ShowTimeSystemViewCell

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
