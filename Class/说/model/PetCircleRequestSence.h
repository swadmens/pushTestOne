//
//  PetCircleRequestSence.h
//  YuLaLa
//
//  Created by 汪伟 on 2018/6/29.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "RequestSence.h"

@interface PetCircleRequestSence : RequestSence

@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;


@end
