//
//  RegisterPageViewController.m
//  AGS Project
//
//  Created by venkat on 7/9/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "RegisterPageViewController.h"
#import "AppDelegate.h"
@interface RegisterPageViewController ()

@end

@implementation RegisterPageViewController


@synthesize databasePath,userProfilesDB1,fullName,email,phoneNumber,password, confirmPassword ,status,RegisterButton,SearchButton, emailNotifications,mobileNotications;//, Rows, Columns;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIColor *color = [UIColor lightTextColor];
    fullName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"full name" attributes:@{NSForegroundColorAttributeName: color}];
    email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"email" attributes:@{NSForegroundColorAttributeName: color}];
    phoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"phone number" attributes:@{NSForegroundColorAttributeName: color}];
    password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"password" attributes:@{NSForegroundColorAttributeName: color}];
    confirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"confirm password" attributes:@{NSForegroundColorAttributeName: color}];
    
    //////////////////////////////finding no of rows and columns//////////////////////////
   /*
    sqlite3 *database;
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        NSString *sql = @"select count(*) from PROFILES12";
        sqlite3_stmt *selectStatement;
        int returnValue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectStatement, NULL);
        if (returnValue == SQLITE_OK)
        {
            if(sqlite3_step(selectStatement) == SQLITE_ROW)
            {
                int numrows= sqlite3_column_count(selectStatement);
                int numcolumns= sqlite3_column_int(selectStatement, 0);
                Rows.text = [NSString stringWithFormat:@"%d", numrows];
                Columns.text = [NSString stringWithFormat:@"%d", numcolumns];
            }
        }
        sqlite3_finalize(selectStatement);
        sqlite3_close(database);
    }
    */
    //////////////////////////////finding no of rows and columns//////////////////////////
    
    // Do any additional setup after loading the view.
    //////
    

    /////
    
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


- (IBAction)registerData:(id)sender
{
    NSString *textLenght1 = [NSString stringWithFormat:@"%@", [fullName text]];
    if([textLenght1 length]>0 && [textLenght1 length]<20)
    {
        NSString *textLenght2 = [NSString stringWithFormat:@"%@", [email text]];
        if([textLenght2 length]>0 && [textLenght2 length]<25)
        {
            NSString *textLenght3 = [NSString stringWithFormat:@"%@", [phoneNumber text]];
            if([textLenght3 length]==10)
            {
                NSString *textLenght4 = [NSString stringWithFormat:@"%@", [password text]];
                if([textLenght4 length]>0)
                {
                    NSString *textLenght5 = [NSString stringWithFormat:@"%@", [confirmPassword text]];
                    if([textLenght5 length]>0)
                    {
                        if ([password.text isEqualToString: confirmPassword.text])
                        {
    //sqlite3_stmt    *statement;
    sqlite3 *newConnection = [self getNewConnection];

   // const char *dbpath = [databasePath UTF8String];
    
    // start of checking into database for verifying wether usename already exists. start of checking into database for verifying wether usename already exists
    // start of checking into database for verifying wether usename already exists. start of checking into database for verifying wether usename already exists
    // start of checking into database for verifying wether usename already exists. start of checking into database for verifying wether usename already exists
    bool checkingRegisteredUser; //used to check whether user already registrered or not
    
    {
        sqlite3 *newConnection = [self getNewConnection];
        
        sqlite3_stmt    *statement;
        //const char *dbpath = [databasePath UTF8String];
        
        
        {
            NSString *querySQL = [NSString stringWithFormat:
                                  @"SELECT email FROM PROFILES12 WHERE EMAIL =\"%@\"",
                                  email.text];
            
            
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(newConnection, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSString *emailField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    if (email.text == emailField)
                    {
                        checkingRegisteredUser = true;
                        
                    }
                    else
                    {
                        checkingRegisteredUser = false;
                    }
                    
                    
                    
                }
                
                
            }
            else
            {
                NSLog(@"databse opened but could get credenrtials");
               // NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection));
                
            }
            sqlite3_finalize(statement);
            
            sqlite3_close(newConnection);
        }
        
    }
    
    
    // end of checking into database for verifying wether usename already exists. end of checking into database for verifying wether usename already exists
    // end of checking into database for verifying wether usename already exists. end of checking into database for verifying wether usename already exists
    // end of checking into database for verifying wether usename already exists. end of checking into database for verifying wether usename already exists
    
    if (checkingRegisteredUser == false)
    {
    
        
        
                
                {
                    int userStatus= 1;
                    NSString *address= Nil;
                    NSString *dob= Nil;
                    NSString *insertSQL = [NSString stringWithFormat:
                                           @"INSERT INTO PROFILES12 (FULLNAME, EMAIL, PHONE, PASSWORD, STATUS, ADDRESS, DOB) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\")", fullName.text, email.text, phoneNumber.text, password.text, userStatus, address, dob];
                    
                    
                    char *error;
                    
                    //if (sqlite3_step(statement) == SQLITE_DONE)
                    if (sqlite3_exec(newConnection,[insertSQL UTF8String] , NULL, NULL, &error)== SQLITE_OK)
                        
                    {
                        //status.text = @"Contact added";
                        fullName.text = @"";
                        email.text = @"";
                        phoneNumber.text = @"";
                        password.text=@"";
                        confirmPassword.text=@"";
                        NSLog(@"registered the user");
                        
                        [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"Login Page"] animated:YES];
                        
                    
                       // [self presentViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"LoginPage"] animated:YES completion:nil];
                        
                    }
                    
                    else
                    {
                        status.text = @"Failed to add contact";
                        NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection));
                        
                    }
                    //sqlite3_finalize(statement);
                    sqlite3_close(newConnection);
                }
                
        
            
        
        

    
}
    else
    {
        fullName.text = @"";
        email.text = @"";
        phoneNumber.text = @"";
        password.text=@"";
        confirmPassword.text=@"";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                        message:@"User Already Exists, Please Login Now"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
            
            
        
                        }
                        else
                        {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                                            message:@"Please Confirm Password Correctly"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil];
                            [alert show];
                        }
                    
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                                    message:@"Enter Confirm Password Valid"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
   
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                                    message:@"Enter Password Valid"
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
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                        message:@"Enter Valid FullName"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

-(IBAction)createMessageAlert:(id)sender

{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message Center" message:@"Enter Message To People" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"Enter Message to People";
        }];
    
        
        UIAlertAction *okACtion =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UITextField *messageText = alert.textFields[0];
            
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            sqlite3 *newConnection123 = [appDelegate getNewConnection];
            
            
            {
                NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO MESSAGETABLE (MESSAGE) VALUES (\"%@\")", messageText.text];
                
                //NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO MESSAGETABLE (IMAGE) VALUES (\"%@\")", imgData];
                char *error;
                
                //if (sqlite3_step(statement) == SQLITE_DONE)
                if (sqlite3_exec(newConnection123,[insertSQL UTF8String] , NULL, NULL, &error)== SQLITE_OK)
                    
                {
                    NSLog(@"Successfully entered text %@",messageText.text);
                    //[self presentViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"LoginPage"] animated:YES completion:nil];
                    
                }
                
                else
                {
                    //status.text = @"Failed to add contact";
                    NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection123));
                    
                }
                //sqlite3_finalize(statement);
                sqlite3_close(newConnection123);
            }
            
            
        }];
        
        [alert addAction:okACtion];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
    
}
/*
-(IBAction)AddMessage:(id)sender
{
                        NSString *textLenght6 = [NSString stringWithFormat:@"%@", [confirmPassword text]];
                    if([textLenght6 length]>5)
                    {
                        if (password.text == confirmPassword.text)
                        {
                            sqlite3_stmt    *statement;
                            sqlite3 *newConnection1 = [self getNewConnection];
                            
                            const char *dbpath = [databasePath UTF8String];
                            
                            // start of checking into database for verifying wether usename already exists. start of checking into database for verifying wether usename already exists
                            // start of checking into database for verifying wether usename already exists. start of checking into database for verifying wether usename already exists
                            // start of checking into database for verifying wether usename already exists. start of checking into database for verifying wether usename already exists
                            
                                                                
                                
                                
                            
                            
                            
                            // end of checking into database for verifying wether usename already exists. end of checking into database for verifying wether usename already exists
                            // end of checking into database for verifying wether usename already exists. end of checking into database for verifying wether usename already exists
                            // end of checking into database for verifying wether usename already exists. end of checking into database for verifying wether usename already exists
                            
                            
                                
                                
                                
                                {
                                    NSString *insertSQL = [NSString stringWithFormat:
                                                           @"INSERT INTO MESSAGETABLE (MESSAGEID, MESSAGE, TIME, DATE, LASTSEENNUMBER) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", messageID.text, message.text, timetext, date.text, lastSeenNumber.text];
                                    
                                    
                                    char *error;
                                    
                                    //if (sqlite3_step(statement) == SQLITE_DONE)
                                    if (sqlite3_exec(newConnection1,[insertSQL UTF8String] , NULL, NULL, &error)== SQLITE_OK)
                                        
                                    {
                                        status.text = @"Message added";
                                        
                                        
                                        //[self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"Login Page"] animated:YES];
                                        
                                        // [self presentViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"LoginPage"] animated:YES completion:nil];
                                        
                                    }
                                    
                                    else
                                    {
                                        status.text = @"Failed to add Message";
                                        //NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection));
                                        
                                    }
                                    sqlite3_finalize(statement);
                                    sqlite3_close(newConnection1);
                                }
                                
                                
                                
                                
                                
                                
                                
                            
                            
                            
                        }
                        else
                        {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                                            message:@"Please Confirm Password Correctly"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil];
                            [alert show];
                        }
                        
                    }
                    else{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                                        message:@"Enter Confirm Password Valid"
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                    }
                    
    

}
*/

- (void) switchToggledForEmail:(id)sender {
    UISwitch *emailNotificationSwitch = (UISwitch *)sender;
    if ([emailNotificationSwitch isOn]) {
        NSLog(@"its on for Email!");
    } else {
        NSLog(@"its off! for Email");
    }
}

- (void) switchToggledForMobile:(id)sender {
    UISwitch *mobileNotificationSwitch = (UISwitch *)sender;
    if ([mobileNotificationSwitch isOn]) {
        NSLog(@"its on! for mobile");
    } else {
        NSLog(@"its off! for mobile");
    }
}
/*
- (IBAction)findContact:(id)sender;
{
    sqlite3_stmt    *statement;
    const char *dbpath = [databasePath UTF8String];
    
    
    if (sqlite3_open(dbpath, &userProfilesDB1) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT email, phone, password FROM PROFILES12 WHERE fullname=\"%@\"",
                              fullName.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(userProfilesDB1, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *emailField = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0)];
                email.text = emailField;
                
                NSString *phoneField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                phoneNumber.text = phoneField;

               NSString *passwordField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                password.text = passwordField;

                
                status.text = @"Match found";
            }
            else
            {
                status.text = @"Match not found";
                email.text = @"";
                phoneNumber.text = @"";
                password.text=@"";
            }
            sqlite3_finalize(statement);
        }
        else
        {
            status.text = @"second if statement";
        }
        sqlite3_close(userProfilesDB1);
    }
    else
    {
        status.text = @"could not open db";
    }
    
    
}
*/





- (void)didReceiveMemoryWarning
{
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
