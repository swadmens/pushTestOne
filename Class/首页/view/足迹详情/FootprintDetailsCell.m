//
//  FootprintDetailsCell.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/6.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "FootprintDetailsCell.h"

@interface FootprintDetailsCell ()

@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *titleImageView;



@end

@implementation FootprintDetailsCell

- (void)dosetup {
    [super dosetup];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];

    _contentLabel = [UILabel new];
    _contentLabel.text = @"坐上大巴车，喝着蒙古奶茶，吃上一口内蒙古的干哥俩牛肉干，开启了我大赤峰之旅，旅游景点一“红山湖”内蒙古西有“乌梁素海”，东有红山湖。红山水库坐落在内蒙古自治区的东部。位于西辽河的主要支流——被誉为“契丹·辽文化母亲河”之一的老哈河中游，地处赤峰市翁牛特旗、敖汉旗、松山区交界处，距赤峰市区90公里。库区总面积214平方公里，总库容25.6亿立方米，水面94平方公里，控制流域面积24486平方公里，占老哈河总流域面积的74%。是内蒙古自治区最大的一座人工湖。是参观、游览消夏避暑的旅游胜地。内蒙古西有“乌梁素海”，东有红山湖。";
    _contentLabel.textColor = kColorMainTextColor;
    _contentLabel.font = [UIFont customFontWithSize:kFontSizeFourteen];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel xCenterToView:self.contentView];
    [_contentLabel topToView:self.contentView];
    [_contentLabel addWidth:kScreenWidth-30];
    
    
    _titleImageView = [UIImageView new];
    _titleImageView.image = [UIImage imageWithColor:[UIColor blackColor]];
    _titleImageView.clipsToBounds = YES;
    _titleImageView.layer.cornerRadius = 5;
    [self.contentView addSubview:_titleImageView];
    [_titleImageView topToView:_contentLabel withSpace:10];
    [_titleImageView leftToView:self.contentView withSpace:12];
    [_titleImageView bottomToView:self.contentView withSpace:5];
    [_titleImageView addWidth:kScreenWidth - 24];
    [_titleImageView addHeight:200];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
