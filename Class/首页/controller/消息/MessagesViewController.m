//
//  MessagesViewController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/7.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "MessagesViewController.h"
#import "LGXVerticalButton.h"
#import "WWTableView.h"
#import "SystemMessagesCell.h"
#import "LikeMessagesCell.h"
#import "ApplyMessagesCell.h"
#import "LeaveMessagesCell.h"


@interface MessagesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) WWTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,assign) NSInteger styleInteger;


@end

@implementation MessagesViewController
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
    [_tableView alignTop:@"105" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    [_tableView registerClass:[SystemMessagesCell class] forCellReuseIdentifier:[SystemMessagesCell getCellIDStr]];
    [_tableView registerClass:[LikeMessagesCell class] forCellReuseIdentifier:[LikeMessagesCell getCellIDStr]];
    [_tableView registerClass:[ApplyMessagesCell class] forCellReuseIdentifier:[ApplyMessagesCell getCellIDStr]];
    [_tableView registerClass:[LeaveMessagesCell class] forCellReuseIdentifier:[LeaveMessagesCell getCellIDStr]];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息";
    
    //右上角
    UIButton *button = [UIButton new];
    [button setTitle:@"联系人" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [button setTitleColor:kColorMainColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(friendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBut;
    
    
    [self setupTopView];
    [self steupTableView];
    
    self.styleInteger = 0;
    
    
}
-(void)setupTopView
{
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView alignTop:@"15" leading:@"0" bottom:nil trailing:@"0" toView:self.view];
    [topView addHeight:90];
    
    
    NSArray *nameArr = @[@"消息",@"赞",@"申请",@"评论"];
    NSArray *imageArr = @[@"msg_msgs_images",@"msg_likes_images",@"msg_replay_images",@"msg_leaves_images"];
    
    CGFloat space = (kScreenWidth - 270)/3;
    
    [nameArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
        NSString *title = obj;
        NSString *images = [imageArr objectAtIndex:idx];
        LGXVerticalButton *button = [LGXVerticalButton new];
        button.tag = 100 + idx;
        [button setImage:UIImageWithFileName(images)  forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:kColorMainViceTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
        [topView addSubview:button];
        button.frame = CGRectMake(15+idx*(space+60), 15, 60, 60);
        [button addTarget:self action:@selector(verticalButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    }];
    
    
    
}
-(void)verticalButtonClick:(UIButton*)bt
{
    switch (bt.tag) {
            case 100:
            DLog(@"消息");
            self.styleInteger = 0;
            [self.tableView reloadData];
            break;
            case 101:
            DLog(@"赞");
            self.styleInteger = 1;
            [self.tableView reloadData];
            break;
            case 102:
            DLog(@"申请");
            self.styleInteger = 2;
            [self.tableView reloadData];
            break;
            case 103:
            DLog(@"评论");
            self.styleInteger = 3;
            [self.tableView reloadData];
            break;
            
        default:
            break;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.styleInteger == 0) {
        SystemMessagesCell *cell = [tableView dequeueReusableCellWithIdentifier:[SystemMessagesCell getCellIDStr] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineHidden = NO;
        
        
        return cell;
    }else if (self.styleInteger == 1){
        LikeMessagesCell *cell = [tableView dequeueReusableCellWithIdentifier:[LikeMessagesCell getCellIDStr] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineHidden = NO;
        
        
        return cell;
    }else if (self.styleInteger == 2){
        ApplyMessagesCell *cell = [tableView dequeueReusableCellWithIdentifier:[ApplyMessagesCell getCellIDStr] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineHidden = NO;
        
        
        return cell;
    }else{
        LeaveMessagesCell *cell = [tableView dequeueReusableCellWithIdentifier:[LeaveMessagesCell getCellIDStr] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineHidden = NO;
        
        
        return cell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//联系人
-(void)friendButtonClick
{
    [TargetEngine controller:nil pushToController:PushTargetMyFriendsView WithTargetId:nil];
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
