//
//  PetCircleModel.m
//  YuLaLa
//
//  Created by 汪伟 on 2018/6/1.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "PetCircleModel.h"
#import "UIImage+ImgSize.h"

@implementation PetCircleModel
-(NSMutableArray*)img_url
{
    if (!_img_url) {
        _img_url = [NSMutableArray array];
    }
    return _img_url;
}
-(NSMutableArray*)img_url_thumb
{
    if (!_img_url_thumb) {
        _img_url_thumb = [NSMutableArray array];
    }
    return _img_url_thumb;
}
+(PetCircleModel*)makePetCircleModel:(NSDictionary*)dict
{
    PetCircleModel *model = [PetCircleModel new];
    
    
    
    model.add_time = [NSString stringWithFormat:@"%@",[dict objectForKey:@"add_time"]];
    model.comment = [NSString stringWithFormat:@"%@",[dict objectForKey:@"comment"]];
    model.content = [NSString stringWithFormat:@"%@",[dict objectForKey:@"content"]];
    model.cover_url = [NSString stringWithFormat:@"%@",[dict objectForKey:@"cover_url"]];
    model.did = [NSString stringWithFormat:@"%@",[dict objectForKey:@"did"]];
    model.praise = [NSString stringWithFormat:@"%@",[dict objectForKey:@"praise"]];
    model.user_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user_id"]];
    model.user_name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user_name"]];
    model.user_photo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user_photo"]];
    model.video_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"video_id"]];
    model.praise_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"praise_id"]];
    model.type = [NSString stringWithFormat:@"%@",[dict objectForKey:@"type"]];
    model.region = [NSString stringWithFormat:@"%@",[dict objectForKey:@"region"]];




    NSArray *array = [dict objectForKey:@"img_url"];
    [model.img_url addObjectsFromArray:array];
    
    NSArray *arrayThumb = [dict objectForKey:@"img_url_thumb"];
    [model.img_url_thumb addObjectsFromArray:arrayThumb];
    
    model.primary_btn = (NSDictionary*)[dict objectForKey:@"primary_btn"];
    
    
    if ([model.type isEqualToString:@"4"]) {
        [model.img_url_thumb removeAllObjects];
        [model.img_url_thumb addObject:model.cover_url];
    }
  
    if (model.img_url_thumb.count == 1) {
        
        NSString *url = model.img_url_thumb.firstObject;
        NSString *heightUrl = [NSString stringWithFormat:@"%@&%@",url,url];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:url];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:heightUrl];

        //获取图片尺寸时先检查是否有缓存(有就不用再获取了)
        if (![[NSUserDefaults standardUserDefaults] objectForKey:url]) {
            //这里拿到每个图片的尺寸，然后计算出每个cell的高度
            CGSize imageSize = [UIImage getImageSizeWithURL:url];
            
            CGFloat width = imageSize.width;
            CGFloat height = imageSize.height;
            
            //将最终的自适应的高度 本地化处理
            [[NSUserDefaults standardUserDefaults] setObject:@(width) forKey:url];
            [[NSUserDefaults standardUserDefaults] setObject:@(height) forKey:heightUrl];
        }
        
    }
    
    return model;
}
@end

