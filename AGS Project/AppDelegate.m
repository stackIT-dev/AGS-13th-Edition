//
//  AppDelegate.m
//  AGS Project
//
//  Created by venkat on 7/9/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    sqlite3 *newConnection = [self getNewConnection];
    char *errMsg;
    NSString *sql_stmt = @"CREATE TABLE PROFILES12 (ID INTEGER PRIMARY KEY AUTOINCREMENT, FULLNAME TEXT, EMAIL TEXT, PHONE INT, PASSWORD TEXT, EMAILNOTIFICATIONID INT, PHONENOTIFICATIONID INT, STATUS INT, ADDRESS TEXT, DOB TEXT, DP BLOB, IDCARD BLOB)";
    
    
    if (sqlite3_exec(newConnection, [sql_stmt UTF8String], NULL, NULL, &errMsg) != SQLITE_OK)
    {
        //status.text = @"Failed to create table";
        NSLog(@"%@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        if([[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding] rangeOfString:@"already exists"].location != NSNotFound ){
            
            NSLog(@"error msg %@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        }
        
    }
    else
    {
        NSLog(@" user profiles Table Created");
        
    }
    sqlite3_close(newConnection);
    

    
    ////////////////////////////////
   newConnection = [self getNewConnection];
    //char *errMsg1;
    sql_stmt = @"CREATE TABLE ISSUES (ID INTEGER PRIMARY KEY AUTOINCREMENT, EMAIL TEXT, ISSUETITLE TEXT, ISSUESUBTITLE TEXT)";
    
    
    if (sqlite3_exec(newConnection, [sql_stmt UTF8String], NULL, NULL, &errMsg) != SQLITE_OK)
    {
        //status.text = @"Failed to create table";
        NSLog(@"%@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        if([[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding] rangeOfString:@"already exists"].location != NSNotFound ){
            
            NSLog(@"error msg %@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        }
        
    }
    else
    {
        NSLog(@" Listof issues Table Created");
        
    }
    sqlite3_close(newConnection);
    

    ///////////////////////////////
    
    
    newConnection = [self getNewConnection];
    //char *errMsg1;
    sql_stmt = @"CREATE TABLE MESSAGETABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, MESSAGE TEXT, PREVOUISCOUNT TEXT)";
    
    //sql_stmt = @"CREATE TABLE MESSAGETABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, IMAGE BLOB)";
    

    if (sqlite3_exec(newConnection, [sql_stmt UTF8String], NULL, NULL, &errMsg) != SQLITE_OK)
    {
        //status.text = @"Failed to create table";
        NSLog(@"%@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        if([[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding] rangeOfString:@"already exists"].location != NSNotFound ){
            
            NSLog(@"error msg %@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        }
        
    }
    else
    {
        NSLog(@" Message Table Created");
        
    }
    sqlite3_close(newConnection);
   ///////////////////////////////////////////////

    
    ///////////////////////////////
    
    
    newConnection = [self getNewConnection];
    //char *errMsg1;
    sql_stmt = @"CREATE TABLE MESSAGENOTIFY (ID INTEGER PRIMARY KEY AUTOINCREMENT, PREVOUISCOUNT LONG, EMAIL TEXT)";
    
    //sql_stmt = @"CREATE TABLE MESSAGETABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, IMAGE BLOB)";
    
    
    if (sqlite3_exec(newConnection, [sql_stmt UTF8String], NULL, NULL, &errMsg) != SQLITE_OK)
    {
        //status.text = @"Failed to create table";
        NSLog(@"%@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        if([[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding] rangeOfString:@"already exists"].location != NSNotFound ){
            
            NSLog(@"error msg %@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        }
        
    }
    else
    {
        NSLog(@" MessageNotify Table Created");
        
    }
    sqlite3_close(newConnection);
    ///////////////////////////////////////////////
    
    
    
    
    
    
    newConnection = [self getNewConnection];
    //char *errMsg1;
    sql_stmt = @"CREATE TABLE REPORTEDISSUES (ID INTEGER PRIMARY KEY AUTOINCREMENT, EMAIL TEXT, ISSUETITLE TEXT, ISSUEDESCRIPTION TEXT,  LOCATIONLONGITUDE TEXT, LOCATIONLATITUDE TEXT, DATE TEXT, TIME TEXT, STATUS LONG, IMAGEPATH TEXT, ISSUENUMBER LONG, IMAGE BLOB, ISSUECOMMENT TXT)";
    
    //sql_stmt = @"CREATE TABLE MESSAGETABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, IMAGE BLOB)";
    
    
    if (sqlite3_exec(newConnection, [sql_stmt UTF8String], NULL, NULL, &errMsg) != SQLITE_OK)
    {
        //status.text = @"Failed to create table";
        NSLog(@"%@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        
        if([[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding] rangeOfString:@"already exists"].location != NSNotFound )
        {
            
            NSLog(@"error msg %@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        }
        
    }
    else
    {
        NSLog(@" ReportIssues Table Created");
        
    }
    sqlite3_close(newConnection);
////////////////////////////////////////////////
    ///////////////////////////////////////////////
    
    
    
    
    
    
    newConnection = [self getNewConnection];
    //char *errMsg1;
    sql_stmt = @"CREATE TABLE ALLISSUESCOUNT (ID INTEGER PRIMARY KEY AUTOINCREMENT, COUNT LONG)";
    
    //sql_stmt = @"CREATE TABLE MESSAGETABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, IMAGE BLOB)";
    
    
    if (sqlite3_exec(newConnection, [sql_stmt UTF8String], NULL, NULL, &errMsg) != SQLITE_OK)
    {
        //status.text = @"Failed to create table";
        NSLog(@"%@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        
        if([[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding] rangeOfString:@"already exists"].location != NSNotFound )
        {
            
            NSLog(@"error msg %@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        }
        
    }
    else
    {
        NSLog(@" No.Of Issues Table Table Created");
        
    }
    sqlite3_close(newConnection);
    ////////////////////////////////////////////////
    
    
    return YES;
}

-(sqlite3 *)getNewConnection
{
    sqlite3 *newConnection;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"db documents %@",documentsDirectory);
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"T20.db"];
    //NSLog(@"db path %@",path);
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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
