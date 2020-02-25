//
//  CustomAnnotationView.h
//  YuLaLa
//
//  Created by 汪伟 on 2018/6/14.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "CustomCalloutView.h"

//@class NearThrMapModel;
@interface CustomAnnotationView : BMKAnnotationView

@property (nonatomic, strong) CustomCalloutView *calloutView;

//-(void)makeViewData:(NearThrMapModel*)model;

@end
