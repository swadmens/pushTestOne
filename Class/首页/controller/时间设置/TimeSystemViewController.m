//
//  TimeSystemViewController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/6.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "TimeSystemViewController.h"
#import "WWTableView.h"
@interface TimeSystemViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) WWTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@interface TimeSystemViewCell : WWTableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *chooseImageView;
-(void)makeCellData:(NSDictionary*)dic;

@end

@implementation TimeSystemViewController

-(void)steupTableView
{
    _tableView = [[WWTableView alloc]init];
    _tableView.userInteractionEnabled = YES;
    _tableView.clipsToBounds = YES;
    _tableView.estimatedRowHeight = 45;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    [_tableView registerClass:[TimeSystemViewCell class] forCellReuseIdentifier:[TimeSystemViewCell getCellIDStr]];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"时间设置";
    [self steupTableView];
    
//
//    for (int i = 0; i<5; i++) {
//        NSDictionary
//    }
    
    NSArray *arr = @[
                     @{@"title":@"最近一天",@"choose":@(NO)},
                     @{@"title":@"最近七天",@"choose":@(YES)},
                     @{@"title":@"最近一个月",@"choose":@(YES)},
                     @{@"title":@"最近三个月",@"choose":@(YES)},
                     @{@"title":@"最近六个月",@"choose":@(YES)},
                         ];
    self.dataArray = [NSMutableArray arrayWithArray:arr];
    
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TimeSystemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TimeSystemViewCell getCellIDStr] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lineHidden = NO;
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    [cell makeCellData:dic];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [mutDic setObject:@(YES) forKey:@"choose"];
        [self.dataArray replaceObjectAtIndex:idx withObject:mutDic];
    }];
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    NSDictionary *newDic = @{@"title":[dic objectForKey:@"title"],@"choose":@(NO)};
    [self.dataArray replaceObjectAtIndex:indexPath.row withObject:newDic];
    
    DLog(@"数据源 ==  %@",self.dataArray);
    [self.tableView reloadData];
    
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

@implementation TimeSystemViewCell

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
    _chooseImageView.image = UIImageWithFileName(@"choose_right_images");
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
