//
//  TheThumbUpModel.h
//  YuLaLa
//
//  Created by 汪伟 on 2018/6/2.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TheThumbUpModel : NSObject

@property (nonatomic,strong) NSString *remark;
@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *user_name;
@property (nonatomic,strong) NSString *user_photo;
@property (nonatomic,strong) NSDictionary *primary_btn;

+(TheThumbUpModel*)makeTheThumbUpModelData:(NSDictionary*)dict;

@end
