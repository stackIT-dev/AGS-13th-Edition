//
//  MessageTableViewController.m
//  AGS Project
//
//  Created by venkat on 7/18/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "MessageTableViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"

@interface MessageTableViewController ()
{
    AppDelegate *appDelegate;
   
}


@end

@implementation MessageTableViewController
@synthesize messagesArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //NSString *name = [[NSString alloc] init];
    self.tableView.separatorColor = [UIColor orangeColor];
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background 1920x1920.png"]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MessageCell"];
    messagesArray = [[NSMutableArray alloc] init];

    
    //    NSString *name = [NSString stringWithFormat:@"starName"];
    ////////////////////////////////////////////////////////////////////
    /*sqlite3 *newConnection;
    
    //NSString *databasename=@"MathsTricks.sqlite";  // Your database Name.
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES);
    
    NSString * documentsDirectory=[paths objectAtIndex:0];
    
    NSString * path=[documentsDirectory stringByAppendingPathComponent:@"T20.db"];
    
    if(sqlite3_open([path UTF8String], &newConnection) == SQLITE_OK)
    {
        const char *sqlStatement = "SELECT * FROM MESSAGETABLE";  // Your Tablename
        
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(newConnection, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            NSLog(@"entered if statement");
            //[messagesArray removeAllObjects];
            
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
     
               // NSLog(@"entered while statement");
               // [messagesArray addObject:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(compiledStatement,0)]];
               // NSLog (@"Your Array elements are = %@", messagesArray);
     
                
                NSString *message = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(compiledStatement, 1)];
                NSString *previouscount = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(compiledStatement, 2)];
                NSDictionary *dict  = [NSDictionary dictionaryWithObjectsAndKeys:message,@"Message",previouscount,@"Previouscount", nil];
                
                [messagesArray addObject:dict];
                
                
                
            }
            NSLog(@"count = %lu", (unsigned long)[messagesArray count]);
            [self previousCount];
        }
        else
        {
            NSLog(@"entered else statement");
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(newConnection);
*/
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    sqlite3 *newConnection = [appDelegate getNewConnection];
    
    sqlite3_stmt    *statement;
    
    NSString *querySQL = [NSString stringWithFormat:
                          @"SELECT * FROM MESSAGETABLE"];
    
    
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_prepare_v2(newConnection, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            
            NSString *message = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
            //NSString *previouscount = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
            
            NSDictionary *dict1  = [NSDictionary dictionaryWithObjectsAndKeys:message,@"Message", nil];
            
            [messagesArray addObject:dict1];
        }
        //[self.tableView reloadData];
        
        
    }
    else
    {
        NSLog(@"databse opened but could get credenrtials");
        NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection));
        
    }
    sqlite3_finalize(statement);
    
    sqlite3_close(newConnection);


    //NSLog(@"count = %lu", (unsigned long)[messagesArray count]);
    [self previousCount];
    }

-(void) previousCount
{
    
    
    
    
            
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            sqlite3 *newConnection123 = [appDelegate getNewConnection];
            
            
            {
                //NSString *thisUserEmailID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserEmailIDForWholeApp1"];
                
                NSString *insertSQL = [NSString stringWithFormat:@"UPDATE MESSAGENOTIFY SET PREVOUISCOUNT='%lu\' WHERE ", (unsigned long)messagesArray.count];
                
                
               
                char *error;
                
                
                if (sqlite3_exec(newConnection123,[insertSQL UTF8String] , NULL, NULL, &error)== SQLITE_OK)
                    
                {
                    NSLog(@"Successfully entered PREVOUISCOUNT %lu",(unsigned long)messagesArray.count);
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
            
            
    
        
        
        
        
    
}

/*
-(void)getdataMT
{
   
    sqlite3 *newConnection;
    
    //NSString *databasename=@"MathsTricks.sqlite";  // Your database Name.
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES);
    
    NSString * documentsDirectory=[paths objectAtIndex:0];
    
    NSString * path=[documentsDirectory stringByAppendingPathComponent:@"T20.db"];
    
    if(sqlite3_open([path UTF8String], &newConnection) == SQLITE_OK)
    {
        const char *sqlStatement = "SELECT MESSAGE FROM MESSAGETABLE";  // Your Tablename
        
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(newConnection, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            [messagesArray removeAllObjects];
            
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
               [messagesArray addObject:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(compiledStatement, 1)]];
            }
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(newConnection);
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//#warning Incomplete implementation, return the number of rows
    return messagesArray.count;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text =[messagesArray objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}
 */


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
   // static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    NSDictionary * dict1 = messagesArray[indexPath.row];
    //cell.textLabel.text = dict[@""];
    cell.textLabel.text = dict1[@"Message"];
    /*
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[messagesArray objectAtIndex:indexPath.row]];
     */
    
    return cell;
    
 
    
    
    
    
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
