//
//  ViewController.m
//  AGS Project
//
//  Created by venkat on 7/9/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "ViewController.h"
#import "RegisterPageViewController.h"
#import "AppDelegate.h"
#import "LoginPageViewController.h"
@interface ViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation ViewController
@synthesize MessageNotify, Messages, messageNotifyImage,loggedEmail;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton= YES;   // code to hide navigation back button
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *logoutbtn = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStyleDone target:self action:@selector(logoutAction:)];
    self.navigationItem.rightBarButtonItem = logoutbtn;
    
    NSString *thisUserEmailID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserEmailIDForWholeApp1"];
    loggedEmail.text = [NSString stringWithFormat:@"%@", thisUserEmailID]; //assaigning fullname to display on Screen
    NSLog(@"Email retrieved = %@", thisUserEmailID);
    
    
    //self.navigationItem.rightBarButtonItem.title = @"Logout" ;
    
    
    NSInteger numRowsAtPresent;
    NSInteger numRowsInPast ;
    
    
    sqlite3 *newConnection12345;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
   NSString *path = [documentsDirectory stringByAppendingPathComponent:@"T20.db"];
    if(sqlite3_open([path UTF8String], &newConnection12345) == SQLITE_OK)
    {
        NSString *sql = @"select count(*) from MESSAGETABLE";
        sqlite3_stmt *selectStatement;
        int returnValue = sqlite3_prepare_v2(newConnection12345, [sql UTF8String], -1, &selectStatement, NULL);
        if (returnValue == SQLITE_OK)
        {
            if(sqlite3_step(selectStatement) == SQLITE_ROW)
            {
                //int numrows= sqlite3_column_count(selectStatement);
                numRowsAtPresent= sqlite3_column_int(selectStatement, 0);
                //MessageNotify.text = [NSString stringWithFormat:@"%d", numrows];
                MessageNotify.text = [NSString stringWithFormat:@"%ld", (long)numRowsAtPresent];
                NSLog(@"Number of rows at present '%ld'", (long)numRowsAtPresent);
            }
        }
        sqlite3_finalize(selectStatement);
        sqlite3_close(newConnection12345);

    }
    
   //////////////////////////////////////////////
        if(sqlite3_open([path UTF8String], &newConnection12345) == SQLITE_OK)
    {
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM MESSAGENOTIFY WHERE EMAIL = \"%@\"", thisUserEmailID];
        // NSLog(@"Number of rows previous reached 2");
        sqlite3_stmt *selectStatement;
        int returnValue = sqlite3_prepare_v2(newConnection12345, [sql UTF8String], -1, &selectStatement, NULL);
        if (returnValue == SQLITE_OK)
        {
            
            //NSLog(@"Number of rows previous reached 3");
            
            if(sqlite3_step(selectStatement) == SQLITE_DONE)
            {
                
                NSString *Email= (__bridge NSString *)(sqlite3_column_text16(selectStatement, 0));
                numRowsInPast= sqlite3_column_int(selectStatement, 1);

                NSLog(@"Number of rows previous reached %ld", (long)numRowsInPast);
                NSLog(@"Number of rows previous reached %@", Email);
                //int numrows= sqlite3_column_count(selectStatement);
                ////////////////////////////////////numRowsInPast= sqlite3_column_int(selectStatement, 1);
                //NSLog(@"Number of rows previous reached 4");
                //numRowsInPast= sqlite3_last_insert_rowid(1);
                //MessageNotify.text = [NSString stringWithFormat:@"%d", numrows];
                //MessageNotify.text = [NSString stringWithFormat:@"%ld", (long)numRowsInPast];
                //NSLog(@"Number of rows in previous '%ld'", (long)numRowsInPast);
            }
            else
            {
                NSLog(@"reached Else Condition in Message Privious Rows count");
            }
            
        }
        
        sqlite3_finalize(selectStatement);
        sqlite3_close(newConnection12345);
        
    }
    /*
    if (numRowsInPast==0)
    {[NSString stringWithFormat:
      @"INSERT INTO PROFILES12 (FULLNAME, EMAIL, PHONE, PASSWORD) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")", fullName.text, email.text, phoneNumber.text, password.text];
        
        if(sqlite3_open([path UTF8String], &newConnection12345) == SQLITE_OK)
        {
            //int rowID = sqlite3_last_insert_rowid(newConnection12345);
            NSString *sql = @"SELECT * FROM MESSAGENOTIFY WHERE ROWID = rowID";
            // NSLog(@"Number of rows previous reached 2");
            sqlite3_stmt *selectStatement;
            int returnValue = sqlite3_prepare_v2(newConnection12345, [sql UTF8String], -1, &selectStatement, NULL);
            if (returnValue == SQLITE_OK)
            {
                
                //NSLog(@"Number of rows previous reached 3");
                
                if(sqlite3_step(selectStatement) == SQLITE_DONE)
                {
                    
                    numRowsInPast= sqlite3_column_int(selectStatement, 0);
                    NSLog(@"Number of rows previous reached %ld", (long)numRowsInPast);
                    //int numrows= sqlite3_column_count(selectStatement);
                    ////////////////////////////////////numRowsInPast= sqlite3_column_int(selectStatement, 1);
                    //NSLog(@"Number of rows previous reached 4");
                    //numRowsInPast= sqlite3_last_insert_rowid(1);
                    //MessageNotify.text = [NSString stringWithFormat:@"%d", numrows];
                    //MessageNotify.text = [NSString stringWithFormat:@"%ld", (long)numRowsInPast];
                    //NSLog(@"Number of rows in previous '%ld'", (long)numRowsInPast);
                }
                else
                {
                    NSLog(@"Number of rows previous reached 5");
                }
                
            }
            
            sqlite3_finalize(selectStatement);
            sqlite3_close(newConnection12345);
            
        }

        
    }
     */
    long differenceInNotifications = (numRowsAtPresent - numRowsInPast);
    if (differenceInNotifications>0) {
        
    [MessageNotify setHidden:NO];
        [messageNotifyImage setHidden:NO];
    MessageNotify.text= [NSString stringWithFormat:@"%ld", differenceInNotifications];
    }
    else{
        [messageNotifyImage setHidden:YES];
        [MessageNotify setHidden:YES];
        
    }
    
    
       

////////////////////////////////////////////
    
    
    //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(reloadTable) userInfo:nil repeats:YES];//auto reload for 2 secs
    
}
-(void) reloadTable
{
    [self viewDidLoad];
    
    
}
-(IBAction)messagesButton:(id)sender
{
 [MessageNotify setHidden:YES];
    [messageNotifyImage setHidden:YES];
    [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"MessageTableScreen"] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) logoutAction: (id)sender
{
    //self.navigationItem.rightBarButtonItem.title = @"Logout" ;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
