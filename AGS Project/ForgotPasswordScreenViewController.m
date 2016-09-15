//
//  ForgotPasswordScreenViewController.m
//  AGS Project
//
//  Created by venkat on 7/30/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "ForgotPasswordScreenViewController.h"

@interface ForgotPasswordScreenViewController ()

@end

@implementation ForgotPasswordScreenViewController
@synthesize toRetriveEmail,toRetriveFullName,toRetrivePhoneNumber,retriveButton, passwordField, labelPasswordNotofication;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [passwordField setHidden:YES];
    [labelPasswordNotofication setHidden:YES];
    UIColor *color = [UIColor lightTextColor];
    toRetriveEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"your email" attributes:@{NSForegroundColorAttributeName: color}];
    toRetrivePhoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"your phone number" attributes:@{NSForegroundColorAttributeName: color}];
    toRetriveFullName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"your full name" attributes:@{NSForegroundColorAttributeName: color}];
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

-(IBAction)retrivePassword:(id)sender
{
    NSString *textLenght = [NSString stringWithFormat:@"%@", [toRetriveEmail text]];
    if([textLenght length]>0)
    {
        NSString *textLenght = [NSString stringWithFormat:@"%@", [toRetriveFullName text]];
        if([textLenght length]>0)
        {
            
            NSString *textLenght = [NSString stringWithFormat:@"%@", [toRetrivePhoneNumber text]];
            if([textLenght length]>0)
            {
                
                sqlite3 *newConnection = [self getNewConnection];
                
                sqlite3_stmt    *statement;
                //const char *dbpath = [databasePath UTF8String];
                
                
                {
                    NSString *querySQL = [NSString stringWithFormat:
                                          @"SELECT FULLNAME, PHONE, PASSWORD FROM PROFILES12 WHERE EMAIL =\"%@\"",
                                          toRetriveEmail.text];
                    
                    
                    const char *query_stmt = [querySQL UTF8String];
                    
                    if (sqlite3_prepare_v2(newConnection, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                    {
                        
                        if (sqlite3_step(statement) == SQLITE_ROW)
                        {
                            
                            NSString *fullName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                            NSString *phoneNumber = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                            NSString *password= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                            
                            NSString *convertedPhoneNumber= toRetrivePhoneNumber.text;
                            
                            NSLog(@"full name: --%@--", fullName);
                            NSLog(@"phone number sqlite: --%@--",phoneNumber);
                            NSLog(@"phone number local: --%@--",toRetrivePhoneNumber.text);
                            NSLog(@"email ID: --%@--", toRetriveEmail.text);
                            NSLog(@"password: --%@--",password);
                            
                            
                            if (toRetriveFullName.text == fullName && convertedPhoneNumber == phoneNumber)
                            {
                                toRetriveEmail.text=@"";
                                toRetriveFullName.text=@"";
                                toRetrivePhoneNumber.text=@"";
                                [passwordField setHidden:NO];
                                [labelPasswordNotofication setHidden:NO];
                                passwordField.text=password;
                                
                                
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
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                                            message:@"Please Account does exists"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil];
                            [alert show];
                            NSLog(@"Error while finding detail or no details found. '%s'", sqlite3_errmsg(newConnection));
                            
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
                                                                message:@"Please enter your phone number"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                            message:@"Please enter fullname"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                     message:@"Please enter valid email ID"
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
