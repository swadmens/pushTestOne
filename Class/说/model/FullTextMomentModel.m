//
//  FullTextMomentModel.m
//  YuLaLa
//
//  Created by 汪伟 on 2018/8/18.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "FullTextMomentModel.h"

@implementation FullTextMomentModel
+(FullTextMomentModel*)makeFullTextMomentModelData:(NSDictionary*)dic
{
    FullTextMomentModel *model = [FullTextMomentModel new];
    
    model.isFullTetx = [[dic objectForKey:@"fulltext"] boolValue];
    
    return model;
}


@end
