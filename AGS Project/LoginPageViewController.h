//
//  LoginPageViewController.h
//  AGS Project
//
//  Created by venkat on 7/14/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
@interface LoginPageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *loginPageEmail;
@property (strong, nonatomic) IBOutlet UITextField *loginPagePassword;
@property (strong, nonatomic) IBOutlet UIButton *loginPageLoginButton;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *userProfilesDB1;

-(IBAction)Login:(id)sender;
@end
