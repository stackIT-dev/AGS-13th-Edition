//
//  ReportedIssuesTableViewController.m
//  AGS Project
//
//  Created by venkat on 7/20/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "ReportedIssuesTableViewController.h"
//#import "LoginPageViewController.h"
#import "sqlite3.h"
#import "AppDelegate.h"
@interface ReportedIssuesTableViewController ()
{
  
    NSString *SelectedRowToAllMethods1;

}

@end

@implementation ReportedIssuesTableViewController
@synthesize ReportedIssueTitles121;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.separatorColor = [UIColor orangeColor];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background 1920x1920.png"]];
    
    ReportedIssueTitles121 = [[NSMutableArray alloc] init];

    
    sqlite3 *newConnection121 = [self getNewConnection121];
    
    sqlite3_stmt    *statement1;
    
    //NSString *loggedEmail1;
    NSString *thisUserEmailID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserEmailIDForWholeApp1"];
    //loggedEmail1 = [NSString stringWithFormat:@"%@", thisUserEmailID]; //assaigning fullname to display on Screen
    NSLog(@"username email = %@", thisUserEmailID);
    
    
    
    NSString *querySQL1 = [NSString stringWithFormat:
                          @"SELECT * FROM REPORTEDISSUES WHERE EMAIL =\"%@\"",
                          thisUserEmailID];
    
    
    const char *query_stmt1 = [querySQL1 UTF8String];
    
    if (sqlite3_prepare_v2(newConnection121, query_stmt1, -1, &statement1, NULL) == SQLITE_OK)
    {
        
         //int stepResult = sqlite3_step(statement1);
       // NSLog(@"here we go noe: %d", stepResult);
        while (sqlite3_step(statement1) == SQLITE_ROW)
        {
           
            
           // NSString *email = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
            NSString *issueTitle1 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement1, 2)];
            NSNumber *f1 = [NSNumber numberWithFloat:(float)sqlite3_column_double(statement1, 10)];
            NSString *issueNumber1 = [NSString stringWithFormat:@"%@",f1];

            
            NSDictionary *dict121  = [NSDictionary dictionaryWithObjectsAndKeys:issueTitle1,@"Title121",issueNumber1,@"Number121", nil];
            [ReportedIssueTitles121 addObject:dict121];
        }
        //[self.tableView reloadData];
        //NSLog(@"Error while creating retrive inner sta. '%@'", ReportedIssueTitles);
        NSLog(@"Error while creating retriving statement inside. '%s'", sqlite3_errmsg(newConnection121));

    }
    else
    {
        NSLog(@"databse opened but could get credenrtials");
        NSLog(@"Error while creating retriving statement inside. '%s'", sqlite3_errmsg(newConnection121));
        
    }
    NSLog(@"all your issues %@", ReportedIssueTitles121 );
//NSLog(@"Error while creating retriving statement outside. '%s'", sqlite3_errmsg(newConnection121));
    
    sqlite3_finalize(statement1);
    
    sqlite3_close(newConnection121);
    


}
-(sqlite3 *)getNewConnection121
{
    sqlite3 *newConnection121;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"db documents %@",documentsDirectory);
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"T20.db"];
    NSLog(@"db path %@",path);
    if(sqlite3_open([path UTF8String], &newConnection121) == SQLITE_OK)
    {
        NSLog(@"database open");
    }
    else
    {
        NSLog(@"datbase error %@",[NSString stringWithCString:sqlite3_errmsg(newConnection121) encoding:NSUTF8StringEncoding]);
        sqlite3_close(newConnection121);
    }
    
    return newConnection121;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return ReportedIssueTitles121.count;
}



 
 /*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell121 = [tableView dequeueReusableCellWithIdentifier:@"cell121" forIndexPath:indexPath];
    cell121.textLabel.text =[ReportedIssueTitles objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell121;
}
  */

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cellIdentifier121";
    //Cell reusing..
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        // Cell creation
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    NSDictionary * dict121 = ReportedIssueTitles121[indexPath.row];
    //cell.textLabel.text = dict[@""];
    cell.textLabel.text = dict121[@"Title121"];
    //cell.textLabel.text=[ReportedIssueTitles objectAtIndex:indexPath.row];
    SelectedRowToAllMethods1= cell.textLabel.text;
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
    NSDictionary * dict = ReportedIssueTitles121[indexPath.row];
    //cell.textLabel.text = dict[@""];
    NSString *issueNumberSelectedOne = dict[@"Number121"];
    NSLog(@"selected issue number:%@",issueNumberSelectedOne);
    [[NSUserDefaults standardUserDefaults]setObject: issueNumberSelectedOne forKey:@"UserSelectedIssueNumberFromReportedScreen"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"SelectedIssueReportScreen1"] animated:YES];
    //dont use it as it presenting the screen on old screen , so no navigation control     [self presentViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"SelectedIssueReportScreen1"] animated:YES completion:nil];
    

    
}

@end
