//
//  PetCircleRequestSence.m
//  YuLaLa
//
//  Created by 汪伟 on 2018/6/29.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "PetCircleRequestSence.h"

@implementation PetCircleRequestSence
@synthesize params = _params;

- (void)doSetup
{
    [super doSetup];
    self.pathURL = @"userdynamic";
}
- (NSMutableDictionary *)params
{
    _params = [NSMutableDictionary dictionary];
    
    [_params setObject:@(self.page) forKey:@"page"];
    [_params setObject:@"10" forKey:@"limit"];
    [_params setObject:self.type forKey:@"type"];
    [_params setObject:self.longitude forKey:@"longitude"];
    [_params setObject:self.latitude forKey:@"latitude"];
    
    NSString *sign=[WWPublicMethod makeAlphabeticOrdering:_params];
    [_params setObject:sign forKey:kSignKey];

    
    return _params;
}
@end
