//
//  ViewController.h
//  AGS Project
//
//  Created by venkat on 7/9/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "AppDelegate.h"
#import "RegisterPageViewController.h"
#import "LoginPageViewController.h"
@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *MessageNotify;
@property (strong, nonatomic) IBOutlet UIButton *Messages;
@property (strong, nonatomic) IBOutlet UIImageView *messageNotifyImage;
@property (nonatomic, strong) IBOutlet UILabel* loggedEmail;

-(IBAction) messagesButton:(id)sender;


@end

