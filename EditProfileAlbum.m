//
//  EditProfileAlbum.m
//  SelfieGame
//
//  Created by NOTOITSOLUTIONS on 10/12/13.
//  Copyright (c) 2013 NOTO SOLUTIONS. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#import "FbGraphFile.h"
#import "EditProfileAlbum.h"
#import "SDWebImageManager.h"


#import "AlbumsImagesViewController.h"
#import <FacebookSDK/FacebookSDK.h>

#import "AppDelegate.h"

@interface EditProfileAlbum ()

@end

@implementation EditProfileAlbum
@synthesize fbGraph,albumArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    //NSString *urlString1=[NSString stringWithFormat:@"https://graph.facebook.com/%@/albums?access_token=%@",obj.uid,fbGraph.accessToken];
}

-(void)CallFbAlbum1
{
    
    NSString *client_id = @"1422877921258372";
    self->fbGraph = [[FbGraph alloc] initWithFbClientID:client_id];
    [fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(ProcessFBData)andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins" andSuperView:self.view];
}
- (void)ProcessFBData {
    
    if (FBSession.activeSession.isOpen) {
        
        
        
        
        
        [[[FBRequest alloc]  initWithSession:FBSession.activeSession
                                   graphPath:[NSString stringWithFormat:@"me/albums"]] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                
                 ////NSLog(@"%@",user);
                 //NSLog(@"Album %@",albumDict);
                 albumArray=[user objectForKey:@"data"];
                 if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                 {
                     CGSize result = [[UIScreen mainScreen] bounds].size;
                     if(result.height == 480)
                     {
                         newsFeedTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 44.0, 320.0, 425.0) style:UITableViewStylePlain];
                         newsFeedTable.separatorStyle = UITableViewCellSeparatorStyleNone;
                         newsFeedTable.dataSource = self;
                         newsFeedTable.delegate = self;
                         
                         [self.view addSubview:newsFeedTable];
                     }
                     if(result.height == 568)
                     {
                         newsFeedTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 44.0, 320.0, 525.0) style:UITableViewStylePlain];
                         newsFeedTable.dataSource = self;
                         newsFeedTable.separatorStyle = UITableViewCellSeparatorStyleNone;
                         newsFeedTable.delegate = self;
                         
                         [self.view addSubview:newsFeedTable];
                     }
                 }
                 
                 [newsFeedTable reloadData];
                 
             }
         }];
        
        
    }
    
    
    //        meAlbum = [fbGraph doGraphGet:@"me/albums" withGetVars:nil];
    //        NSLog(@"getMe Albums:  %@", meAlbum.htmlResponse);
    //        //NSData* arrayData = [NSData data:file];
    //        SBJSON *parser = [[SBJSON alloc] init];
    //        NSDictionary *albumDict = [parser objectWithString:meAlbum.htmlResponse error:nil];
    //        //[parser release];
    //
    //        //there's 2 additional dictionaries inside this one on the first level ('data' and 'paging')
    //
    //
    //        NSLog(@"Album %@",albumDict);
    //        albumArray=[albumDict objectForKey:@"data"];
    
    /*NSLog(@"Arr_data Temop%@",albumArray);
     if (![albumArray count]==0) {
     for (int i=0; i <[albumArray count]; i++)
     {
     NSString *cover_photo_str=[NSString stringWithFormat:@"%@",[[[albumDict objectForKey:@"data"]objectAtIndex:i]objectForKey:@"cover_photo"]];
     NSLog(@"cover_photo_str%@",cover_photo_str);
     NSString *idstr=[NSString stringWithFormat:@"%@",[[[albumDict objectForKey:@"data"]objectAtIndex:i]objectForKey:@"id"]];
     NSLog(@"idstr%@",idstr);
     NSString *Link_str=[NSString stringWithFormat:@"%@",[[[albumDict objectForKey:@"data"]objectAtIndex:i]objectForKey:@"name"]];
     NSLog(@"id_str%@",Link_str);
     [albumId addObject:idstr];
     [albumCoverPics addObject:cover_photo_str];
     [albumLinks addObject:Link_str];
     }
     NSLog(@"Array Of Cover photo%@",albumCoverPics);
     NSLog(@"Array Of Links%@",albumLinks);
     NSLog(@"albumId%@",albumId);
     
     
     }*/
    
    
    
    
    
    
}

-(IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    // return [pic count];
    return [albumArray count];
    //return 0;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellIdentifier = @"Cell";
    UILabel  *lblAlbumTitle;
    UIImageView *imgAlbum;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        lblAlbumTitle = [[UILabel alloc]initWithFrame:CGRectMake(70,18,220,18)];
        [lblAlbumTitle setFont:[UIFont fontWithName:@"AvantGarde Bk Bt" size:18]];
        lblAlbumTitle.backgroundColor = [UIColor clearColor];
        //[lblEventName setTextColor:[UIColor colorWithRed:180 green:216 blue:174 alpha:1.0]];
        [lblAlbumTitle setTextColor:[UIColor blackColor]];
        lblAlbumTitle.textAlignment = NSTextAlignmentLeft;
        
        imgAlbum=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60,60)];
        
        lblAlbumTitle.tag=110;
        imgAlbum.tag=111;
        
        
    }
    else
    {
        imgAlbum = (UIImageView *)[cell.contentView viewWithTag:111];
        lblAlbumTitle = (UILabel *)[cell.contentView viewWithTag:110];
        
    }
    
    
    @try {
        //<#Code that can potentially throw an exception#>
        
        NSDictionary *item1 = [albumArray objectAtIndex:[indexPath row]];
        //https://graph.facebook.com/10201831141792763/picture?type=album
        
        //NSString *image =[item1 objectForKey:@"image"];
        
        [lblAlbumTitle setText:[item1 objectForKey:@"name"]];
        
        NSString *coverImage = [item1 objectForKey:@"cover_photo"];
        NSString *image = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=album",coverImage];
        if (image != (id)[NSNull null] || image.length != 0 )
        {
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager downloadWithURL:[NSURL URLWithString:image]
                             options:0
                            progress:^(NSUInteger receivedSize, long long expectedSize)
             {
                 // progression tracking code
             }
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
             {
                 if (image)
                 {
                     // ProfileImage.image=image;
                     // do something with image
                     
                     [imgAlbum setImage:image];
                 }
             }];
        }
        
        
        
        [cell.contentView addSubview:imgAlbum];
        [cell.contentView addSubview:lblAlbumTitle];
    }
    @catch (NSException *exception) {
        //<#Handle an exception thrown in the @try block#>
        
//        NSMutableDictionary *errorDict = [NSMutableDictionary dictionary];
//        [errorDict setValue:@"EditProfileAlbum" forKey:@"page_name"];
//        [errorDict setValue:[exception reason] forKey:@"error_detail"];
//        [errorDict setValue:@"cellForRowAtIndexPath:" forKey:@"function_name"];
//        [errorDict setValue:[exception name] forKey:@"error_name"];
//        
//        AppDelegate * appdel = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//        [appdel sendErrorMessage:errorDict];
        
    }
    @finally {
        
        //<#Code that gets executed whether or not an exception is thrown#>
    }
    
	return cell;
}


- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        //<#Code that can potentially throw an exception#>
        NSDictionary *item1 = [albumArray objectAtIndex:[indexPath row]];
        
        NSString *albumID =[item1 objectForKey:@"id"];
        AlbumsImagesViewController *AlbumsClass=[[AlbumsImagesViewController alloc]initWithNibName:@"AlbumsImagesViewController" bundle:nil];
        AlbumsClass.albumID = albumID;
        
        [self presentViewController:AlbumsClass  animated:YES completion:nil];
    }
    @catch (NSException *exception) {
        //<#Handle an exception thrown in the @try block#>
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FacebookTesting" message:@"Error in processing request, Please try again later!." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            //Show alert here
            [alert show];
        });
//        NSMutableDictionary *errorDict = [NSMutableDictionary dictionary];
//        [errorDict setValue:@"EditProfileAlbum" forKey:@"page_name"];
//        [errorDict setValue:[exception reason] forKey:@"error_detail"];
//        [errorDict setValue:@"didSelectRowAtIndexPath:" forKey:@"function_name"];
//        [errorDict setValue:[exception name] forKey:@"error_name"];
//        
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        [appDelegate sendErrorMessage:errorDict];
        
    }
    @finally {
        
        //<#Code that gets executed whether or not an exception is thrown#>
    }
    
}
-(IBAction)done:(id)sender
{
    
}
- (void)viewDidLoad
{
//    _indicator.hidesWhenStopped = YES;
    /// Init indicator
//    TSActivityIndicatorView *customIndicator =
//    [[TSActivityIndicatorView alloc]
//     initWithFrame:CGRectMake(160-17, 100, 35, 55)];
//    
//    /// Add frames as strings
//    customIndicator.frames = @[@"activity-indicator-1",@"activity-indicator-2",@"activity-indicator-3",@"activity-indicator-4",@"activity-indicator-5",@"activity-indicator-6",@"activity-indicator-7",@"activity-indicator-8",@"activity-indicator-9",                               @"activity-indicator-10",@"activity-indicator-11",@"activity-indicator-12"];
//    /// Add to subview
//    //[self.view insertSubview:_indicator aboveSubview:newsFeedTable];
//    
//    /// And start animate
//    customIndicator.duration = 0.5f;
//    //    [customIndicator startAnimating];
    
    
    /// simple after delay block
    double delayInSeconds = 3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        /// hidesWhenStopped is default set to YES. We don't want to hide indicator after stop.
//        customIndicator.hidesWhenStopped = NO;
//        
//        /// And stop.
//        [customIndicator stopAnimating];
        /// Is still on screen.
    });
    
    
    
    ShowLbl.text=@"Albums";
    [ShowLbl setFont:[UIFont fontWithName:@"AvantGarde Bk Bt" size:19]];
    cancelBtn.titleLabel.font = [UIFont fontWithName:@"AvantGarde Bk Bt" size:13.0];
    albumArray=[[NSMutableArray alloc]init];
    //[self.view insertSubview:self.indicator aboveSubview:newsFeedTable];
    [self ProcessFBData ];
    [super viewDidLoad];
//    [_indicator startAnimating];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
