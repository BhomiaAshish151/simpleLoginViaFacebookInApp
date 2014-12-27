//
//  TwitterViewController.h
//  socialDemoApp
//
//  Created by NOTOITSOLUTIONS on 22/12/14.
//  Copyright (c) 2014 NOTO SOLUTIONS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthConsumer.h"

@interface TwitterViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *webview;
    OAConsumer* consumer;
    OAToken* requestToken;
    OAToken* accessToken;
}
@property (nonatomic,strong) OAToken* accessToken;
@property (nonatomic, retain) IBOutlet UIWebView *webview;
@property (nonatomic, retain) NSString *isLogin;
@end