//
//  RegisterPageViewController.h
//  AGS Project
//
//  Created by venkat on 7/9/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface RegisterPageViewController : UIViewController


@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *userProfilesDB1;


@property (strong, nonatomic) IBOutlet UITextField *fullName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;
@property (strong, nonatomic) IBOutlet UILabel *status;
//@property (strong, nonatomic) IBOutlet UILabel *Rows;
//@property (strong, nonatomic) IBOutlet UILabel *Columns;
@property (strong, nonatomic) IBOutlet UIButton *RegisterButton,*SearchButton;
@property (strong, nonatomic) IBOutlet UISwitch *emailNotifications;
@property (strong, nonatomic) IBOutlet UISwitch *mobileNotications;

- (IBAction) switchToggledForEmail:(id)sender;
- (IBAction) switchToggledForMobile:(id)sender;

- (IBAction)registerData:(id)sender;
//- (IBAction)findContact:(id)sender;
-(IBAction)createMessageAlert:(id)sender;
 

@end
