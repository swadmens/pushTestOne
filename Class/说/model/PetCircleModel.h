//
//  PetCircleModel.h
//  YuLaLa
//
//  Created by 汪伟 on 2018/6/1.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PetCircleModel : NSObject

@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,strong) NSString *comment;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *cover_url;
@property (nonatomic,strong) NSString *did;
@property (nonatomic,strong) NSString *praise;
@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *user_name;
@property (nonatomic,strong) NSString *user_photo;
@property (nonatomic,strong) NSString *video_id;
@property (nonatomic,strong) NSString *praise_id;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *region;


@property (nonatomic,strong) NSMutableArray *img_url;
@property (nonatomic,strong) NSMutableArray *img_url_thumb;
@property (nonatomic,strong) NSDictionary *primary_btn;

+(PetCircleModel*)makePetCircleModel:(NSDictionary*)dict;

@end





