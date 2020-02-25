//
//  TargetEngine.h
//  YaYaGongShe
//
//  Created by icash on 16-3-5.
//  Copyright (c) 2016年 iCash. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 收到的userInfo : @{@"id":1,@"num":2}
static NSString *const kCommentSuccessedNotice = @"notic.commentSuccessed";

typedef enum : NSUInteger {
    PushTargetNone = 0, /// 什么都不是
    PushTargetGoodsDetail = 1, /// 详情页，传goods_id
    PushTargetCartView = 2, /// 跳转购物车
    PushTargetCreateOrderView = 3, /// 申请订单界面
    PushTargetJieSuan = 4, /// 结算页
    
    PushTargetRegisteredView = 5, /// 注册


    PushTargetTimeSystem = 100,///时间设置
    PushTargetNearbyPeoples = 101,///附近的人
    PushTargetFootprintDetails = 102,///足迹详情
    PushTargetMessagesView = 103,///消息
    PushTargetMyFriendsView = 104,///我的好友
    PushTargetMyHomePageView = 105,///我的主页
    PushTargetSystemView = 106,///设置
    PushTargetPersonalInforView = 107,///个人信息
    PushTargetAccountSecurity = 108,///账户安全
    PushTargetChangePassword = 109,///修改密码
    PushTargetShowTimeSystem = 110,///显示设置
    PushTargetNearbyAreaSystem = 111,///附近足迹设置
    PushTargetFriendsFootprint = 112,///好友足迹
    PushTargetAllComments = 113,///全部评论
    PushTargetReleaseFootprints = 114,///足迹发布
    PushTargetPrivacySystem = 115,///足迹发布隐私设置
    PushTargetFooterprintsToReport = 116,///足迹举报
    PushTargetSafetyInspection = 117,///安全校验
    PushTargetChangePhoneNumber = 118,///更换手机号
    PushTargetMineCollects = 119,///我的收藏

    
    
    


    
    
    
    PushTargetLogin = 220, /// 跳转登录
    PushTargetPreviewPhoto = 666, /// 大图查看
    PushTargetCopy = 1001, /// 复制
    PushTargetThirdPartyLogin = 1009,///第三方登录
    PushTargetAccountAssociated = 1010,///关联登录
    
    
    
    PushTargetTencentMapService = 2001, /// 腾讯地图服务
    
    PushTargetMyHomeView = 3000,///首页

    
    
    
} PushTargetType;

#define kTargetEngine [TargetEngine sharedInstance]
@interface TargetEngine : NSObject

/// 单例初始化
+ (instancetype)sharedInstance;
+ (CGSize)sizeWithXSizeString:(NSString *)str;
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentViewController;
/// 获取当前viewController
+ (UIViewController *)getRealViewController;
/**
 * 推送，如果fromController为nil，则会自动判断
 * target的格式 ： {"msg_type":"push","cmd":"story_preview","params":{"id":"1063201"}}
 * 增加share ,可同时被调用
 * 具体规则见：http://doc.epetbar.com:801/doku.php?id=target  或 实现方法
 * 一般是不需要toController的
 */
+ (void)pushViewController:(UIViewController *)toController fromController:(UIViewController *)fromController withTarget:(id)targetJson;
/**
 * 跳转某个界面
 * targetType = PushTargetWebView 时,pushId 是URL
 * 当targetType 是 PushTargetChat 时， pushId需要传入session_id 如：1_xx , 2_xx 。使用时，请询问我
 */
+ (void)controller:(UIViewController *)fromController pushToController:(PushTargetType)targetType WithTargetId:(NSString *)pushId;

@end
