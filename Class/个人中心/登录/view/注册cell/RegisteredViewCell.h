//
//  RegisteredViewCell.h
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/7.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "WWTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisteredViewCell : WWTableViewCell

@property (nonatomic,strong) void(^replacTextFieldText)(NSString*text);
@property (nonatomic,strong) void(^replacSendCodeButton)(void);


-(void)makeCellData:(NSString*)icon withPlace:(NSString*)placeholder withTag:(NSInteger)tag withStyle:(NSString*)style;

@end

NS_ASSUME_NONNULL_END
