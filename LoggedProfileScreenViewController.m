//
//  LoggedProfileScreenViewController.m
//  AGS Project
//
//  Created by venkat on 7/14/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "LoggedProfileScreenViewController.h"
#import "LoginPageViewController.h"
//#import "LoginPageViewController.m"

@interface LoggedProfileScreenViewController ()

@end

@implementation LoggedProfileScreenViewController
@synthesize userProfilesDB1, databasePath, loggedAddress, loggedFullName, loggedEmail
, loggedPhone,loggedDOBPicker, loggedProfileStatus, loggedAge;


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


- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    
    {
        sqlite3 *newConnection = [self getNewConnection];
        
        sqlite3_stmt    *statement;
        const char *dbpath = [databasePath UTF8String];
        
        /////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////
        NSString *thisUserEmailID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserEmailIDForWholeApp1"];
        self.loggedEmail.text = [NSString stringWithFormat:@"%@", thisUserEmailID]; //assaigning fullname to display on Screen
        NSLog(@"username retrieved = %@", loggedEmail.text);
        
        NSString *loggedEmail1;
        NSString *thisUserEmailID1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserEmailIDForWholeApp1"];
        self.loggedEmail.text = [NSString stringWithFormat:@"%@", thisUserEmailID1]; //assaigning fullname to display on Screen
        NSLog(@"username retrieved other = %@", loggedEmail1);
        
        /////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////
        
        
        {
            NSString *querySQL = [NSString stringWithFormat: @"SELECT FULLNAME, PHONE, ADDRESS, STATUS, DOB FROM PROFILES12 WHERE EMAIL =\"%@\"", loggedEmail.text];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(newConnection, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSString *nameField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    loggedFullName.text = nameField;
                    NSLog(@"inner nslog with email is: %@", nameField);
                    NSString *phoneField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    loggedPhone.text = phoneField;
                    NSLog(@"inner nslog with phone is: %@", phoneField);
                    
                    NSString *addressField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    if ([addressField isEqual: @"(null)"]) {
                        loggedAddress.text=@"";
                    }
                    else
                    {
                        loggedAddress.text = addressField;
                    }
                    //loggedAddress.text = addressField;
                    NSLog(@"inner nslog with address is: %@", addressField);
                    NSString *statusField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    if ([statusField isEqual:@"1"]) {
                        loggedProfileStatus.text=@"Not Approved";
                    }
                    else if ([statusField isEqual:@"2"])
                    {
                        loggedProfileStatus.text=@"Approved";
                    }
                    else
                    {
                        loggedProfileStatus.text=@"Status Error";
                    }
                    
                    
                    //loggedProfileStatus.text = statusField;
                    NSLog(@"inner nslog with status is: %@", statusField);
                    //NSString *dobField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    //logg.text = statusField;
                    //NSLog(@"inner nslog with status is: %@", statusField);
                    
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
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}



-(IBAction) submitDetails:(id)sender
{
    NSString *textLenght = [NSString stringWithFormat:@"%@", [loggedFullName text]];
    if([textLenght length]>0)
    {
        NSString *textLenght = [NSString stringWithFormat:@"%@", [loggedEmail text]];
        if([textLenght length]>0)
        {
            NSString *textLenght = [NSString stringWithFormat:@"%@", [loggedPhone text]];
            if([textLenght length]==10)
            {
                NSString *textLenght = [NSString stringWithFormat:@"%@", [loggedAddress text]];
                if([textLenght length]>0)
                {
                    NSString *textLenght = [NSString stringWithFormat:@"%@", [loggedAge text]];
                    if([textLenght length]>0)
                    {
                        NSString *textLenght = [NSString stringWithFormat:@"%@", [loggedAge text]];
                        if([textLenght length]>0)
                        {
                        
                        
                            sqlite3_stmt    *statement;
                            sqlite3 *newConnection = [self getNewConnection];
                            
                            const char *dbpath = [databasePath UTF8String];
                            
                            // start of checking into database for verifying wether usename already exists. start of checking into database for verifying wether usename already exists
                            // start of checking into database for verifying wether usename already exists. start of checking into database for verifying wether usename already exists
                            // start of checking into database for verifying wether usename already exists. start of checking into database for verifying wether usename already exists
                           // bool checkingRegisteredUser; //used to check whether user already registrered or not
                            
                            
                            
                            
                            // end of checking into database for verifying wether usename already exists. end of checking into database for verifying wether usename already exists
                            // end of checking into database for verifying wether usename already exists. end of checking into database for verifying wether usename already exists
                            // end of checking into database for verifying wether usename already exists. end of checking into database for verifying wether usename already exists
                            
                            
                                
                                
                                
                            
                            NSString *insertSQL = [NSString stringWithFormat: @"UPDATE PROFILES12 SET FULLNAME = '%@',  WHERE EMAIL = 1" ,
                                                   loggedFullName.text];
                                    
                                    
                                    char *error;
                                    
                                    //if (sqlite3_step(statement) == SQLITE_DONE)
                                    if (sqlite3_exec(newConnection,[insertSQL UTF8String] , NULL, NULL, &error)== SQLITE_OK)
                                        
                                    {
                                        
                                        
                                        //[self presentViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"LoginPage"] animated:YES completion:nil];
                                        
                                    }
                                    
                                    else
                                    {
                                        //status.text = @"Failed to add contact";
                                        NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection));
                                        
                                    }
                                    //sqlite3_finalize(statement);
                                    sqlite3_close(newConnection);
                            
                                
                                
                                
                                
                                
                                
                            
                            
                            
                            
                            
                        
                        
                        }
                        else{
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                                            message:@"Enter DOB"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil];
                            [alert show];
                        }

                    }
                    else{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                                        message:@"Enter Confirm Password"
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                    }
                    
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                                    message:@"Enter Password"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                                message:@"Enter Valid Phone Number"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                            message:@"Enter Valid Email"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                        message:@"Enter FullName First"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
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
