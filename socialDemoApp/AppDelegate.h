//
//  AppDelegate.h
//  socialDemoApp
//
//  Created by NOTOITSOLUTIONS on 22/12/14.
//  Copyright (c) 2014 NOTO SOLUTIONS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FbGraphFile.h"
#import "MainViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>
{
    MainViewController *newclass;
    UINavigationController *nav;
}
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)MainViewController *newclass;
@property(nonatomic,retain)UINavigationController *nav;
@end
