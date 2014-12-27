//
//  MainViewController.m
//  socialDemoApp
//
//  Created by NOTOITSOLUTIONS on 22/12/14.
//  Copyright (c) 2014 NOTO SOLUTIONS. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#import "MainViewController.h"
#import "AppDelegate.h"
#import "EditProfileAlbum.h"
#import "TwitterViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize postParams;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)Facebokalbums:(id)sender
{
    
    if (FBSession.activeSession.isOpen)
    {
    EditProfileAlbum *editalbum=[[EditProfileAlbum alloc]initWithNibName:@"EditProfileAlbum" bundle:nil];
    [self presentViewController:editalbum animated:YES completion:nil];
    }
    else
    {
        UIAlertView *fb_alert = [[UIAlertView alloc] initWithTitle:@"THANK YOU" message:@"Firstly login in app......" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [fb_alert show];
        
        
    }
}

-(IBAction)FacebokAct:(id)sender
{
    
    if (FBSession.activeSession.isOpen)
    {
        UIAlertView *fb_alert = [[UIAlertView alloc] initWithTitle:@"THANK YOU" message:@"Already login in app......" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [fb_alert show];

       }
    else
    {
       
        [FBSession openActiveSessionWithPublishPermissions:[NSArray arrayWithObjects:@"publish_stream",
                                                            nil] defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:^(FBSession *session,
                                                                                                                                                       
                                                                                                                                                       FBSessionState state, NSError *error) {
            
            // Retrieve the app delegate
            AppDelegate* appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
            [appDelegate sessionStateChanged:session state:state error:error];
            //         if (FBSession.activeSession.state == FBSessionStateOpen
            //             || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
            [self FaceBookRequest];
            ////             if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
            ////                 // No permissions found in session, ask for it
            ////                 [FBSession.activeSession reauthorizeWithPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
            ////                                                            defaultAudience:FBSessionDefaultAudienceFriends
            ////                                                          completionHandler:^(FBSession *session, NSError *error)
            ////                  {
            ////                      if (!error)
            ////                      {
            ////                          // If permissions granted, publish the story
            ////
            ////                      }
            ////                  }];
            ////             }
            ////             else
            ////             {
            ////                 // If permissions present, publish the story
            ////                 //[self publishDataOnUsersWall];
            ////             }
            ////
            ////         }
            //         else{
            //                      }
            //         
        }];

        
    }
    }
-(void)SetUserCoverpic:(NSDictionary<FBGraphUser> *)userresult
{
    NSString *coverPic = [[userresult objectForKey:@"cover" ]objectForKey:@"source"];
    CoverPivImage.image= [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:coverPic]]];
    
   
}
-(IBAction)postImageTimeline:(id)sender
{
    if (FBSession.activeSession.isOpen)
    {
        [self publishDataOnUsersWall];
        
        
    }
    else
    {
        UIAlertView *fb_alert = [[UIAlertView alloc] initWithTitle:@"THANK YOU" message:@"Already login in app......" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [fb_alert show];
    }

  
}
- (void)publishDataOnUsersWall
{
    NSString *strMsg = [NSString stringWithFormat:@"%@ is now using TestingApp",LoginName];
    
    self.postParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                       @"", @"name",
                       @"https://github.com/BhomiaAshish151", @"link",
                       @"http://cdn2.business2community.com/wp-content/uploads/2014/02/get-started-with-ab-testing-today.png", @"picture",
                       @"", @"caption",
                       strMsg, @"description",
                       nil];
    
    [FBRequestConnection
     startWithGraphPath:@"me/feed"
     parameters:self.postParams
     HTTPMethod:@"POST"
     completionHandler:^(FBRequestConnection *connection,
                         id result,
                         NSError *error) {
         
         //         NSString *alertText;
         //         if (error) {
         //             alertText = [NSString stringWithFormat:
         //                          @"error: domain = %@, code = %d",
         //                          error.domain, error.code];
         //         } else {
         //             alertText = [NSString stringWithFormat:
         //                          @"Posted action, id: %@",
         //                          [result objectForKey:@"id"]];
         //         }
         //         // Show the result in an alert
         //         [[[UIAlertView alloc] initWithTitle:@"Result"
         //                                     message:alertText
         //                                    delegate:self
         //                           cancelButtonTitle:@"OK!"
         //                           otherButtonTitles:nil]
         //          show];
     }];
}

-(void)FaceBookRequest
{
    if (FBSession.activeSession.isOpen) {
        
            //<#Code that can potentially throw an exception#>
            
            [[FBRequest requestForMe] startWithCompletionHandler:
             ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                 if (!error) {
                     //NSLog(@"%@",user.email);
                     [self SetUserValue:user];
                 }
             }];
            }
}


-(IBAction)inviteFriendsBtn:(id)sender
{
    FBFriendPickerViewController *friendPickerController = [[FBFriendPickerViewController alloc] init];
    friendPickerController.title = @"Pick Friends";
    [friendPickerController loadData];
    
    // Use the modal wrapper method to display the picker.
    [friendPickerController presentModallyFromViewController:self animated:YES handler:
     ^(FBViewController *sender, BOOL donePressed) {
         
         if (!donePressed) {
             return;
         }
         
         NSString *message;
         
         if (friendPickerController.selection.count == 0) {
             message = @"<No Friends Selected>";
         } else {
             
             NSMutableString *text = [[NSMutableString alloc] init];
             
             // we pick up the users from the selection, and create a string that we use to update the text view
             // at the bottom of the display; note that self.selection is a property inherited from our base classnsl
             NSLog(@"FBGraphUser%@",friendPickerController.selection);
             for (id<FBGraphUser> user in friendPickerController.selection) {
                 if ([text length]) {
                     [text appendString:@", "];
                 }
                 [text appendString:user.id];
             }
             message = text;
         }
         
         NSString *to =message;
         // NSString *to=[NSString stringWithformet@"%@",userId];
         NSMutableDictionary* params =   [NSMutableDictionary dictionaryWithObjectsAndKeys:to,@"to",nil];
         [FBWebDialogs presentRequestsDialogModallyWithSession:nil
                                                       message:[NSString stringWithFormat:@"Please share problem with Ashish Bhomia"] title:@"Helping Message"  parameters:params handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error)
          {
              if (error) {
                  // Case A: Error launching the dialog or sending request.
                  NSLog(@"Error sending request.");
              } else {
                  if (result == FBWebDialogResultDialogNotCompleted) {
                      // Case B: User clicked the "x" icon
                      NSLog(@"User canceled request.");
                  } else if (result == FBWebDialogResultDialogCompleted){
                      NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                      if (![urlParams valueForKey:@"request"]) {
                          [[[UIAlertView  alloc]initWithTitle:@"Cancel Request" message:@"Request has been cancel." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                          // User clicked the Cancel button
                          NSLog(@"User canceled request.");
                      } else {
                          [[[UIAlertView  alloc]initWithTitle:@"Success" message:@"Sent Request Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                          // User clicked the Send button
                          // NSString *requestID = [urlParams valueForKey:@"request"];
                          //NSLog(@"Request ID: %@", requestID);
                      }
                      NSLog(@"result %u",result);
                  }
              }
          }];
         
     }];
    
    
}

-(IBAction)FacebokFriends:(id)sender
{
    if (FBSession.activeSession.isOpen)
    {
        [self userFriendList];
    }
    else
    {
    UIAlertView *fb_alert = [[UIAlertView alloc] initWithTitle:@"Facebok" message:@"Firstly login in app..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [fb_alert show];
    
    }
    
}

-(void)SetUserValue:(NSDictionary<FBGraphUser> *)user
{
    
        NSLog(@"user%@",user);
    LoginName=user.first_name;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:user options:0 error:nil];
    NSString* jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
  AllData.text=jsonString;
   NSString *tocken=[[FBSession activeSession] accessToken] ;
    NSLog(@"tocken%@",tocken);
    NSString* Userprofilepicture=@"https://graph.facebook.com/me/?access_token=%@&fields=picture";
    NSString *UserprofilepictureUrlStr=[NSString stringWithFormat:Userprofilepicture,tocken];
    [self callUserprofilepicture:UserprofilepictureUrlStr];
    
      }
- (IBAction)logout:(id)sender
{
    
    UIAlertView *fb_alert = [[UIAlertView alloc] initWithTitle:@"THANK YOU" message:@"Logged out of facebook..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [fb_alert show];
    
    NSLog(@"Logged out of facebook");
    if (FBSession.activeSession.isOpen)
    {
        [FBSession.activeSession closeAndClearTokenInformation];
        [FBSession.activeSession close];
        [FBSession setActiveSession:nil];
        // If the session is closed
        
        // Show the user the logged-out UI
        [FBSession.activeSession closeAndClearTokenInformation];
        
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies])
        {
            NSString* domainName = [cookie domain];
            NSRange domainRange = [domainName rangeOfString:@"facebook"];
            if(domainRange.length > 0)
            {
                [storage deleteCookie:cookie];
            }
        }
        profileImage.image=[UIImage imageNamed:@"profileNo.png"];
        CoverPivImage.image=[UIImage imageNamed:@"Home_android_background.jpg"];
        AllData.text=@"Please Login to See data";
        
    }
    
    
}

-(void)SetUserPic:(NSDictionary<FBGraphUser> *)user
{
  
   
}

-(void)callUserprofilepicture:(NSString *)passURL
{
    dispatch_async( kBgQueue, ^{
        NSURL *url=[NSURL URLWithString:[passURL  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"hhh    %@",url);
        NSData *data=[NSData dataWithContentsOfURL:url];
    //  profileImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        if (data!=NULL)
        {
            [self performSelectorOnMainThread:@selector(fetchcallUserprofilepicture:)
                                   withObject:data waitUntilDone:YES];
        }
        else
        {
            
           }
        
    });
}
- (void)fetchcallUserprofilepicture:(NSData *)responseData {
    //parse out the json data
    
    
    NSLog(@"1111111111");
    NSError* error;
    NSDictionary* jsonProfile = [NSJSONSerialization
                                 JSONObjectWithData:responseData //1
                                 
                                 options:kNilOptions
                                 error:&error];
    
    NSLog(@"jsonProfile%@",jsonProfile);
    NSString *id_str=[[[jsonProfile objectForKey:@"picture" ]objectForKey:@"data"]objectForKey:@"url"];
    profileImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: id_str]]];
    [FBRequestConnection startWithGraphPath:@"me?fields=id,name,cover"
                          completionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *userresult, NSError *error) {
                              if (!error) {
                                  // Sucess! Include your code to handle the results here
                                  NSLog(@"user events: %@", userresult);
                                  [self SetUserCoverpic:userresult];
                                  //                                  NSString *id_str=[NSString stringWithFormat:@"%@",[[[result objectForKey:@"cover"]objectAtIndex:0]objectForKey:@"source"]];
                                  //                                  NSLog(@"id_str%@",id_str);
                              } else {
                                  // An error occurred, we need to handle the error
                                  // See: https://developers.facebook.com/docs/ios/errors
                              }
                          }];

}
- (void)userFriendList
{
    NSString *query =@"SELECT name, pic_square, uid FROM user WHERE uid in (SELECT uid2 FROM friend where uid1 = me())";
    
    // Set up the query parameter
    NSDictionary *queryParam =
    [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
    // Make the API request that uses FQL
    [FBRequestConnection startWithGraphPath:@"/fql"
                                 parameters:queryParam
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error) {
                              if (error) {
                                  NSLog(@"Error: %@", [error localizedDescription]);
                              } else {
                                  NSLog(@"Result: %@", result);
                                  // show result
                                  arrFacebookFriend = (NSMutableArray *) [result objectForKey:@"data"];
                                  
                                  
                                  if(arrFacebookFriend.count  > 0)
                                  {
                                      for(int i=0; i<[arrFacebookFriend count]; i++)
                                      {
                                          NSString *strUID = [[arrFacebookFriend objectAtIndex:i] valueForKey:@"uid"];
                                          [arrFbFriendIDs addObject:strUID];
                                      }
                                      
                                      NSString *friends = [arrFbFriendIDs componentsJoinedByString:@","];
                                      strAllFacebookFriendIDs = friends;
                                      [self inviteViaFacebook];
                                  }
                              }
                          }];
}
-(void)inviteViaFacebook
{
    if(strAllFacebookFriendIDs.length > 0)
    {
        NSString *to = [NSString stringWithFormat:@"%@", strAllFacebookFriendIDs];
        // NSString *to=[NSString stringWithformet@"%@",userId];
        NSMutableDictionary* params =   [NSMutableDictionary dictionaryWithObjectsAndKeys:to,@"to",nil];
        [FBWebDialogs presentRequestsDialogModallyWithSession:nil
                                                      message:[NSString stringWithFormat:@"Hello Please checkout this app.... its awesome"] title:@"NothingYak"  parameters:params handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error)
         {
             if (error) {
                 // Case A: Error launching the dialog or sending request.
                 //NSLog(@"Error sending request.");
             } else {
                 if (result == FBWebDialogResultDialogNotCompleted) {
                     // Case B: User clicked the "x" icon
                     //NSLog(@"User canceled request.");
                 } else if (result == FBWebDialogResultDialogCompleted){
                     NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                     if (![urlParams valueForKey:@"request"]) {
                         [[[UIAlertView  alloc]initWithTitle:@"Cancel Invitation" message:@"Invitation cancelled, Please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                         // User clicked the Cancel button
                         //NSLog(@"User canceled request.");
                     } else {
                         [[[UIAlertView  alloc]initWithTitle:@"Success" message:@"Invitation sent successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                         // User clicked the Send button
                         // NSString *requestID = [urlParams valueForKey:@"request"];
                         //NSLog(@"Request ID: %@", requestID);
                     }
                     //NSLog(@"result %u",result);
                 }
             }
         }];
    }
    else
    {
       // [self facebookLoginAndFriends];
    }
}
- (NSDictionary*)parseURLParams:(NSString *)query
{
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [[kv objectAtIndex:1]
         stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    return params;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    Selfpictures=[[NSMutableArray alloc]init];
    arrFacebookFriend=[[NSMutableArray alloc]init];
    arrFbFriendIDs=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)TwitterAct:(id)sender
{
    TwitterViewController *newclass=[[TwitterViewController alloc]initWithNibName:@"TwitterViewController" bundle:Nil];
    [self.navigationController pushViewController:newclass animated:YES];
   }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
