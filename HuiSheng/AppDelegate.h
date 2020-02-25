//
//  AppDelegate.h
//  HuiSheng
//
//  Created by 汪伟 on 2018/12/4.
//  Copyright © 2018 Guangzhou YouPin Trade Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+ (instancetype)sharedDelegate;
@property (strong, nonatomic) MainViewController *tabBarController;
- (void)showGuideView;

@end

