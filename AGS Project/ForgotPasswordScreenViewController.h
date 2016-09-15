//
//  ForgotPasswordScreenViewController.h
//  AGS Project
//
//  Created by venkat on 7/30/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface ForgotPasswordScreenViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *retriveButton;
@property (weak, nonatomic) IBOutlet UITextField *toRetrivePhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *toRetriveEmail;
@property (weak, nonatomic) IBOutlet UITextField *toRetriveFullName;



@property (strong, nonatomic) IBOutlet UILabel *labelPasswordNotofication;

@property (weak, nonatomic) IBOutlet UILabel *passwordField;

-(IBAction)retrivePassword:(id)sender;
@end
