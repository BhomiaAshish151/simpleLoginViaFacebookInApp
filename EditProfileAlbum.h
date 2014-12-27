//
//  EditProfileAlbum.h
//  SelfieGame
//
//  Created by NOTOITSOLUTIONS on 10/12/13.
//  Copyright (c) 2013 NOTO SOLUTIONS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FbGraph.h"

//@class TSActivityIndicatorView;
@interface EditProfileAlbum : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *newsFeedTable;
    IBOutlet UILabel *ShowLbl;
    IBOutlet UIButton *cancelBtn;
    NSMutableArray *albumArray;
	NSString *CellIdentifier;
	FbGraph *fbGraph;
    FbGraphResponse *fb_graph_response,*meProfile,*meAlbum;
	NSMutableArray *images,*imagesName,*friendsPictureCount,*FriendsNameArr,*friendsImageUrl,*FriendsIdArr;
    
}
@property (nonatomic, retain) FbGraph *fbGraph;
//@property (strong, nonatomic) IBOutlet TSActivityIndicatorView *indicator;
@property (nonatomic, retain)NSMutableArray *albumArray,*albumCoverPics,*albumLinks,*albumId;
-(IBAction)done:(id)sender;
-(IBAction)close:(id)sender;
- (void)ProcessFBData;
@end
