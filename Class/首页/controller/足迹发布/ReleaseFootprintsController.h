//
//  ReleaseFootprintsController.h
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/24.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "WWViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^callBackBlock)(NSString *);

@interface ReleaseFootprintsController : WWViewController

/*
 * oldHtmlString:包含两种标签<div>和<img>两种标签，文本用<div>，图片用<img src="http://...." style=width:99%/>表示
 * 每个标签中间没有空格
 * returnBlock:是返回的字符串格式同上
 */
@property (nonatomic,copy) NSString *oldHtmlString;
@property (nonatomic,copy) callBackBlock returnBlock;


@end

NS_ASSUME_NONNULL_END
