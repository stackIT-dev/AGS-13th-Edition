//
//  AdminMessagesScreenViewController.m
//  AGS Project
//
//  Created by venkat on 7/28/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "AdminMessagesScreenViewController.h"
#import "AppDelegate.h"
@interface AdminMessagesScreenViewController ()
{
    AppDelegate *appDelegate;
    
}
@end

@implementation AdminMessagesScreenViewController
@synthesize sendMessageButton, messageText;
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1280x1280 - Copy (3) - Copy - Copy.jpg"]];
    
    [self->tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MessageCell"];
    messagesArray = [[NSMutableArray alloc] init];
    
    self->tableView.separatorColor = [UIColor orangeColor]; 
    self->tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background 1920x1920.png"]];
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
   

    // Do any additional setup after loading the view.
}
-(IBAction)createMessageAlert:(id)sender
{
    
    
    
    
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        sqlite3 *newConnection123 = [appDelegate getNewConnection];
        
        
        {
            NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO MESSAGETABLE (MESSAGE) VALUES (\"%@\")", messageText.text];
            
            //NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO MESSAGETABLE (IMAGE) VALUES (\"%@\")", imgData];
            char *error;
            
            //if (sqlite3_step(statement) == SQLITE_DONE)
            if (sqlite3_exec(newConnection123,[insertSQL UTF8String] , NULL, NULL, &error)== SQLITE_OK)
                
            {
                [self->tableView reloadData ];
                NSLog(@"Successfully entered text %@",messageText.text);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successful"
                                                                message:@"Your notification have been sent"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                //[self presentViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"LoginPage"] animated:YES completion:nil];
            
                messageText.text=@"";
                
                
                
                
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    [cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
