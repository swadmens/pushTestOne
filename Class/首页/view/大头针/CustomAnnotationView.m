//
//  CustomAnnotationView.m
//  YuLaLa
//
//  Created by 汪伟 on 2018/6/14.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "CustomAnnotationView.h"
//#import "NearThrMapModel.h"
#import <UIImageView+YYWebImage.h>

@interface CustomAnnotationView()

@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIImageView *showImageView;
//@property (nonatomic,strong) NearThrMapModel *model;

@end

@implementation CustomAnnotationView

#define kCalloutWidth       44.0
#define kCalloutHeight      54.0

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    if (self.selected == selected)
//    {
//        return;
//    }
//    if (selected)
//    {
//
//        if (self.calloutView == nil)
//        {
//            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
//            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
//                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
//        }
//
//        [self addSubview:self.calloutView];
//
//        //跳转到宠友资料页
//        NSString *pushid = [NSString stringWithFormat:@"%@&%@",self.model.user_id,@"pet_circle_friends"];
//        [TargetEngine controller:nil pushToController:PushTargetFamiliarFriendInfor WithTargetId:pushid];
//
//    }
//    else
//    {
//        DLog(@"点击气泡的其它操作");
//        [self.calloutView removeFromSuperview];
//    }
//
//    [super setSelected:selected animated:animated];
//}

-(id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kCalloutWidth, kCalloutHeight);
        self.backgroundColor = UIColorFromRGB(0xffffff, 0);
        
        self.backImageView = [UIImageView new];
        self.backImageView.image = UIImageWithFileName(@"index_back_green");
        [self addSubview:self.backImageView];
        [self.backImageView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self];
        
        
        self.showImageView = [UIImageView new];
        self.showImageView.image = UIImageWithFileName(@"icon_header");
        self.showImageView.clipsToBounds = YES;
        self.showImageView.layer.cornerRadius = 20;
        [self addSubview:self.showImageView];
        [self.showImageView alignTop:@"2" leading:@"2" bottom:nil trailing:nil toView:self];
        [self.showImageView addWidth:40];
        [self.showImageView addHeight:40];
        
    }
    
    return self;
}
//-(void)makeViewData:(NearThrMapModel*)model
//{
//    self.model = model;
//    
//    [self.showImageView yy_setImageWithURL:[NSURL URLWithString:model.pet_photo] options:YYWebImageOptionProgressive];
//    
//    if (model.is_myself) {
//        self.backImageView.image = UIImageWithFileName(@"myself_back_images");
//    }else{
//        self.backImageView.image = UIImageWithFileName(@"others_back_images");
//    }
//}

@end
