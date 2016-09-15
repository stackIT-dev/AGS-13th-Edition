//
//  AllIssuesTableViewController.m
//  AGS Project
//
//  Created by venkat on 7/28/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "AllIssuesTableViewController.h"
#import "sqlite3.h"
#import "AppDelegate.h"
@interface AllIssuesTableViewController ()
{
    AppDelegate *appDelegate;
    NSString *SelectedRowToAllMethods;
    
}
@end

@implementation AllIssuesTableViewController
@synthesize ReportedIssueTitles1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ReportedIssueTitles1 = [[NSMutableArray alloc] init];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.tableView.separatorColor = [UIColor orangeColor];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background 1920x1920.png"]];
    
    sqlite3 *newConnection = [appDelegate getNewConnection];
    
    sqlite3_stmt    *statement;
    
    NSString *loggedEmail1;
    NSString *thisUserEmailID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserEmailIDForWholeApp1"];
    loggedEmail1 = [NSString stringWithFormat:@"%@", thisUserEmailID]; //assaigning fullname to display on Screen
    NSLog(@"username retrieved = %@", loggedEmail1);
    
    
    
    NSString *querySQL = [NSString stringWithFormat:
                          @"SELECT * FROM REPORTEDISSUES"];
    
    
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_prepare_v2(newConnection, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
           // NSLog(@"whilllllls");
            NSString *issuerEmail = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
            NSString *issueTitle = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
            NSNumber *f = [NSNumber numberWithFloat:(float)sqlite3_column_double(statement, 10)];
            NSString *issueNumber = [NSString stringWithFormat:@"%@",f];
            
            
            NSDictionary *dict  = [NSDictionary dictionaryWithObjectsAndKeys:issueTitle,@"Title",issueNumber,@"Number", nil];
            [ReportedIssueTitles1 addObject:dict];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return ReportedIssueTitles1.count;
}




/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell121 = [tableView dequeueReusableCellWithIdentifier:@"cell121" forIndexPath:indexPath];
 cell121.textLabel.text =[ReportedIssueTitles objectAtIndex:indexPath.row];
 // Co/Users/venkat/Desktop/AGS Project 11/AGS Project/AdminSideUserProfileViewScreenViewController.mnfigure the cell...
 
 return cell121;
 }
 */

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
    NSDictionary * dict = ReportedIssueTitles1[indexPath.row];
    //cell.textLabel.text = dict[@""];
    cell.textLabel.text = dict[@"Title"];
    //cell.textLabel.text=[ReportedIssueTitles objectAtIndex:indexPath.row];
    SelectedRowToAllMethods= cell.textLabel.text;
    //NSLog(@"cell textlabel row dnt know all or only one: %@", SelectedRowToAllMethods);
    return cell;
}



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
    /*
     if (indexPath.row<0) {
     
     NSLog(@"row index:%li",indexPath.row);
     
     //- [self buttonText:self];
     
     }
     else
     {
     //NSDictionary * dict = ReportedIssueTitles[indexPath.row];
     //cell.textLabel.text = dict[@""];
     //SelectedRowToAllMethods = dict[@"issue"];
     //SelectedRowToAllMethods= cell.textLabel.text;
     NSLog(@"row index:%li",indexPath.row);
     [[NSUserDefaults standardUserDefaults]setObject: SelectedRowToAllMethods forKey:@"UserSelectedIssueFromReportedScreen"];
     [[NSUserDefaults standardUserDefaults] synchronize];
     NSLog(@"Issue saved = %@", SelectedRowToAllMethods);
     
     //[self presentViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"Issue Report Screen"] animated:YES completion:nil];
     [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"Selected Issue Report Screen 1"] animated:YES];
     
     // [self.navigationController pushViewController:self animated:YES];
     
     
     }
     */
    NSLog(@"row index:%li",(long)indexPath.row);
    NSDictionary * dict = ReportedIssueTitles1[indexPath.row];
    //cell.textLabel.text = dict[@""];
    NSString *issueNumberSelectedOne = dict[@"Number"];
    NSLog(@"selected issue number:%@",issueNumberSelectedOne);
    [[NSUserDefaults standardUserDefaults]setObject: issueNumberSelectedOne forKey:@"UserSelectedIssueNumberFromReportedScreen"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"AdminIssueShow1"] animated:YES];
    //dont use it as it presenting the screen on old screen , so no navigation control     [self presentViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"SelectedIssueReportScreen1"] animated:YES completion:nil];
    
    
    
}

@end
