//
//  RecommendFriendsModel.m
//  YuLaLa
//
//  Created by 汪伟 on 2018/6/1.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "RecommendFriendsModel.h"

@implementation RecommendFriendsModel
+(RecommendFriendsModel*)makeRecommendFriendsModelModel:(NSDictionary*)dict
{
    RecommendFriendsModel *model = [RecommendFriendsModel new];
    
    model.user_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user_id"]];
    model.user_name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user_name"]];
    model.distance = [NSString stringWithFormat:@"%@",[dict objectForKey:@"distance"]];
    model.user_photo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user_photo"]];
    model.resource = [NSString stringWithFormat:@"%@",[dict objectForKey:@"resource"]];

    
    return model;
}
@end
