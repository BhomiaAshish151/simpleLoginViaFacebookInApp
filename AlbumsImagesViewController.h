//
//  AlbumsImagesViewController.h
//  SelfieGame
//
//  Created by NOTOITSOLUTIONS on 21/01/14.
//  Copyright (c) 2014 NOTO SOLUTIONS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FbGraph.h"

@interface AlbumsImagesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView *tblFBPics;
    NSMutableArray *albumArray;
	NSString *CellIdentifier;
	FbGraph *fbGraph;
    FbGraphResponse *fb_graph_response,*meProfile,*meAlbum;
    NSString * _albumID;

}

@property (nonatomic, retain) FbGraph *fbGraph;
@property(nonatomic, retain) NSString * _albumID;
@property (nonatomic, retain)NSMutableArray *albumArray;
//-(IBAction)done:(id)sender;
//-(IBAction)close:(id)sender;
- (void)ProcessFBData;
-(IBAction)back:(id)sender;
-(NSString * )albumID ;
- (void)setAlbumID:(NSString *)newValue;

@end
