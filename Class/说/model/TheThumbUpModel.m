//
//  TheThumbUpModel.m
//  YuLaLa
//
//  Created by 汪伟 on 2018/6/2.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "TheThumbUpModel.h"

@implementation TheThumbUpModel
+(TheThumbUpModel*)makeTheThumbUpModelData:(NSDictionary*)dict
{
    TheThumbUpModel *model = [TheThumbUpModel new];
    
    
    model.remark = [NSString stringWithFormat:@"%@",[dict objectForKey:@"remark"]];
    model.user_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user_id"]];
    model.user_name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user_name"]];
    model.user_photo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user_photo"]];
    model.primary_btn = (NSDictionary*)[dict objectForKey:@"primary_btn"];
    
    
    
    return model;
}
@end
