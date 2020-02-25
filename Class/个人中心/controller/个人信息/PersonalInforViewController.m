//
//  PersonalInforViewController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/10.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "PersonalInforViewController.h"
#import "WWTableView.h"
#import "WWTableViewCell.h"
#import "LEEAlert.h"

#import "JXActionSheet.h"
//#import "ASSETHELPER.h"
#import "UIAlertView+Blocks.h"
#import "RACDelegateProxy.h"
//#import "DoImagePickerController.h"



@interface PersonalInforViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) WWTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@interface PersonalInforCell : WWTableViewCell

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UIImageView *rightImageView;

-(void)makeCellData:(NSString*)title withHide:(BOOL)hide withDetail:(NSString*)detail;

@end

@implementation PersonalInforViewController

- (void)setupTableView
{
    self.tableView = [[WWTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UIColorClearColor;
    [self.view addSubview:self.tableView];
    [self.tableView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[PersonalInforCell class] forCellReuseIdentifier:[PersonalInforCell getCellIDStr]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人设置";
    [self setupTableView];
    
    
    NSArray *array = @[
                       @[@{
                             @"title":@"头像",@"hides":@(NO),@"details":@" "
                             },],
                       @[@{
                             @"title":@"用户名",@"hides":@(YES),@"details":@"Mark"
                             },@{
                             @"title":@"性别",@"hides":@(YES),@"details":@"男"
                             },@{
                             @"title":@"个性签名",@"hides":@(YES),@"details":@"旅游，放松情绪，享受风景。"
                             },],
                       ];
    self.dataArray = [NSMutableArray arrayWithArray:array];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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
    PersonalInforCell *cell = [tableView dequeueReusableCellWithIdentifier:[PersonalInforCell getCellIDStr] forIndexPath:indexPath];
    cell.lineHidden=NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = [self.dataArray objectAtIndex:indexPath.section];
    NSDictionary *dict = [array objectAtIndex:indexPath.row];
    NSString *title = [dict objectForKey:@"title"];
    BOOL hides = [[dict objectForKey:@"hides"] boolValue];
    NSString *details = [dict objectForKey:@"details"];
    [cell makeCellData:title withHide:hides withDetail:details];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self editHeader];
    }else{
        if (indexPath.row == 0) {
            //修改昵称
            [LEEAlert alert].config
            .LeeTitle(@"修改昵称")         // 添加一个标题 (默认样式)
//            .LeeContent(@" ")        // 添加一个标题 (默认样式)
            .LeeAddTextField(^(UITextField *textField) {    // 添加一个输入框 (自定义设置)
                // textfield设置Block
            })
//            .LeeCustomView(view)    // 添加自定义的视图
            .LeeAction(@"取消", ^{        //添加一个默认类型的Action (默认样式 字体颜色为蓝色)
                // 点击事件Block
            })
//            .LeeDestructiveAction(@"销毁Action", ^{    // 添加一个销毁类型的Action (默认样式 字体颜色为红色)
//                // 点击事件Block
//            })
            .LeeCancelAction(@"保存", ^{    // 添加一个取消类型的Action (默认样式 alert中为粗体 actionsheet中为最下方独立)
                // 点击事件Block
            })
            .LeeShow(); // 最后调用Show开始显示
        }else if (indexPath.row == 1){
            //性别
            //创建AlertController对象 preferredStyle可以设置是AlertView样式或者ActionSheet样式
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            //创建取消按钮
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            //创建按钮
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            //        [action2 setValue:[UIColor blueColor] forKey:@"_titleTextColor"];
            //创建按钮
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            //添加按钮
            [alertC addAction:action1];
            [alertC addAction:action2];
            [alertC addAction:action3];
            //显示
            [self presentViewController:alertC animated:YES completion:nil];
            
        }else if (indexPath.row == 2){
            //修改个人签名
            [LEEAlert alert].config
            .LeeTitle(@"修改个性签名")
            .LeeAddTextField(^(UITextField *textField) {
                // textfield设置Block
            })
            .LeeAction(@"取消", ^{
                // 点击事件Block
            })
            .LeeCancelAction(@"保存", ^{
                // 点击事件Block
            })
            .LeeShow();
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 70;
    }
    return 45;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*headerView=[UIView new];
    headerView.backgroundColor=kColorBackgroundColor;
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView*footerView=[UIView new];
    footerView.backgroundColor=UIColorClearColor;
    
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
#pragma mark - 头像修改
- (void)editHeader
{
    //创建AlertController对象 preferredStyle可以设置是AlertView样式或者ActionSheet样式
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //创建取消按钮
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
        [self takeOnePhotoNow];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chosedPhoto];
    }];
    
    //添加按钮
    [alertC addAction:action1];
    [alertC addAction:action2];
    [alertC addAction:action3];
    
    //显示
    [self presentViewController:alertC animated:YES completion:nil];
    
}
- (void)takeOnePhotoNow
{
    BOOL canuse = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (canuse == NO) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        RIButtonItem *item;
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            item = [RIButtonItem itemWithLabel:@"去设置" action:^{
                [[UIApplication sharedApplication] openURL:url];
            }];
        }
        RIButtonItem *item_cancel = [RIButtonItem itemWithLabel:@"知道了"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您的设备不支持拍照或您设置了拍照权限" cancelButtonItem:item_cancel otherButtonItems:item, nil];
        [alert show];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [[picker rac_imageSelectedSignal] subscribeNext:^(id x) {
        UIImage *image = [x objectForKey:UIImagePickerControllerEditedImage];
        [picker dismissViewControllerAnimated:YES completion:^{
            [self uploadHeaderImage:image];
        }];
    }];
    RACDelegateProxy *racdp = picker.rac_delegateProxy;
    [[racdp signalForSelector:@selector(imagePickerControllerDidCancel:)] subscribeNext:^(id x) {
        //该block调用时候：当delegate要执行imagePickerControllerDidCancel
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)chosedPhoto
{
    BOOL canuse = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    if (canuse == NO) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        RIButtonItem *item;
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            item = [RIButtonItem itemWithLabel:@"去设置" action:^{
//                [[UIApplication sharedApplication] openURL:url];
                [[UIApplication sharedApplication] openURL:url options:[NSDictionary new] completionHandler:nil];
            }];
            
        }
        RIButtonItem *item_cancel = [RIButtonItem itemWithLabel:@"去设置"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您的设备不支持拍照或您设置了拍照权限" cancelButtonItem:item_cancel otherButtonItems:item, nil];
        [alert show];
        
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    picker.allowsEditing = YES;
    [[picker rac_imageSelectedSignal] subscribeNext:^(id x) {
        UIImage *image = [x objectForKey:UIImagePickerControllerEditedImage];
        [picker dismissViewControllerAnimated:YES completion:^{
            [self uploadHeaderImage:image];
        }];
    }];
    
    [[picker.rac_delegateProxy signalForSelector:@selector(imagePickerControllerDidCancel:)] subscribeNext:^(id x) {
        //该block调用时候：当delegate要执行imagePickerControllerDidCancel
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    [self presentViewController:picker animated:YES completion:nil];
    
}
#pragma mark - DoImagePickerControllerDelegate
- (void)didCancelDoImagePickerController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
//{
//    [self dismissViewControllerAnimated:YES completion:^{
//        if (picker.nResultType == DO_PICKER_RESULT_UIIMAGE)
//        {
//            [_kHUDManager showActivityInView:nil withTitle:NSLocalizedString(@"picProcessing", nil)];
//            [self uploadHeaderImage:aSelected.firstObject];
//            [_kHUDManager hideAfter:0 onHide:nil];
//
//            [ASSETHELPER clearData];
//        }
//    }];
//}
- (void)uploadHeaderImage:(UIImage *)image
{
    if (image == nil) {
        [_kHUDManager showMsgInView:nil withTitle:@"请选择头像" isSuccess:NO];
        return;
    }
//    NSDictionary *files_dic = @{
//                                @"header" : image
//                                };
//    [TCUploadManager uploadImages:files_dic toPosition:TCUploadPositionHeader andFullUrl:NO onCompletion:^(NSDictionary *data) {
//        [_kHUDManager hideAfter:0.1 onHide:nil];
//
//        if (data) { // 如果成功
//            NSString *header_img = [data.allValues componentsJoinedByString:@","];
//            [self sendHeaderToServerWithPath:header_img];
//        }
//    }];
//
    return;
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

@implementation PersonalInforCell

-(void)dosetup
{
    [super dosetup];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _nameLabel = [UILabel new];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel leftToView:self.contentView withSpace:15];
    [_nameLabel yCenterToView:self.contentView];
    
    
    _iconImageView = [UIImageView new];
    _iconImageView.clipsToBounds = YES;
    _iconImageView.layer.cornerRadius = 22.5;
    _iconImageView.image = [UIImage imageWithColor:kColorMainColor];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView rightToView:self.contentView withSpace:15];
    [_iconImageView yCenterToView:self.contentView];
    [_iconImageView addWidth:45];
    [_iconImageView addHeight:45];
    
    
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
    
}
-(void)makeCellData:(NSString*)title withHide:(BOOL)hide withDetail:(NSString*)detail
{
    _nameLabel.text = title;
    _iconImageView.hidden = hide;
    _detailLabel.text = detail;
    _detailLabel.hidden = !hide;
    _rightImageView.hidden = !hide;
}

@end
