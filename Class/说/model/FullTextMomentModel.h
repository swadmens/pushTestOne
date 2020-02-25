//
//  FullTextMomentModel.h
//  YuLaLa
//
//  Created by 汪伟 on 2018/8/18.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FullTextMomentModel : NSObject

@property (nonatomic,assign) BOOL isFullTetx;

+(FullTextMomentModel*)makeFullTextMomentModelData:(NSDictionary*)dic;

@end
