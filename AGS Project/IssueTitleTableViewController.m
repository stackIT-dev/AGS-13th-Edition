//
//  IssueTitleTableViewController.m
//  AGS Project
//
//  Created by venkat on 7/11/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "IssueTitleTableViewController.h"
#import "RegisterPageViewController.h"
#import "AppDelegate.h"

@interface IssueTitleTableViewController ()

{
    AppDelegate *appDelegate;
    NSString *SelectedRowToAllMethods;
}
@property (nonatomic , strong) NSMutableArray *issueTitles;
@end

@implementation IssueTitleTableViewController

@synthesize userProfilesDB1, databasePath;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor orangeColor];
    
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background 1920x1920.png"]];
    UIBarButtonItem *addbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addIsuue:)];
    self.navigationItem.rightBarButtonItem = addbtn;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _issueTitles = [[NSMutableArray alloc] init];
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    /*_issueTitles = [NSMutableArray arrayWithArray:@[@"Police Problems", @"Land Issues",@"Road Issues", @"Water Issues",@"Safety Issues", @"Robbery Issues",@"Public Servant Issue", @"Bribe Issues",@"Transportation Issues", @"Pollution Issues",@"Trash Dump Issues", @"Local Shops Rate Issues",@"Low Quality Product Issues", @"Political Issues",@"Medical Issues", @"Doctor Issues", @"Ambulence Issues", @"Child Labour", @"Educational Issues", @"Environmental Issues",@"Other Issues"]];*/
  
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    sqlite3 *newConnection = [appDelegate getNewConnection];
    
    sqlite3_stmt    *statement;
    NSString *thisUserEmailID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserEmailIDForWholeApp"];

    
    
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT * FROM ISSUES WHERE EMAIL =\"%@\"",
                              thisUserEmailID];
        
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(newConnection, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                NSString *email = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *issue = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *subIssue = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSDictionary *dict  = [NSDictionary dictionaryWithObjectsAndKeys:email,@"Email",issue,@"issue",subIssue,@"subIssue", nil];

                [_issueTitles addObject:dict];
            }
            
                NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection));
        }
        else
        {
            NSLog(@"databse opened but could get credenrtials");
            NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection));
            
        }
        sqlite3_finalize(statement);
        
        sqlite3_close(newConnection);
    
/*
 (
 
 
     {
        issuename:issue,
        issueSubtitle:subtitle
      },
 
 {
 issuename:issue,
 issueSubtitle:subtitle
 },
 {
 issuename:issue,
 issueSubtitle:subtitle
 }
 
 
 )
 */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addIsuue: (id) sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"AGS" message:@"Enter Issue name" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter Issue name";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter sub issue";

    }];

    UIAlertAction *okACtion =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *thisUserEmailID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserEmailIDForWholeApp"];

        UITextField *tf = alert.textFields[0];
        UITextField *tf1 = alert.textFields[1];

        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        sqlite3 *newConnection = [appDelegate getNewConnection];
        
        
        {
            NSString *thisUserEmailID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserEmailIDForWholeApp1"];
   
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO ISSUES (EMAIL, ISSUETITLE, ISSUESUBTITLE) VALUES (\"%@\", \"%@\", \"%@\")", thisUserEmailID, tf.text, tf1.text];
            
            
            char *error;
            
            //if (sqlite3_step(statement) == SQLITE_DONE)
            if (sqlite3_exec(newConnection,[insertSQL UTF8String] , NULL, NULL, &error)== SQLITE_OK)
                
            {
                //[self presentViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"LoginPage"] animated:YES completion:nil];
                //NSLog(@"insert ");
                NSDictionary *dict  = [NSDictionary dictionaryWithObjectsAndKeys:thisUserEmailID,@"Email",tf.text,@"issue",tf1.text,@"subIssue", nil];
                [_issueTitles addObject:dict];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData ];
                });
            }
            
            else
            {
                //status.text = @"Failed to add contact";
                NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection));
                
            }
            //sqlite3_finalize(statement);
            sqlite3_close(newConnection);
        }
        
        NSLog(@"Entered text %@",tf.text);
    }];
    
    [alert addAction:okACtion];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}
/*
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
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _issueTitles.count;


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IssueCell" forIndexPath:indexPath];
    //////background code
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    ///////
    
    NSDictionary * dict = _issueTitles[indexPath.row];
    //cell.textLabel.text = dict[@""];
   cell.textLabel.text = dict[@"issue"];
    SelectedRowToAllMethods= cell.textLabel.text;
    
    
    // Configure the cell...
    
    return cell;
}


/*
 // Gives us EDIT in Navigation controller. Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return NO;

 }
 */
/*
 
 
 // It gives us Edit option in navigation control and to delete rows which we select.Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [_issueTitles removeObjectAtIndex:indexPath.row];
 
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row<0) {
        
        NSLog(@"row index:%li",(long)indexPath.row);
        
        //- [self buttonText:self];
        
    }
    else
    {
        NSDictionary * dict = _issueTitles[indexPath.row];
        //cell.textLabel.text = dict[@""];
        SelectedRowToAllMethods = dict[@"issue"];
        //SelectedRowToAllMethods= cell.textLabel.text;
        //NSLog(@"row index:%li",indexPath.row);
        [[NSUserDefaults standardUserDefaults]setObject: SelectedRowToAllMethods forKey:@"UserSelectedIssue"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"Issue saved = %@", SelectedRowToAllMethods);
        
        //[self presentViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"Issue Report Screen"] animated:YES completion:nil];
        [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"Issue Report Screen 2"] animated:YES];
        
        // [self.navigationController pushViewController:self animated:YES];
        
        
    }
    
}




@end
