//
//  PetCircleDetailedContentModel.m
//  YuLaLa
//
//  Created by 汪伟 on 2018/6/1.
//  Copyright © 2018年 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "PetCircleDetailedContentModel.h"
#import "UIImage+ImgSize.h"

@implementation PetCircleDetailedContentModel
-(NSMutableArray*)img_url_thumb
{
    if (!_img_url_thumb) {
        _img_url_thumb = [NSMutableArray array];
    }
    return _img_url_thumb;
}
+(PetCircleDetailedContentModel*)makePetCircleDetailedContentModelModel:(NSDictionary*)dict
{
    PetCircleDetailedContentModel *model = [PetCircleDetailedContentModel new];
    
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
    model.share = [NSDictionary dictionaryWithDictionary:[dict objectForKey:@"share"]];


    
    model.img_url = (NSArray*)[dict objectForKey:@"img_url"];
    model.primary_btn = (NSDictionary*)[dict objectForKey:@"primary_btn"];
    model.user_praise = (NSArray*)[dict objectForKey:@"user_praise"];
    
    NSArray *arrayThumb = [dict objectForKey:@"img_url_thumb"];
    [model.img_url_thumb addObjectsFromArray:arrayThumb];
    
    
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
    
    
    NSArray *array = (NSArray*)[dict objectForKey:@"dynamic_comment"];
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:array.count];
    [array enumerateObjectsUsingBlock:^(NSDictionary *comDic, NSUInteger idx, BOOL * _Nonnull stop) {
        CommentsDetailesModel *model = [CommentsDetailesModel makeCommentsDetailesModel:comDic];
        [temp addObject:model];
    }];
    model.dynamic_comment = [NSMutableArray arrayWithArray:temp];
    
    
    return model;
}
@end


@implementation CommentsDetailesModel
+(CommentsDetailesModel*)makeCommentsDetailesModel:(NSDictionary*)dict
{
    CommentsDetailesModel *model = [CommentsDetailesModel new];
    
    model.cid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"cid"]];
    model.content = [NSString stringWithFormat:@"%@",[dict objectForKey:@"content"]];
    model.replay_user_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"replay_user_id"]];
    model.replay_user_name = [NSString stringWithFormat:@"%@：",[dict objectForKey:@"replay_user_name"]];
    model.user_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user_id"]];
    model.user_name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user_name"]];
    model.user_photo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user_photo"]];
  
    return model;
}
@end



