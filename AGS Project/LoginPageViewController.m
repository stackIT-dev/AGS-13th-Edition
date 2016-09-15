//
//  LoginPageViewController.m
//  AGS Project
//
//  Created by venkat on 7/14/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "LoginPageViewController.h"
@interface LoginPageViewController ()

@end

@implementation LoginPageViewController


@synthesize loginPageEmail,loginPagePassword,loginPageLoginButton, databasePath,userProfilesDB1;


- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
    UIColor *color = [UIColor lightTextColor];
    loginPageEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"your email" attributes:@{NSForegroundColorAttributeName: color}];
    loginPagePassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"your password" attributes:@{NSForegroundColorAttributeName: color}];
    
}

-(sqlite3 *)getNewConnection
{
    sqlite3 *newConnection;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"db documents %@",documentsDirectory);
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"T20.db"];
    NSLog(@"db path %@",path);
    if(sqlite3_open([path UTF8String], &newConnection) == SQLITE_OK)
    {
        NSLog(@"database open");
    }
    else
    {
        NSLog(@"datbase error %@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        sqlite3_close(newConnection);
    }
    
    return newConnection;
}


-(IBAction)Login:(id)sender
{
    if(![loginPageEmail.text  isEqual: @"admin"] && ![loginPagePassword.text  isEqual: @"password"])
    {
    NSString *textLenght = [NSString stringWithFormat:@"%@", [loginPageEmail text]];
    if([textLenght length]>0)
    {

        NSString *textLenght = [NSString stringWithFormat:@"%@", [loginPagePassword text]];
        if([textLenght length]>0)
        {

    sqlite3 *newConnection = [self getNewConnection];

    sqlite3_stmt    *statement;
    const char *dbpath = [databasePath UTF8String];
    
    
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT PASSWORD FROM PROFILES12 WHERE EMAIL =\"%@\"",
                              loginPageEmail.text];
        
                
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(newConnection, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                NSString *passwordField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                if ([loginPagePassword.text isEqualToString: passwordField])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:loginPageEmail.text forKey:@"UserEmailIDForWholeApp1"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    loginPageEmail.text=@"";
                    loginPagePassword.text=@"";
                   // [[NSUserDefaults standardUserDefaults]setObject: loginPageEmail.text forKey:@"UserEmailIDForWholeApp"];
                    //[[NSUserDefaults standardUserDefaults] synchronize];
                           //             NSLog(@"username saved = %@", loginPageEmail.text);
                    
                    
                    [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"mainScreen"] animated:YES];
                    
                    //[self presentViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"mainScreen"] animated:YES completion:nil];
                }
                
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                                    message:@"Please Enter Credentials Correctly"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                
                
                
            }
            else
            {
                NSLog(@"inner IF");
                NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection));

            }
         
        }
        else
        {
            NSLog(@"databse opened but could get credenrtials");
            NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection));

        }
        sqlite3_finalize(statement);

        sqlite3_close(newConnection);
    }
            
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                            message:@"Please Enter Your Password"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                        message:@"Please Enter Your Email"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
else
{
    NSLog(@"u r logged as admin");
    loginPageEmail.text=@"";
    loginPagePassword.text=@"";
     [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"AdminMainScreen"] animated:YES];
}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
