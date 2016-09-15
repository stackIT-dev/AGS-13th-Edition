//
//  AdminSideUserProfileViewScreenViewController.m
//  AGS Project
//
//  Created by venkat on 7/31/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "AdminSideUserProfileViewScreenViewController.h"

@interface AdminSideUserProfileViewScreenViewController ()

@end

@implementation AdminSideUserProfileViewScreenViewController
@synthesize userAddress,userDPImage,userEmail,userDOB,userFullName,userIDCard,userPhoneNumber,userProfileStatusUpdateButton,userStatus,deleteUserButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        sqlite3 *newConnection = [self getNewConnection];
        
        sqlite3_stmt    *statement;
        //const char *dbpath = [databasePath UTF8String];
        
        /////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////
        NSString *thisUserEmailID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AdminSelectedUserEmail"];
        userEmail.text= thisUserEmailID;
        //self.userFullName.text = [NSString stringWithFormat:@"%@", thisUserEmailID]; //assaigning fullname to display on Screen
        //NSLog(@"username full name = %@", userFullName.text);
        
        
        
        /////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////
        
        
        {
            NSString *querySQL = [NSString stringWithFormat: @"SELECT FULLNAME, PHONE, ADDRESS, DOB, STATUS  FROM PROFILES12 WHERE EMAIL =\"%@\"", thisUserEmailID];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(newConnection, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSString *nameField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    userFullName.text = nameField;
                    NSLog(@"inner nslog with name is: %@", nameField);
                    NSString *phoneField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    userPhoneNumber.text = phoneField;
                    NSLog(@"inner nslog with phone is: %@", phoneField);
                    NSString *addressField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    if ([addressField isEqual: @"(null)"]) {
                        userAddress.text=@"";
                    }
                    else
                    {
                        userAddress.text = addressField;
                    }
                    
                    NSLog(@"inner nslog with address is: %@", addressField);
                    NSString *dobField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    
                    if ([dobField isEqual: @"(null)"]) {
                        userDOB.text=@"not entered";
                    }
                    else
                    {
                    userDOB.text = dobField;
                    }
                    NSLog(@"inner nslog with dob is: %@", dobField);
                    
                    NSString *statusField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                    if ([statusField isEqual:@"1"]) {
                        userStatus.text=@"Not Approved";
                       
                    }
                    else if ([statusField isEqual:@"2"])
                    {
                        userStatus.text=@"Approved";
                                            }
                    else
                    {
                        userStatus.text=@"Status Error";
                        
                    }

                    NSLog(@"inner nslog with status is: %@", userStatus.text);
                    //NSString *imageField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                    //userDPImage = imageField;
                   // NSLog(@"inner nslog with phone is: %@", imageField);
                    
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
-(IBAction)statusApprovalAction:(id)sender
{
    int newStatus= 2;
    {
        sqlite3 *newConnection = [self getNewConnection];
        
        sqlite3_stmt    *statement;
       
        NSString *thisUserEmailID1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"AdminSelectedUserEmail"];
        {
            NSString *querySQL = [NSString stringWithFormat: @"UPDATE PROFILES12 SET STATUS= '%d' WHERE EMAIL =\"%@\"", newStatus, thisUserEmailID1];
            
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(newConnection, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSLog(@"Status Successfully Updated");
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successful"
                                                                    message:@"User profile approved"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];

                    
                }
                else
                {
                    NSLog(@"Status Successfully Updated");
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successful"
                                                                    message:@"User profile approved"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                    [self viewDidLoad];
                    [self viewWillAppear:YES];
                    
                    
                    
                    NSLog(@"Status not updated");
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
}
-(IBAction)deleteUserAction:(id)sender
{
    {
        sqlite3 *newConnection = [self getNewConnection];
        
        sqlite3_stmt    *statement;
        //const char *dbpath = [databasePath UTF8String];
        
        /////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////
        NSString *thisUserEmailID1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"AdminSelectedUserEmail"];
        
        //self.userFullName.text = [NSString stringWithFormat:@"%@", thisUserEmailID]; //assaigning fullname to display on Screen
        //NSLog(@"username full name = %@", userFullName.text);
        
        
        
        /////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////
        
        
        {
            NSString *querySQL = [NSString stringWithFormat: @"DELETE FROM PROFILES12 WHERE EMAIL = '%@'", thisUserEmailID1];
            
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(newConnection, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSLog(@"User Profile Succesfully Deleted");
                   [self.navigationController popViewControllerAnimated:YES];
                    
                }
                else
                {
                     [self.navigationController popViewControllerAnimated:YES];
                    NSLog(@"can not delete user");
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
