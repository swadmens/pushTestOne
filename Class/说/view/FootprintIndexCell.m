//
//  FootprintIndexCell.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/5.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "FootprintIndexCell.h"
#import "UIImageView+WebCache.h"
#import "MMImageListView.h"
#import "MLLabelUtil.h"
#import "PetCircleModel.h"
#import "LGXHorizontalButton.h"
#import <UIImageView+YYWebImage.h>
#import "FullTextMomentModel.h"
#import "LGXHorizontalButton.h"



@interface FootprintIndexCell ()<MLLinkLabelDelegate>

@property (nonatomic,strong) UIImageView *iconImageView;//头像
@property (nonatomic,strong) UILabel *titleLabel;//名称
@property (nonatomic,strong) UILabel *dateLabel;//时间
@property (nonatomic,strong) MLLinkLabel *detailLabel;//正文
@property (nonatomic,strong) MLLinkLabel *fullTextLabel;//全文

@property (nonatomic,strong) UILabel *nameLabel;



@property (nonatomic,strong) UIButton *addButton;//添加好友
@property (nonatomic,strong) UIButton *plButton;//评论
@property (nonatomic,strong) UIButton *zanButton;//赞

@property (nonatomic,strong) PetCircleModel *model;

@property (nonatomic,assign) NSInteger number;
@property (nonatomic,assign) NSInteger zanNum;//赞的人数

@property (nonatomic,strong) UIButton *playButton;

// 图片
@property (nonatomic, strong) MMImageListView *imageListView;

@property (nonatomic,strong) UIImageView *loImageView;
@property (nonatomic,strong) UILabel *regionLabel;

@property (nonatomic,strong) UIButton *showFullBtn;
@property (nonatomic,strong) UIButton *hideFullBtn;


@property (nonatomic,strong) LGXHorizontalButton *collectBtn;
@property (nonatomic,strong) LGXHorizontalButton *commentBtn;
@property (nonatomic,strong) LGXHorizontalButton *likesBtn;

@property (nonatomic,strong) UIButton *downBtn;
@property (nonatomic,strong) UIButton *deleteBtn;


@end


@implementation FootprintIndexCell

- (void)dosetup {
    [super dosetup];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat item_width = kScreenWidth - 30;
    
    
    _iconImageView = [UIImageView new];
    _iconImageView.clipsToBounds = YES;
    _iconImageView.layer.cornerRadius = 16;
    _iconImageView.image = [UIImage imageWithColor:kColorMainColor];
    _iconImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_iconImageView];
    [_iconImageView topToView:self.contentView withSpace:15];
    [_iconImageView leftToView:self.contentView withSpace:15];
    [_iconImageView addWidth:32];
    [_iconImageView addHeight:32];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookBigImageTap:)];
//    [_iconImageView addGestureRecognizer:tap];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"Mark";
    _titleLabel.textColor = kColorMainTextColor;
    _titleLabel.font = [UIFont customFontWithSize:kFontSizeFourteen];
//    [_titleLabel size];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel leftToView:_iconImageView withSpace:7];
    [_titleLabel topToView:self.contentView withSpace:16];
    
    _dateLabel = [UILabel new];
    _dateLabel.text = @"18-12 12:12";
    _dateLabel.textColor = kColorMainViceTextColor;
    _dateLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
//    [_dateLabel size];
    [self.contentView addSubview:_dateLabel];
    [_dateLabel leftToView:_iconImageView withSpace:7];
    [_dateLabel topToView:_titleLabel withSpace:1];
    
    
    _nameLabel = [UILabel new];
    _nameLabel.text = @"惠州巽寮湾一日游";
    _nameLabel.textColor = kColorMainTextColor;
    _nameLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel leftToView:self.contentView withSpace:12];
    [_nameLabel topToView:_iconImageView withSpace:12];
    
    
    _downBtn = [UIButton new];
    [_downBtn setImage:UIImageWithFileName(@"says_down_images") forState:UIControlStateNormal];
    [_downBtn addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_downBtn];
    [_downBtn yCenterToView:_iconImageView];
    [_downBtn rightToView:self.contentView withSpace:10];
    [_downBtn addWidth:40];
    [_downBtn addHeight:30];
    
    
    UIImage *dImage = UIImageWithFileName(@"says_delete_images");
    CGSize sizes = dImage.size;
    
    _deleteBtn = [UIButton new];
    _deleteBtn.hidden = YES;
    [_deleteBtn setBackgroundImage:dImage forState:UIControlStateNormal];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:kColorMainTextColor forState:UIControlStateNormal];
    _deleteBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeFourteen];
    [_deleteBtn addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
    [_deleteBtn topToView:_downBtn withSpace:-5];
    [_deleteBtn rightToView:self.contentView withSpace:10];
    [_deleteBtn addWidth:sizes.width];
    [_deleteBtn addHeight:sizes.height];
   
    
//
    
    
    
//    _addButton = [UIButton new];
//    _addButton.clipsToBounds = YES;
//    _addButton.layer.borderColor = kColorMainColor.CGColor;
//    _addButton.layer.borderWidth = 0.8f;
//    _addButton.layer.cornerRadius = 2;
//    _addButton.titleLabel.font = [UIFont customFontWithSize:kFontSizeThirteen];
//    [_addButton setTitleColor:kColorMainColor forState:UIControlStateNormal];
//    [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:_addButton];
//    [_addButton yCenterToView:_iconImageView];
//    [_addButton rightToView:self.contentView withSpace:15];
//    [_addButton addWidth:60];
//    [_addButton addHeight:30];
    
    
    _detailLabel = kMLLinkLabel();
    _detailLabel.text = @"不管遇到什么，我总能勇敢面对这一切！不管遇到什么，我总能勇敢面对这一切！不管遇到什么，我总能勇敢面对这一切！不管遇到什么，我总能勇敢面对这一切！";
    _detailLabel.delegate = self;
    _detailLabel.linkTextAttributes = @{NSForegroundColorAttributeName:kColorMainTextColor};
    _detailLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:kColorMainTextColor,NSBackgroundColorAttributeName:[UIColor whiteColor]};
    _detailLabel.numberOfLines = 5;
    [self.contentView addSubview:_detailLabel];
    [_detailLabel leftToView:self.contentView withSpace:15];
    [_detailLabel topToView:_nameLabel withSpace:10];
    [_detailLabel addWidth:item_width];
    
    
//    _showFullBtn = [UIButton new];
//    _showFullBtn.hidden = YES;
//    [_showFullBtn setTitle:@"全文" forState:UIControlStateNormal];
//    [_showFullBtn setTitleColor:kColorMainColor forState:UIControlStateNormal];
//    _showFullBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
//    _showFullBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [_showFullBtn addTarget:self action:@selector(showFullBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:_showFullBtn];
//    [_showFullBtn leftToView:self.contentView withSpace:15];
//    [_showFullBtn topToView:_detailLabel withSpace:5];
//    [_showFullBtn addWidth:60];
//    [_showFullBtn addHeight:20];
    
    
    
    
//    _fullTextLabel = kMLLinkLabel();
//    _fullTextLabel.delegate = self;
//    _fullTextLabel.hidden = YES;
//    _fullTextLabel.linkTextAttributes = @{NSForegroundColorAttributeName:kColorMainTextColor};
//    _fullTextLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:kColorMainTextColor,NSBackgroundColorAttributeName:[UIColor whiteColor]};
//    _fullTextLabel.numberOfLines = 0;
//    [self.contentView addSubview:_fullTextLabel];
//    [_fullTextLabel leftToView:self.contentView withSpace:15];
//    [_fullTextLabel topToView:_iconImageView withSpace:10];
//    [_fullTextLabel addWidth:item_width];
    
    
    _hideFullBtn = [UIButton new];
    _hideFullBtn.hidden = YES;
    [_hideFullBtn setTitle:@"收起" forState:UIControlStateNormal];
    [_hideFullBtn setTitleColor:kColorMainColor forState:UIControlStateNormal];
    _hideFullBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeFifty];
    _hideFullBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_hideFullBtn addTarget:self action:@selector(hideFullBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_hideFullBtn];
    [_hideFullBtn leftToView:self.contentView withSpace:15];
    [_hideFullBtn topToView:_fullTextLabel withSpace:5];
    [_hideFullBtn addWidth:60];
    [_hideFullBtn addHeight:20];
    
    
//    // 图片区
//    _imageListView = [[MMImageListView alloc] init];
//    [self.contentView addSubview:_imageListView];
    
    UIImageView *bigImageView = [UIImageView new];
    bigImageView.clipsToBounds = YES;
    bigImageView.layer.cornerRadius = 16;
    bigImageView.image = [UIImage imageWithColor:kColorMainColor];
    [self.contentView addSubview:bigImageView];
    [bigImageView leftToView:self.contentView withSpace:22];
    [bigImageView addWidth:kScreenWidth-44];
    [bigImageView addHeight:kScreenWidth/2-22];
    [bigImageView topToView:_detailLabel withSpace:10];
    [bigImageView bottomToView:self.contentView withSpace:45];
    
    
    _loImageView = [UIImageView new];
    _loImageView.image = UIImageWithFileName(@"near_location_images");
    [self.contentView addSubview:_loImageView];
    [_loImageView leftToView:self.contentView withSpace:15];
    [_loImageView bottomToView:self.contentView withSpace:20];

    _regionLabel = [UILabel new];
    _regionLabel.textColor = kColorMainTextColor;
    _regionLabel.text = @"天河区";
    _regionLabel.font = [UIFont customFontWithSize:kFontSizeTen];
    [self.contentView addSubview:_regionLabel];
    [_regionLabel yCenterToView:_loImageView];
    [_regionLabel leftToView:_loImageView withSpace:5];
    
    
    
    _likesBtn = [LGXHorizontalButton new];
    [_likesBtn setImage:UIImageWithFileName(@"near_likes_images") forState:UIControlStateNormal];
    [_likesBtn setTitle:@"22" forState:UIControlStateNormal];
    [_likesBtn setTitleColor:kColorSecondTextColor forState:UIControlStateNormal];
    _likesBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeFourteen];
    [self.contentView addSubview:_likesBtn];
    [_likesBtn yCenterToView:_loImageView];
    [_likesBtn rightToView:self.contentView withSpace:15];
    
    
    _commentBtn = [LGXHorizontalButton new];
    [_commentBtn setImage:UIImageWithFileName(@"near_comment_images") forState:UIControlStateNormal];
    [_commentBtn setTitle:@"33" forState:UIControlStateNormal];
    [_commentBtn setTitleColor:kColorSecondTextColor forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeFourteen];
    [self.contentView addSubview:_commentBtn];
    [_commentBtn yCenterToView:_loImageView];
    [_commentBtn rightToView:_likesBtn withSpace:15];
    
    
    _collectBtn = [LGXHorizontalButton new];
    [_collectBtn setImage:UIImageWithFileName(@"near_collect_images") forState:UIControlStateNormal];
    [_collectBtn setTitle:@"44" forState:UIControlStateNormal];
    [_collectBtn setTitleColor:kColorSecondTextColor forState:UIControlStateNormal];
    _collectBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeFourteen];
    [self.contentView addSubview:_collectBtn];
    [_collectBtn yCenterToView:_loImageView];
    [_collectBtn rightToView:_commentBtn withSpace:15];
    
    
//    UIView *botView = [UIView new];
//    botView.backgroundColor = UIColorClearColor;
//    [self.contentView addSubview:botView];
//    [botView alignTop:nil leading:@"0" bottom:@"0" trailing:@"0" toView:self.contentView];
//    [botView addHeight:30];
    
}
#pragma mark - 获取行高
+ (CGFloat)momentCellHeightForMoment:(PetCircleModel *)model fullText:(FullTextMomentModel*)fullText
{
    CGFloat height = 0;
    // 名字
    height += 65;
    // 正文
    if ([model.content length]) {
        MLLinkLabel *linkLab = kMLLinkLabel();
        linkLab.font = [UIFont customFontWithSize:kFontSizeFifty];
        linkLab.text =  model.content;
        
        CGFloat labH = [linkLab preferredSizeWithMaxWidth:kScreenWidth - 30].height;
        
        if (labH < 100) {
            height += labH + 8;
        }else{
            if (fullText.isFullTetx) {
                height += 120;
            }else{
                height += labH + 16;
            }
        }
        
    }
    // 图片
    if (model.img_url_thumb.count > 0) {
        height += [MMImageListView imageListHeightForMoment:model] + 100;
    }else{
        height += 80;
    }
    
    if ([WWPublicMethod isStringEmptyText:model.region]){
        height += 25;
    }
    
    return height;
}

-(void)makeCellData:(PetCircleModel*)model fullText:(FullTextMomentModel*)fullText
{
    self.model = model;
    
    _detailLabel.hidden = !fullText.isFullTetx;
    _showFullBtn.hidden = !fullText.isFullTetx;
    
    _fullTextLabel.hidden = fullText.isFullTetx;
    _hideFullBtn.hidden = fullText.isFullTetx;
    
    
    CGFloat bottom = 65;
    if ([self.model.content length]) {
        _detailLabel.text = self.model.content;
        _fullTextLabel.text = self.model.content;
        
        MLLinkLabel *linkLab = kMLLinkLabel();
        linkLab.font = [UIFont customFontWithSize:kFontSizeFifty];
        linkLab.text =  self.model.content;
        CGFloat labH = [linkLab preferredSizeWithMaxWidth:kScreenWidth - 30].height;
        
        if (labH < 100) {
            bottom += labH + 10;
            _showFullBtn.hidden = YES;
        }else{
            if (fullText.isFullTetx) {
                bottom += 140;
                _showFullBtn.hidden = NO;
            }else{
                bottom += labH + 36;
                _showFullBtn.hidden = YES;
            }
        }
        
    }else{
        _detailLabel.text = @"";
        _fullTextLabel.text = @"";
    }
    // 图片
    _imageListView.moment = self.model;
    if (self.model.img_url_thumb.count > 0) {
//        _imageListView.origin = CGPointMake(self.contentView.left + 15, bottom);
    }
    
    [_iconImageView yy_setImageWithURL:[NSURL URLWithString:self.model.user_photo] options:YYWebImageOptionProgressive];
    
    if ([WWPublicMethod isStringEmptyText:self.model.region]) {
        _loImageView.hidden = NO;
        _regionLabel.hidden = NO;
        _regionLabel.text = self.model.region;
    }else{
        _loImageView.hidden = YES;
        _regionLabel.hidden = YES;
    }
    
    
    _dateLabel.text = self.model.add_time;
    _titleLabel.text = self.model.user_name;
    if (self.model.primary_btn.count == 0) {
        _addButton.hidden = YES;
    }else{
        _addButton.hidden = NO;
        [_addButton setTitle:[self.model.primary_btn objectForKey:@"name"] forState:UIControlStateNormal];
    }
    [_plButton setTitle:[NSString stringWithFormat:@" %@",self.model.comment] forState:UIControlStateNormal];
    [_zanButton setTitle:[NSString stringWithFormat:@" %@",self.model.praise] forState:UIControlStateNormal];
    self.zanNum = [self.model.praise integerValue];
    
    if ([self.model.praise_id isEqualToString:@"0"]) {
        _number = 0;
        [_zanButton setImage:UIImageWithFileName(@"no_click_zan") forState:UIControlStateNormal];
        [_zanButton setBGColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_zanButton setTitleColor:kColorMainTextColor forState:UIControlStateNormal];
    }else{
        _number = 1;
        [_zanButton setImage:UIImageWithFileName(@"yi_click_zan") forState:UIControlStateNormal];
        [_zanButton setBGColor:kColorMainColor forState:UIControlStateNormal];
        [_zanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
}
#pragma mark - MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    
}

-(void)showFullBtnClick
{
//    if (self.showFullTextClickButton) {
//        self.showFullTextClickButton(NO);
//    }
}
-(void)hideFullBtnClick
{
//    if (self.showFullTextClickButton) {
//        self.showFullTextClickButton(YES);
//    }
}


-(void)lookBigImageTap:(UITapGestureRecognizer*)tp
{
//    NSString *pushid = [NSString stringWithFormat:@"%@&%@",self.model.user_id,@"pet_circle_friends"];
//    [TargetEngine controller:nil pushToController:PushTargetFamiliarFriendInfor WithTargetId:pushid];
}

-(void)downButtonClick
{
    _downBtn.selected = !_downBtn.selected;
    _deleteBtn.hidden = !_downBtn.selected;
}

-(void)deleteButtonClick
{
    [[TCNewAlertView shareInstance] showAlert:nil message:@"确定删除？" cancelTitle:@"取消" viewController:nil confirm:^(NSInteger buttonTag) {
        if (buttonTag == 0 ) {
            
        }
    } buttonTitles:@"确定", nil];
}

@end
