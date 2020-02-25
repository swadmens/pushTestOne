//
//  CustomCalloutView.m
//  YuLaLa
//
//  Created by 汪伟 on 2018/6/14.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "CustomCalloutView.h"

#define kPortraitMargin     5
#define kPortraitWidth      50
#define kPortraitHeight     50

#define kTitleWidth         120
#define kTitleHeight        20

#define kArrorHeight        5


@interface CustomCalloutView ()

@property (nonatomic,strong) UIImageView *backImageView;

@end

@implementation CustomCalloutView


//- (void)drawRect:(CGRect)rect
//{
//
//    [self drawInContext:UIGraphicsGetCurrentContext()];
//
//    self.layer.shadowColor = [kColorMainColor CGColor];
//    self.layer.shadowOpacity = 1.0;
//    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
//
//}
//
//- (void)drawInContext:(CGContextRef)context
//{
//
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetFillColorWithColor(context, kColorMainColor.CGColor);
//
//    [self getDrawPath:context];
//    CGContextFillPath(context);
//
//}
//
//- (void)getDrawPath:(CGContextRef)context
//{
//    CGRect rrect = self.bounds;
//    CGFloat radius = 6.0;
//    CGFloat minx = CGRectGetMinX(rrect),
//    midx = CGRectGetMidX(rrect),
//    maxx = CGRectGetMaxX(rrect);
//    CGFloat miny = CGRectGetMinY(rrect),
//    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
//
//    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
//    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
//    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
//
//    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
//    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
//    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
//    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
//    CGContextClosePath(context);
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    
    _backImageView = [UIImageView new];
    _backImageView.image = UIImageWithFileName(@"myself_back_images");
    [self addSubview:_backImageView];
    [_backImageView centerToView:self];
    
    
    // 添加图片，即商户图
    self.portraitView = [[UIImageView alloc] init];
    self.portraitView.clipsToBounds = YES;
    self.portraitView.layer.cornerRadius = 15;
    [_backImageView addSubview:self.portraitView];
    [self.portraitView xCenterToView:_backImageView];
    [self.portraitView topToView:_backImageView withSpace:2];
    [self.portraitView addWidth:30];
    [self.portraitView addHeight:30];
    
    
}
-(void)setIsMyself:(BOOL)isMyself
{
    if (isMyself) {
        _backImageView.image = UIImageWithFileName(@"myself_back_images");
    }else{
        _backImageView.image = UIImageWithFileName(@"others_back_images");
    }
}
@end
