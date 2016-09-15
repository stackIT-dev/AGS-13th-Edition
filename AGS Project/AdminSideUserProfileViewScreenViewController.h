//
//  AdminSideUserProfileViewScreenViewController.h
//  AGS Project
//
//  Created by venkat on 7/31/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
@interface AdminSideUserProfileViewScreenViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *userDPImage;
@property (strong, nonatomic) IBOutlet UILabel *userDOB;
@property (strong, nonatomic) IBOutlet UITextField *userFullName;
@property (strong, nonatomic) IBOutlet UITextField *userEmail;
@property (strong, nonatomic) IBOutlet UITextField *userPhoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *userAddress;
@property (strong, nonatomic) IBOutlet UILabel *userStatus;
@property (strong, nonatomic) IBOutlet UIButton *userIDCard;
@property (strong, nonatomic) IBOutlet UIButton *userProfileStatusUpdateButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteUserButton;
-(IBAction)statusApprovalAction:(id)sender;

-(IBAction)deleteUserAction:(id)sender;

@end
