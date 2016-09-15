//
//  AllUsersTableViewController.m
//  AGS Project
//
//  Created by venkat on 7/31/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "AllUsersTableViewController.h"
#import "sqlite3.h"
#import "AppDelegate.h"

@interface AllUsersTableViewController ()
{
    AppDelegate *appDelegate;
  
    
}


@end

@implementation AllUsersTableViewController
@synthesize AllUsersList;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor orangeColor];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background 1920x1920.png"]];
    
    AllUsersList = [[NSMutableArray alloc] init];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    sqlite3 *newConnection = [appDelegate getNewConnection];
    
    sqlite3_stmt    *statement;
    
    
    
    
    
    NSString *querySQL = [NSString stringWithFormat:
                          @"SELECT * FROM PROFILES12"];
    
    
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_prepare_v2(newConnection, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            // NSLog(@"whilllllls");
           NSString *userName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
            NSString *userEmail = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
            
            //NSNumber *f = [NSNumber numberWithFloat:(float)sqlite3_column_double(statement, 10)];
            //NSString *issueNumber = [NSString stringWithFormat:@"%@",f];
            
            
            NSDictionary *dict  = [NSDictionary dictionaryWithObjectsAndKeys:userName,@"userName",userEmail,@"userEmail", nil];
            [AllUsersList addObject:dict];
        }
        //[self.tableView reloadData];
        //NSLog(@"Error while creating retrive inner sta. '%@'", ReportedIssueTitles);
    }
    else
    {
        NSLog(@"databse opened but could get credenrtials");
        NSLog(@"Error while creating retriving statement. '%s'", sqlite3_errmsg(newConnection));
        
    }
    
    
    sqlite3_finalize(statement);
    
    sqlite3_close(newConnection);
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated
{
   
    [self.tableView reloadData ];
}



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
    return AllUsersList.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cellIdentifier";
    //Cell reusing..
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        // Cell creation
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    NSDictionary * dict = AllUsersList[indexPath.row];
    //cell.textLabel.text = dict[@""];
    cell.textLabel.text = dict[@"userName"];
    //cell.textLabel.text=[ReportedIssueTitles objectAtIndex:indexPath.row];
        //NSLog(@"cell textlabel row dnt know all or only one: %@", SelectedRowToAllMethods);
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"row index:%li",(long)indexPath.row);
    NSDictionary * dict = AllUsersList[indexPath.row];
    //cell.textLabel.text = dict[@""];
    NSString *adminSelectedUserEmail = dict[@"userEmail"];
    
    [[NSUserDefaults standardUserDefaults]setObject: adminSelectedUserEmail forKey:@"AdminSelectedUserEmail"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"AdminSideUserProfileScreen"] animated:YES];
    
    
}


@end
