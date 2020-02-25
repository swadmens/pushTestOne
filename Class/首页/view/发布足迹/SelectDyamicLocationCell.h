//
//  SelectDyamicLocationCell.h
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/28.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "WWTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectDyamicLocationCell : WWTableViewCell

-(void)makeCellData:(NSString*)name withDetail:(NSString*)detail;

-(void)makeChoseCell:(NSString*)chose;

@end

NS_ASSUME_NONNULL_END
