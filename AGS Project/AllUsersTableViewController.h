//
//  AllUsersTableViewController.h
//  AGS Project
//
//  Created by venkat on 7/31/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "AppDelegate.h"

@interface AllUsersTableViewController : UITableViewController
@property(nonatomic, retain) NSMutableArray *AllUsersList;

@end
