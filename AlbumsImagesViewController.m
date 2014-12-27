//
//  AlbumsImagesViewController.m
//  SelfieGame
//
//  Created by NOTOITSOLUTIONS on 21/01/14.
//  Copyright (c) 2014 NOTO SOLUTIONS. All rights reserved.
//

#import "AlbumsImagesViewController.h"

#import "EditProfileAlbum.h"

#import "SDWebImageManager.h"

#import <FacebookSDK/FacebookSDK.h>

@interface AlbumsImagesViewController ()

@end

@implementation AlbumsImagesViewController
@synthesize fbGraph,albumArray;
@synthesize  _albumID;
int numRows;
- (NSString * )albumID {
    return _albumID;
}

- (void)setAlbumID:(NSString *)newValue {
    _albumID = newValue;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)viewDidLoad
{
//    _indicator.hidesWhenStopped = YES;
    /// Init indicator
    
    //    [customIndicator startAnimating];
    
    
    /// simple after delay block
    double delayInSeconds = 3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        /// hidesWhenStopped is default set to YES. We don't want to hide indicator after stop.
        
        /// Is still on screen.
    });

    
    NSLog(@"back");
//    [_indicator startAnimating];
    [self ProcessFBData ];
   
//    [self.view addSubview:_indicator];
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
  [[UIBarButtonItem appearance] setTintColor:[UIColor orangeColor]];
    
}

- (void)ProcessFBData {
//    [_indicator startAnimating];
    if (FBSession.activeSession.isOpen) {
        
        
        
        
        
        [[[FBRequest alloc]  initWithSession:FBSession.activeSession
                                   graphPath:[NSString stringWithFormat:@"%@/photos",self.albumID]] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 // [_indicator stopAnimating];
                 NSLog(@"%@",user);
                 //NSLog(@"Album %@",albumDict);
                 albumArray=[user objectForKey:@"data"];
                 if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                 {
                     CGSize result = [[UIScreen mainScreen] bounds].size;
                     if(result.height == 480)
                     {
                         tblFBPics = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 44.0, 320.0, 440.0) style:UITableViewStylePlain];
                         tblFBPics.backgroundColor=[UIColor blackColor];
                         tblFBPics.separatorStyle = UITableViewCellSeparatorStyleNone;
                         tblFBPics.dataSource = self;
                         tblFBPics.delegate = self;
                         
                         [self.view addSubview:tblFBPics];
                     }
                     if(result.height == 568)
                     {
                         tblFBPics = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 44.0, 320.0, 540.0) style:UITableViewStylePlain];
                         tblFBPics.backgroundColor=[UIColor blackColor];
                         tblFBPics.dataSource = self;
                         tblFBPics.separatorStyle = UITableViewCellSeparatorStyleNone;
                         tblFBPics.delegate = self;
                         
                         [self.view addSubview:tblFBPics];
                     }
                 }

                 [tblFBPics reloadData];
                 
             }
         }];
        
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    // return [pic count];
    //return [albumArray count];
    numRows = 0;
    if([albumArray count] <= 4)
    {
        numRows = 1;
    }
    else
    {
        numRows = (int)ceil(((float)[albumArray count])/4) ;
        NSLog(@"%d",numRows);
        
    }
    return numRows;
    
    //return 0;
}
-(UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a bitmap context.
    UIGraphicsBeginImageContextWithOptions(newSize, YES, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [_indicator stopAnimating];
    CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor blackColor];
        
        
    }
    
    //int section = indexPath.section;
    NSLog(@"Ashish Sharma%d",[albumArray count]);
    
    int row = indexPath.row;
    int from = 4 * row;
    int to = 4 + from;
    NSLog(@"%d",row);
    
    NSLog(@"%d",from);
    
    NSLog(@"%d",to);
    
    if(to > [albumArray count])
    {
        to = [albumArray count];
    }
    //NSMutableArray *sectionItems = [suggestions objectAtIndex:indexPath.row];
    
    //int n = [sectionItems count];
    int i=0;
    int xAxis = 0;
    for(i=from;i<to;i++)
    {
        NSDictionary *item1 = [albumArray objectAtIndex:i];
        
        // lblUserName.text =[suggestions objectAtIndex:[indexPath row]];
        
        
        NSString *image =[item1 objectForKey:@"picture"];
        NSLog(@"image%@",image);
        
        
        
        CGRect rect = CGRectMake(5+80*xAxis, 5, 70, 70);
        UIButton *button=[[UIButton alloc] initWithFrame:rect];
        
        [button setFrame:rect];
        [button setBackgroundImage:[UIImage imageNamed:@"profileNo.png"]	forState:UIControlStateNormal];
        //				UIImage *buttonImageNormal=[UIImage imageNamed:item.image];
        // NSString *friendsImage=[FacebookFriendsImage objectAtIndex:i];
        
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
                     UIImage* scaledImgV = [self imageWithImage:image scaledToSize:CGSizeMake(70,70)];
                     
                     NSLog(@" View will Scaled image horizontal (%@), width: %.0f, height: %.0f, scale: %0.2f",scaledImgV,scaledImgV.size.width, scaledImgV.size.height, scaledImgV.scale);

                     
                     [button setBackgroundImage:scaledImgV	forState:UIControlStateNormal];
                 }
             }];
        }
        
        
        [button setContentMode:UIViewContentModeCenter];
        button.layer.cornerRadius = 35; // this value vary as per your desire
        button.clipsToBounds = YES;
        button.tag = i;
        NSLog(@"....tag....%d", button.tag);
        
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
        
        
        
        
        
        
        xAxis ++;
        //         NSString *string = [NSString stringWithFormat:@"%d", i];
        
        
        
    }
    
    return cell;
}

-(IBAction)buttonPressed:(id)sender {
//    UIButton *btn = (UIButton *)sender  ;
//    
//    NSDictionary *item1 = [albumArray objectAtIndex:btn.tag];
//    NSMutableArray *imageArray = [item1 objectForKey:@"images"];
//    
//    cropViewController *cropClass=[[cropViewController alloc]initWithNibName:@"cropViewController" bundle:Nil];
//    if([imageArray count]>0)
//    {
//        NSDictionary *itemimage = [imageArray objectAtIndex:0];
//        
//        cropClass.imgURL = [itemimage objectForKey:@"source"];
//        NSLog(@"%@",cropClass.imgURL);
//    }
//    else{
//        cropClass.imgURL = @"";
//    }
//    
//    [self presentViewController:cropClass animated:YES completion:Nil];
//    
    
    
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
