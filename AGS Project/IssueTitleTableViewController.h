//
//  IssueTitleTableViewController.h
//  AGS Project
//
//  Created by venkat on 7/11/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "RegisterPageViewController.h"
#import <Foundation/Foundation.h>
//#import "RegisterPageViewController.m"
@interface IssueTitleTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableView *tblPeople;
//@property (nonatomic) sqlite3 *contactDB;
//@property (strong, nonatomic) NSString *databasePath;
//@property (strong, nonatomic) UILabel* RowsLabel;
//- (IBAction)addNewRecord:(id)sender;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *userProfilesDB1;

@end
