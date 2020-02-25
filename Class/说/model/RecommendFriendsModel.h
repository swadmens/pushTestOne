//
//  RecommendFriendsModel.h
//  YuLaLa
//
//  Created by 汪伟 on 2018/6/1.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendFriendsModel : NSObject

@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *user_name;
@property (nonatomic,strong) NSString *distance;
@property (nonatomic,strong) NSString *user_photo;
@property (nonatomic,strong) NSString *resource;


+(RecommendFriendsModel*)makeRecommendFriendsModelModel:(NSDictionary*)dict;

@end
