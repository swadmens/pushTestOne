//
//  MMImageListView.m
//  MomentKit
//
//  Created by LEA on 2017/12/14.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MMImageListView.h"
#import "MMImagePreviewView.h"
#import "Utility.h"
#import "UIImage+ImgSize.h"
#import <UIImageView+YYWebImage.h>
#import "FilePathManager.h"
#pragma mark - ------------------ 小图List显示视图 ------------------


#define  kImageWidth  (kScreenWidth - 46)/3
#define  kImagePadding  8


@interface MMImageListView ()
//<TXVodPlayListener,ZFPlayerDelegate>

// 图片视图数组
@property (nonatomic, strong) NSMutableArray *imageViewsArray;
// 预览视图
@property (nonatomic, strong) MMImagePreviewView *previewView;

@property (nonatomic,strong) NSMutableArray *imagesArray;



//@property (nonatomic,strong) TXVodPlayer *player;
//@property (nonatomic,strong) TXPlayerAuthParams *plaram;

@property (nonatomic,assign) CGRect frames;
@property (nonatomic,strong) UIImageView *superImageView;
@property (nonatomic,strong) UIImageView *voverImageView;

@end

@implementation MMImageListView

-(NSMutableArray*)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 小图(九宫格)
        _imageViewsArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 9; i++) {
            MMImageView *imageView = [[MMImageView alloc] initWithFrame:CGRectZero];
            imageView.tag = 1000 + i;
            [imageView setTapSmallView:^(MMImageView *imageView){
                [self singleTapSmallViewCallback:imageView];
            }];
            [_imageViewsArray addObject:imageView];
            [self addSubview:imageView];
        }
        // 预览视图
        _previewView = [[MMImagePreviewView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return self;
}
#pragma mark - 获取整体高度
+ (CGFloat)imageListHeightForMoment:(PetCircleModel *)moment
{
    // 图片高度
    CGFloat height = 0;
    NSInteger count = moment.img_url_thumb.count;
    
    if (count == 0) {
        height = 0;
    } else if (count == 1) {
        
        NSString *url = [moment.img_url_thumb firstObject];
        NSString *heightUrl = [NSString stringWithFormat:@"%@&%@",url,url];

        CGFloat widthl = [[[NSUserDefaults standardUserDefaults] objectForKey:url] floatValue];
        CGFloat heightl = [[[NSUserDefaults standardUserDefaults] objectForKey:heightUrl] floatValue];
        
        if (widthl == 0 || heightl == 0) {
            UIImage *imagePlace = UIImageWithFileName(@"icon_header");
            widthl = imagePlace.size.width;
            heightl = imagePlace.size.height;
        }
        
        CGSize singleSize = [Utility getSingleSize:CGSizeMake(widthl, heightl)];
        
        CGFloat imageWidth = kScreenWidth - 30;
        CGFloat proportion = singleSize.width / singleSize.height ;
        
        if (singleSize.width >= singleSize.height) {
            
            CGFloat widths = imageWidth * 2 / 3;
            CGFloat heights = widths / proportion;
            height += heights;
            
        }else{
            
            CGFloat widths = imageWidth  / 2;
            CGFloat heights = widths / proportion;
            height += heights;
        }

    } else if (count < 4) {
        height += kImageWidth;
    } else if (count < 7) {
        height += (kImageWidth*2 + kImagePadding);
    } else {
        height += (kImageWidth*3 + kImagePadding*2);
    }
    return height;
}

#pragma mark - Setter
- (void)setMoment:(PetCircleModel *)moment
{
    _moment = moment;
    for (MMImageView *imageView in _imageViewsArray) {
        imageView.hidden = YES;
    }
    // 图片区
    NSInteger count = moment.img_url_thumb.count;
    
    if (count == 0) {
//        self.size = CGSizeZero;
        return;
    }
    // 更新视图数据
    _previewView.pageNum = count;
//    _previewView.scrollView.contentSize = CGSizeMake(_previewView.width*count, _previewView.height);
    // 添加图片
    MMImageView *imageView = nil;
    for (NSInteger i = 0; i < count; i++)
    {
        if (i > 8) {
            break;
        }
        NSInteger rowNum = i/3;
        NSInteger colNum = i%3;
        if(count == 4) {
            rowNum = i/2;
            colNum = i%2;
        }
        
        CGFloat imageX = colNum * (kImageWidth + kImagePadding);
        CGFloat imageY = rowNum * (kImageWidth + kImagePadding);
        CGRect frame = CGRectMake(imageX, imageY, kImageWidth, kImageWidth);
        
        //单张图片需计算实际显示size
        if (count == 1) {
            
            NSString *url = [moment.img_url_thumb firstObject];
            NSString *heightUrl = [NSString stringWithFormat:@"%@&%@",url,url];

            
            CGFloat width = [[[NSUserDefaults standardUserDefaults] objectForKey:url] floatValue];
            CGFloat height = [[[NSUserDefaults standardUserDefaults] objectForKey:heightUrl] floatValue];

            if (width == 0 || height == 0) {
                UIImage *imagePlace = UIImageWithFileName(@"icon_header");
                width = imagePlace.size.width;
                height = imagePlace.size.height;
            }
            
            CGSize singleSize = [Utility getSingleSize:CGSizeMake(width, height)];
            
            CGFloat imageWidth = kScreenWidth - 30;
            CGFloat proportion = singleSize.width / singleSize.height ;
            if (singleSize.width >= singleSize.height) {
                CGFloat widths = imageWidth * 2 / 3;
                CGFloat heights = widths / proportion;
                frame = CGRectMake(0, 0, widths, heights);
            }else{
                
                CGFloat widths = imageWidth  / 2;
                CGFloat heights = widths / proportion;
                frame = CGRectMake(0, 0, widths, heights);
            }
        }
        imageView = [self viewWithTag:1000+i];
        imageView.hidden = NO;
        imageView.frame = frame;
        
        [imageView yy_setImageWithURL:[NSURL URLWithString:[moment.img_url_thumb objectAtIndex:i]] options:YYWebImageOptionProgressive];
        
        [imageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        self.frames = frame;
        
        //添加播放按钮
        if ([moment.type isEqualToString:@"4"]) {
            
            UIImage *image = UIImageWithFileName(@"videotext_play");
            UIButton  *playButton = [UIButton new];
            [playButton setImage:image forState:UIControlStateNormal];
            [imageView addSubview:playButton];
            playButton.frame = frame;
            [playButton addTarget:self action:@selector(startPlayVoidButton) forControlEvents:UIControlEventTouchUpInside];
            
            self.superImageView = imageView;
        }
        
        [self.imagesArray addObject:imageView];
        
    }
//    self.width = kScreenWidth - 30;
//    self.height = imageView.bottom;
}

#pragma mark - 小图单击
- (void)singleTapSmallViewCallback:(MMImageView *)imageView
{
    NSInteger index = imageView.tag-1000;
    [WWPublicMethod lookImage:self.moment.img_url index:index imageViewArrays:self.imagesArray];
}
////开始播放
//-(void)startPlayVoidButton
//{
//
//    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
//    CGRect startRact = [self.superImageView convertRect:self.superImageView.bounds toView:window];
//    self.frames = startRact;
//
//
//    _voverImageView = [[UIImageView alloc]initWithFrame:startRact];
//    _voverImageView.userInteractionEnabled = YES;
//    [_voverImageView sd_setImageWithURL:[NSURL URLWithString:_moment.cover_url]];
//    [[UIApplication sharedApplication].keyWindow addSubview:_voverImageView];
//
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stopPlayClick)];
//    [_voverImageView addGestureRecognizer:tap];
//
//    [UIView animateWithDuration:0.5 animations:^{
//        self.voverImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
////        self.voverImageView.transform = CGAffineTransformMakeScale(1.2,1.2);
//    }];
//
//
//    self.player = [[TXVodPlayer alloc] init];
//    [self.player setupVideoWidget:_voverImageView insertIndex:0];
//    [self.player setRenderMode:RENDER_MODE_FILL_SCREEN];
//
//
//    TXPlayerAuthParams *p = [TXPlayerAuthParams new];
//    p.appId = kMovieAPPID;
//    p.fileId = _moment.video_id;
//    [self.player startPlayWithParams:p];
//
//
//
////    NSString *pathName = [NSString stringWithFormat:@"/%@",_moment.video_id];
////
////
////    TXVodPlayConfig *_config = [[TXVodPlayConfig alloc] init];
////    // 设置缓存路径
////    _config.cacheFolderPath = [self getHostCachesPath];
//////    _config.cacheFolderPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/yubeicath"];
////    // 设置最多缓存多少个文件，避免缓存太多数据
////    _config.maxCacheItems = 8;
////    [self.player setConfig: _config];
//////    NSString *pathUrl = [NSString stringWithFormat:@"%@%@.mp4",_config.cacheFolderPath,pathName];
//////    [self.player startPlay:pathUrl];
//////    [self.player setIsAutoPlay:YES];
////
//////    if (!self.player.isPlaying) {
////        self.player.vodDelegate = self;
//////    }
////
//
//
//}
//#pragma clang diagnostic pop
//
//-(void) onPlayEvent:(TXVodPlayer *)player event:(int)EvtID withParam:(NSDictionary*)param
//{
//
////    NSString *evdioStr = [param objectForKey:@"EVT_TIME"];
////
////
////    NSString *hostCachesPath = [self getHostCachesPath];
////    if (!hostCachesPath)
////    {
////        DLog(@"获取本地路径出错");
////        return;
////    }
////    NSString *videoPath = [NSString stringWithFormat:@"%@/video_%@.%@", hostCachesPath, evdioStr, @"mp3"];
////    NSFileManager *fileMgr = [NSFileManager defaultManager];
////
////    if ([fileMgr fileExistsAtPath:videoPath isDirectory:nil])
////    {
////        [self.player startPlay:videoPath];
////        [self.player isAutoPlay];
////    }else{
////
//
//        if (EvtID == PLAY_EVT_GET_PLAYINFO_SUCC) {
//
//
//            UIView *gsView = [UIView new];
//            gsView.backgroundColor = [UIColor clearColor];
//            [[UIApplication sharedApplication].keyWindow addSubview:gsView];
//            [gsView addWidth:5];
//            [gsView addHeight:5];
//            [gsView centerToView:[UIApplication sharedApplication].keyWindow];
//
//
//            //视频缓冲
//            [_kHUDManager showActivityInView:gsView withTitle:nil];
//
//        }else if (EvtID == PLAY_EVT_PLAY_END){
//            [self stopPlayTheMovie];
//
//        }else if (EvtID == PLAY_EVT_PLAY_LOADING){
//
//
//        }else if (EvtID == PLAY_EVT_PLAY_BEGIN){
//
//            //视频开始
//            [_kHUDManager hideAfter:0.1 onHide:nil];
//
//        }else if (EvtID == PLAY_EVT_CHANGE_RESOLUTION){
//            //视频分辨率改变
//        }
////    }
//
//
//
//
//
//
//
//}
//
//- (void)onNetStatus:(TXVodPlayer *)player withParam:(NSDictionary *)param {
//
//
//}
//-(void)stopPlayClick
//{
//    [_kHUDManager hideAfter:0.1 onHide:nil];
//    [self stopPlayTheMovie];
//}
//-(void)stopPlayTheMovie
//{
//    [UIView animateWithDuration:0.5 animations:^{
//        self.voverImageView.frame = self.frames;
//    }];
//
//    // 停止播放
//    [self.player stopPlay];
//    [self.player removeVideoWidget]; // 记得销毁view控件
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.voverImageView removeFromSuperview];
//    });
//}
//
//
////读取本地视频缓存
//- (NSString *)getHostCachesPath
//{
//    NSFileManager *fileMgr = [NSFileManager defaultManager];
//    NSArray *cachesPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,  NSUserDomainMask,YES);
//    NSString *cachesPath =[cachesPaths objectAtIndex:0];
//    NSString *hostCachesPath = [NSString stringWithFormat:@"%@/%@",cachesPath, _moment.video_id];
//
//    if (![fileMgr fileExistsAtPath:hostCachesPath])
//    {
//        NSError *err = nil;
//
//        if (![fileMgr createDirectoryAtPath:hostCachesPath withIntermediateDirectories:YES attributes:nil error:&err])
//        {
//            DLog(@"Create HostCachesPath fail: %@", err);
//            return nil;
//        }
//    }
//    return hostCachesPath;
//}



@end

#pragma mark - ------------------ 单个小图显示视图 ------------------
@implementation MMImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds  = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCallback:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)singleTapGestureCallback:(UIGestureRecognizer *)gesture
{
    if (self.tapSmallView) {
        self.tapSmallView(self);
    }
}

@end
