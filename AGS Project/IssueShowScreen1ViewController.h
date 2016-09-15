//
//  IssueShowScreen1ViewController.h
//  AGS Project
//
//  Created by venkat on 7/20/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface IssueShowScreen1ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *issueTitleButton;
@property (strong, nonatomic) IBOutlet UILabel *issueDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *IssueImageShow;
//@property (strong, nonatomic) IBOutlet MKMapView *issueLocation;
@property (strong, nonatomic) IBOutlet UILabel *issueTitleLabel;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *userProfilesDB1;
-(IBAction) nextScreen:(id)sender;

@end
