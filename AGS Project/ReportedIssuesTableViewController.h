//
//  ReportedIssuesTableViewController.h
//  AGS Project
//
//  Created by venkat on 7/20/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "sqlite3.h"
//#import "LoginPageViewController.h"
@interface ReportedIssuesTableViewController : UITableViewController
//@property (nonatomic, strong) IBOutlet UILabel* loggedEmail;
@property(nonatomic, retain) NSMutableArray *ReportedIssueTitles121;
@end
