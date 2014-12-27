//
//  MainViewController.h
//  socialDemoApp
//
//  Created by NOTOITSOLUTIONS on 22/12/14.
//  Copyright (c) 2014 NOTO SOLUTIONS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FbGraph.h"
#import <FacebookSDK/FacebookSDK.h>
@interface MainViewController : UIViewController
{
    IBOutlet UIImageView *profileImage;
    IBOutlet UIImageView *CoverPivImage;
   IBOutlet UITextView *AllData;
    FbGraph *fbGraph;
    NSString *LoginName;
      FbGraphResponse *fb_graph_response,*meProfile;
    NSMutableArray *arrFacebookFriend,*arrFbFriendIDs,*Selfpictures;
    NSString *strAllFacebookFriendIDs;
}
@property (nonatomic, retain)IBOutlet UIButton *FaceBookButton;
@property (strong, nonatomic) NSMutableDictionary *postParams;
-(IBAction)postImageTimeline:(id)sender;
-(IBAction)inviteFriendsBtn:(id)sender;
- (IBAction)logout:(id)sender;
-(IBAction)Facebokalbums:(id)sender;
-(IBAction)FacebokFriends:(id)sender;
-(IBAction)FacebokAct:(id)sender;

@end
