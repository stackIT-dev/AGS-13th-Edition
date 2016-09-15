//
//  LoggedProfileScreenViewController.h
//  AGS Project
//
//  Created by venkat on 7/14/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginPageViewController.h"
#import "sqlite3.h"

@interface LoggedProfileScreenViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *loggedFullName;
@property (strong, nonatomic) IBOutlet UILabel *loggedAge;
@property (strong, nonatomic) IBOutlet UIDatePicker *loggedDOBPicker;
@property (strong, nonatomic) IBOutlet UITextField *loggedEmail;
@property (strong, nonatomic) IBOutlet UITextField *loggedPhone;
@property (strong, nonatomic) IBOutlet UITextField *loggedAddress;
@property (strong, nonatomic) IBOutlet UILabel *loggedProfileStatus;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *userProfilesDB1;
-(IBAction) submitDetails:(id)sender;
@end
