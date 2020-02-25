//
//  SelectDyamicLocationController.h
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/28.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "WWViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LocationDelegate <NSObject>
-(void)sendValue:(CLLocationCoordinate2D)value withid:(NSString *)region; //声明协议方法
@end

@interface SelectDyamicLocationController : WWViewController

@property (nonatomic, weak)id<LocationDelegate> delegate; //声明协议变量


@end

NS_ASSUME_NONNULL_END
