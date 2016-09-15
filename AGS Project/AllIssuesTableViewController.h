//
//  AllIssuesTableViewController.h
//  AGS Project
//
//  Created by venkat on 7/28/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import "sqlite3.h"
@interface AllIssuesTableViewController : UITableViewController
@property(nonatomic, retain) NSMutableArray *ReportedIssueTitles1;
@end
