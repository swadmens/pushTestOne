//
//  ReleaseFootprintsController.m
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/24.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import "ReleaseFootprintsController.h"
#import "LGXHorizontalButton.h"
#import "LGXVerticalButton.h"
#import "SelectDyamicLocationController.h"


#define kBaseUrl @"http://sj.taoshangapp.com"


@interface ReleaseFootprintsController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,LocationDelegate>

@property (nonatomic,strong)NSMutableArray *imageUploadedArray;//图片数组
@property (nonatomic,strong)NSMutableArray *imageUploadedNameArray;//所有上传图片名字数组（上传图片之后，返回的名字）
@property (nonatomic,strong)NSMutableArray *imageDownloadedNameArray;//之前上传的oldHtmlString解析出来的图片地址

@property (nonatomic,strong)NSMutableArray *imageMarkArray;//图片对应的记号`0`表示第0张图片

@property (nonatomic,assign) BOOL hasEndDiv;
@property (nonatomic,assign) BOOL hasHeadDiv;
@property (nonatomic,assign) NSInteger imageIndex;
@property (nonatomic,strong) NSMutableString *resultString;//拼接之后的字符串

@property (nonatomic,strong)UIImagePickerController *pickerController;
@property (nonatomic,assign)CGFloat imageWidth;
@property (nonatomic,assign)CGFloat wordFont;

//光标位置
@property (nonatomic,assign)NSRange curserRange;


@property (nonatomic,strong) UITextView *titleTextView;
@property (nonatomic,strong) UITextView *contentTextView;


@property (nonatomic,copy)NSString *webImageDir;

@property(nonatomic,strong) UILabel *chNumLabel;

@property (nonatomic) CLLocationCoordinate2D coordinateMine;
@property (nonatomic ,strong) NSString *region;
@property (nonatomic,strong) NSString *locationString;


@end

@implementation ReleaseFootprintsController
- (void)dealloc {
    _imageUploadedArray = nil;
    _imageUploadedNameArray = nil;
    _imageDownloadedNameArray = nil;
    _imageMarkArray = nil;
    _pickerController = nil;
    _returnBlock = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"足迹发布";
    
    _webImageDir = @"http://sj.taoshangapp.com/new/xuanshangimg/";

    //右上角
    UIButton *button = [UIButton new];
    [button setTitle:@"审核发表" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont customFontWithSize:kFontSizeSixteen];
    [button setTitleColor:kColorMainColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(releaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBut;
    
    
    [self setupView];
    
//    self.automaticallyAdjustsScrollViewInsets = false;
    
    _wordFont = 15.0;
    _imageWidth = 150;
    
    _resultString = [[NSMutableString alloc] init];
    _imageUploadedArray = [[NSMutableArray alloc] init];
    _imageUploadedNameArray = [[NSMutableArray alloc] init];
    _imageDownloadedNameArray = [[NSMutableArray alloc] init];
    
    _imageMarkArray = [[NSMutableArray alloc] init];
  
    
    if (_oldHtmlString != nil && ![_oldHtmlString isEqualToString:@""]) {
        [self setOldStringToAttributeString:_oldHtmlString];
    }
    
    if (_pickerController == nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.pickerController = [[UIImagePickerController alloc] init];
            self.pickerController.view.backgroundColor = [UIColor redColor];
            self.pickerController.delegate = self;
            self.pickerController.allowsEditing = YES;
        });
    }
    NSLog(@"光标位置%ld——%ld",_curserRange.location,_curserRange.length);
}
-(void)setupView
{
    UIView *titleView = [UIView new];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    [titleView alignTop:@"0" leading:@"0" bottom:nil trailing:@"0" toView:self.view];
    [titleView addHeight:80];
    
    
    UIImageView *xImageView = [UIImageView new];
    xImageView.image = UIImageWithFileName(@"release_xing_images");
    [titleView addSubview:xImageView];
    [xImageView leftToView:titleView withSpace:12];
    [xImageView topToView:titleView withSpace:16];
    
    
    _titleTextView = [UITextView new];
    _titleTextView.text = @"输入足迹标题";
    _titleTextView.backgroundColor = [UIColor whiteColor];
    _titleTextView.delegate = self;
    _titleTextView.font = [UIFont customFontWithSize:kFontSizeFifty];
    _titleTextView.textColor = kColorThirdTextColor;
    [titleView addSubview:_titleTextView];
    [_titleTextView alignTop:@"0" leading:@"22" bottom:@"20" trailing:@"12" toView:titleView];
    
    
    UILabel *zifuLabel = [UILabel new];
    zifuLabel.text = @"/100";
    zifuLabel.textColor = kColorThirdTextColor;
    zifuLabel.font = [UIFont customFontWithSize:kFontSizeTen];
    [titleView addSubview:zifuLabel];
    [zifuLabel bottomToView:titleView withSpace:6];
    [zifuLabel rightToView:titleView withSpace:12];
    
    
    
    self.chNumLabel = [UILabel new];
    self.chNumLabel.textColor = kColorThirdTextColor;
    self.chNumLabel.font = [UIFont customFontWithSize:kFontSizeTen];
    self.chNumLabel.text = @"0";
    [self.chNumLabel sizeToFit];
    [titleView addSubview:self.chNumLabel];
    [self.chNumLabel yCenterToView:zifuLabel];
    [self.chNumLabel rightToView:zifuLabel];
    

    
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView alignTop:@"90" leading:@"0" bottom:@"25" trailing:@"0" toView:self.view];
//    [backView addHeight:305];
    
    
    LGXHorizontalButton *placeBtn = [LGXHorizontalButton new];
    [placeBtn setBGColor:kColorBackSecondColor forState:UIControlStateNormal];
    placeBtn.clipsToBounds = YES;
    placeBtn.layer.cornerRadius = 10;
    [placeBtn setImage:UIImageWithFileName(@"near_location_images") forState:UIControlStateNormal];
    [placeBtn setTitle:@"添加地点" forState:UIControlStateNormal];
    [placeBtn setTitleColor:kColorMainTextColor forState:UIControlStateNormal];
    placeBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeTwelve];
    [backView addSubview:placeBtn];
    [placeBtn leftToView:backView withSpace:12];
    [placeBtn bottomToView:backView withSpace:10];
    [placeBtn addWidth:80];
    [placeBtn addHeight:20];
    [placeBtn addTarget:self action:@selector(addPlaceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    LGXHorizontalButton *publicBtn = [LGXHorizontalButton new];
    [publicBtn setBGColor:kColorBackSecondColor forState:UIControlStateNormal];
    publicBtn.clipsToBounds = YES;
    publicBtn.layer.cornerRadius = 10;
    [publicBtn setImage:UIImageWithFileName(@"privacy_bool_images") forState:UIControlStateNormal];
    [publicBtn setTitle:@"公开" forState:UIControlStateNormal];
    [publicBtn setTitleColor:kColorMainTextColor forState:UIControlStateNormal];
    publicBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeTwelve];
    [backView addSubview:publicBtn];
    [publicBtn rightToView:backView withSpace:12];
    [publicBtn bottomToView:backView withSpace:10];
    [publicBtn addWidth:55];
    [publicBtn addHeight:20];
    [publicBtn addTarget:self action:@selector(addPublicBtnClick) forControlEvents:UIControlEventTouchUpInside];

    
    
    LGXVerticalButton *picBtn = [LGXVerticalButton new];
    [picBtn setBGColor:kColorBackSecondColor forState:UIControlStateNormal];
    [picBtn setImage:UIImageWithFileName(@"release_photo_images") forState:UIControlStateNormal];
    [picBtn setTitle:@"照片/视频" forState:UIControlStateNormal];
    [picBtn setTitleColor:kColorThirdTextColor forState:UIControlStateNormal];
    picBtn.titleLabel.font = [UIFont customFontWithSize:kFontSizeTwelve];
    [picBtn addTarget:self action:@selector(addPicButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:picBtn];
    [picBtn leftToView:backView withSpace:12];
    [picBtn bottomToView:backView withSpace:40];
    [picBtn addWidth:90];
    [picBtn addHeight:90];
    
    
    
    _contentTextView = [UITextView new];
    _contentTextView.text = @"输入足迹描述...";
    _contentTextView.backgroundColor = [UIColor whiteColor];
    _contentTextView.delegate = self;
    _contentTextView.font = [UIFont customFontWithSize:kFontSizeFifty];
    _contentTextView.textColor = kColorThirdTextColor;
    [backView addSubview:_contentTextView];
    [_contentTextView alignTop:@"0" leading:@"12" bottom:@"145" trailing:@"12" toView:backView];
    
}
-(void)addPlaceBtnClick
{
    SelectDyamicLocationController *svc = [SelectDyamicLocationController new];
    svc.delegate = self;
    [self.navigationController pushViewController:svc animated:YES];
}
-(void)sendValue:(CLLocationCoordinate2D)value withid:(NSString *)region
{
    self.coordinateMine = value;
    self.region = region;
    self.locationString = region;
    
}
-(void)addPublicBtnClick
{
    [TargetEngine controller:nil pushToController:PushTargetPrivacySystem WithTargetId:nil];
}
#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView isEqual:_contentTextView]) {
        self.navigationController.navigationBarHidden = NO;
        if(textView.text.length < 1){
            textView.text = @"输入足迹描述...";
            textView.textColor = kColorThirdTextColor;
        }
    }else{
        if(textView.text.length < 1){
            textView.text = @"输入足迹标题";
            textView.textColor = kColorThirdTextColor;
        }
    }
   
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
   
    
    if ([textView isEqual:_contentTextView]) {
        if([textView.text isEqualToString:@"输入足迹描述..."]){
            textView.text=@"";
            textView.textColor=kColorMainTextColor;
        }
    }else{
        if([textView.text isEqualToString:@"输入足迹标题"]){
            textView.text=@"";
            textView.textColor=kColorMainTextColor;
        }
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView isEqual:_titleTextView]) {
        if (textView.markedTextRange == nil) {
            self.chNumLabel.text=[NSString stringWithFormat:@"%ld",(long)textView.text.length];
        }
    }
   
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""] && range.length > 0) {
        //删除字符肯定是安全的
        return YES;
    }else if ([text isEqualToString:@"\n"]){
        
        [textView resignFirstResponder];
        [self.view endEditing:true];
        return NO;
        
    }else {
        if (textView.text.length - range.length + text.length > 100) {
            return NO;
        }else {
            return YES;
        }
    }
    
    return true;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView isEqual:_contentTextView]) {
        self.navigationController.navigationBarHidden = YES;
    }
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ([textView isEqual:_contentTextView]) {
        NSLog(@"光标位置%ld——%ld",textView.selectedRange.location,textView.selectedRange.length);
        _curserRange = textView.selectedRange;
    }
}

- (void)setOldStringToAttributeString:(NSString *)oldHtmlString {
    NSString *oldString1 = oldHtmlString;
    oldString1 = [oldString1 stringByReplacingOccurrencesOfString:@"</div>" withString:@"<div>"];
    oldString1 = [oldString1 stringByReplacingOccurrencesOfString:@"<img src=\"" withString:@"<div>"];
    oldString1 = [oldString1 stringByReplacingOccurrencesOfString:@"\" style=\"width:99%\"/>" withString:@"<div>"];
    oldString1 = [oldString1 stringByReplacingOccurrencesOfString:@"<div><div>" withString:@"<div>"];
    NSArray *resultArray = [oldString1 componentsSeparatedByString:@"<div>"];
    NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] init];
    for (int i = 0; i < resultArray.count; i ++) {
        NSLog(@"(%@)",resultArray[i]);
        if (![resultArray[i] isEqualToString:@""]) {
            if ([(NSString *)resultArray[i] containsString:@"http"]) {
                NSString *tempString = resultArray[i];
                tempString = [tempString stringByReplacingOccurrencesOfString:_webImageDir withString:@""];
                [_imageDownloadedNameArray addObject:tempString];
                
                NSTextAttachment *attch = [[NSTextAttachment alloc] init];
                // 表情图片
                attch.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:resultArray[i]]]];
                // 设置图片大小
                attch.bounds = CGRectMake(0, 0, _imageWidth, _imageWidth);
                
                // 创建带有图片的富文本
                NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
                [resultAttributedString appendAttributedString:string];
            } else {
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:resultArray[i]];
                [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:_wordFont] range:NSMakeRange(0, [string length])];
                [resultAttributedString appendAttributedString:string];
            }
        }
    }
    _contentTextView.attributedText = resultAttributedString;
    [_contentTextView setFont:[UIFont systemFontOfSize:_wordFont]];
}

- (void)setOldHtmlString:(NSString *)oldHtmlString {
    _oldHtmlString = oldHtmlString;
}

//将HTML字符串转化为NSAttributedString富文本字符串
- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

//审核发表
- (void)releaseButtonClick {
    _hasEndDiv = false;
    _hasHeadDiv = false;
    _imageIndex = 0;
    
    NSAttributedString * att = _contentTextView.attributedText;
    NSMutableAttributedString * resultAtt = [[NSMutableAttributedString alloc]initWithAttributedString:att];
    //    __weak __block UITextView * copy_self = self; //枚举出所有的附件字符串
    [att enumerateAttributesInRange:NSMakeRange(0, att.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        NSTextAttachment * textAtt = attrs[@"NSAttachment"];//从字典中取得那一个图片
        if (textAtt) {
            if (self.hasEndDiv == true) {
                [self.resultString insertString:@"<div>" atIndex:0];
                self.hasHeadDiv = true;
                self.hasEndDiv = false;
            }
            
            UIImage * image = textAtt.image;
            [self.resultString insertString:[NSString stringWithFormat:@"`%ld`",self.imageIndex] atIndex:0];
            [self.imageMarkArray addObject:[NSString stringWithFormat:@"`%ld`",self.imageIndex]];
            [self.imageUploadedArray addObject:image];
            self.imageIndex ++;
        } else {
            if (self.hasEndDiv == false) {
                [self.resultString insertString:@"</div>" atIndex:0];
                self.hasEndDiv = true;
            }
            [self.resultString insertString:[resultAtt attributedSubstringFromRange:range].string atIndex:0];
        }
    }];
    if (_hasEndDiv == true) {
        [_resultString insertString:@"<div>" atIndex:0];
    }
    NSLog(@"%@",_resultString);
    //上传图片，拼接字符串
    if (self.imageUploadedArray.count > 0) {
        [self uploadImageArray];
    } else {
        [self deleteImageFromArray:_imageDownloadedNameArray];//如果图片都删掉了之后，直接清除掉之前所有的图片
        if (self.returnBlock != nil) {
            self.returnBlock(self.resultString);
            [self.navigationController popViewControllerAnimated:true];
        }
    }
}

- (void)uploadImageArray {//_imageUploadedArray,_imageMarkArray
    _imageIndex = 0;//用来计数
    for (int i = 0; i < _imageUploadedArray.count; i ++) {
        [self uploadHeadImage:_imageUploadedArray[i] imageIndex:i];
    }
}

- (void)uploadHeadImage:(UIImage *)image imageIndex:(NSInteger)index{
    //上传地址
//    NSString *postUrl = [NSString stringWithFormat:@"%@/new/index.php?c=merchant&a=saveImg",kBaseUrl];
//    NSData *data =UIImageJPEGRepresentation(image,1.0);
//    NSString *pictureDataString=[data base64Encoding];
//    NSDictionary *dict = @{@"content":[NSString stringWithFormat:@"data:image/jpg;base64,%@",pictureDataString]};
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager POST:postUrl parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        if ([responseObject[@"code"] boolValue]) {
//            [_imageUploadedNameArray addObject:responseObject[@"fileName"]];//返回的是文件的名字，不是全路径
//
//            NSArray *array = [self.resultString componentsSeparatedByString:self.imageMarkArray[index]];
//            NSString *imageDir = appDelegate.webImageDir;
//            if (array.count == 1) {
//                if (index != 0) {//说明是最前面的一个image
//                    self.resultString = [NSMutableString stringWithFormat:@"<img src=\"%@%@\" style=\"width:99%%\"/>%@",imageDir,responseObject[@"fileName"],array[0]];
//                } else {//说明是最后面的一个image
//                    self.resultString = [NSMutableString stringWithFormat:@"%@<img src=\"%@%@\" style=\"width:99%%\"/>",array[0],imageDir,responseObject[@"fileName"]];
//                }
//            } else {
//                self.resultString = [NSMutableString stringWithFormat:@"%@<img src=\"%@%@\" style=\"width:99%%\"/>%@",array[0],imageDir,responseObject[@"fileName"],array[1]];
//            }
//            _imageIndex ++;
//            if (_imageIndex == _imageUploadedArray.count) {//图片都上传完了
//                [MBProgressHUD hideHUDForView:self.view animated:true];
//                NSLog(@"result is _____:%@",self.resultString);
//
//                //删除在编辑中删掉的图片
//                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
//                for (int i = 0; i < _imageDownloadedNameArray.count; i ++) {
//                    for (int j = 0; j < _imageUploadedNameArray.count; j ++) {
//                        if ([_imageDownloadedNameArray[i] isEqualToString:_imageUploadedNameArray[j]]) {
//                            continue;
//                        }
//                    }
//                    [tempArray addObject:_imageDownloadedNameArray[i]];
//                }
//                if (tempArray.count > 0) {//删除剩下的图片
//                    [self deleteImageFromArray:tempArray];
//                }
//
//                //上传内容
//                if (self.returnBlock != nil) {
//                    self.returnBlock(self.resultString);
//                    [self.navigationController popViewControllerAnimated:true];
//                }
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"上传失败");
//        [MBProgressHUD hideHUDForView:self.view animated:true];
//    }];
}

- (void)deleteImageFromArray:(NSArray *)imageArray {
    NSLog(@"删除了%ld张图片",imageArray.count);
    if (imageArray == nil || imageArray.count == 0) {
        return;
    }
    NSMutableString *tempString = [[NSMutableString alloc] init];
    for (int i = 0; i < imageArray.count; i ++) {//删除的照片名称（非全路径），用逗号隔开
        if (i != imageArray.count - 1) {
            [tempString appendString:[NSString stringWithFormat:@"%@,",imageArray[i]]];
        } else {
            [tempString appendString:[NSString stringWithFormat:@"%@",imageArray[i]]];
        }
    }
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    //上传地址
//    NSString *postUrl = [NSString stringWithFormat:@"%@/new/index.php?c=merchant&a=delImg2",kBaseUrl];
//    NSDictionary *dict = @{@"imgDate":_webImageDir,
//                           @"imgName":tempString
//                           };
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager POST:postUrl parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //记录返回的图片名字
//        [MBProgressHUD hideHUDForView:self.view animated:true];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"上传失败");
//        [MBProgressHUD hideHUDForView:self.view animated:true];
//    }];
}

#pragma mark ------------图片处理------------------
//缩小图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//插入照片
- (void)addPicButtonClick {
    
    UIAlertController*ZhengC=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction*XiangCe=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }];
    UIAlertAction*ZhaoXiang=[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.pickerController animated:YES completion:nil];
        
    }];
    UIAlertAction*  Cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ZhengC addAction:Cancel];
    [ZhengC addAction:XiangCe];
    [ZhengC addAction:ZhaoXiang];
    [self presentViewController:ZhengC animated:YES completion:nil];
}

#pragma mark ------ UIImagePickerControllerDelegate ----------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"选择了一张图片");
    UIImage *userImage = [self fixOrientation:info[UIImagePickerControllerEditedImage]];
    userImage = [self scaleImage:userImage toScale:1];
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithAttributedString:_contentTextView.attributedText];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = userImage;
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, _imageWidth, _imageWidth);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri replaceCharactersInRange:_curserRange withAttributedString:string];
    
    
    // 用label的attributedText属性来使用富文本
    _contentTextView.attributedText = attri;
    [_contentTextView setFont:[UIFont systemFontOfSize:_wordFont]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
