//
//  AdminIssueShowScreen2ViewController.m
//  AGS Project
//
//  Created by Venkat on 9/9/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "AdminIssueShowScreen2ViewController.h"

@interface AdminIssueShowScreen2ViewController ()

@end

@implementation AdminIssueShowScreen2ViewController

@synthesize issueNumber,issueTitle,issueDescription, issueStatus, isserName, isserDate,issueImage,IssueComment;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserSelectedIssueImage"];
    
    [issueImage setImage:[UIImage imageWithData:imageData]];
    // Do any additional setup after loading the view.
    NSString *selectedIssueNumber;
    NSString *thisUserEmailID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserSelectedIssueNumberFromReportedScreen"];
    selectedIssueNumber = [NSString stringWithFormat:@"%@", thisUserEmailID];
    issueNumber.text=selectedIssueNumber;
    //NSLog(@"username retrieved = %@", selectedIssueNumber);
    //NSString *selectedIssueTitle;
    NSString *selectedIssueTitle = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserSelectedIssueTitle"];
    issueTitle.text = [NSString stringWithFormat:@"%@", selectedIssueTitle];
    //NSString *selectedIssueDescription;
    NSString *selectedIssueDescription = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserSelectedIssueDescription"];
    issueDescription.text = [NSString stringWithFormat:@"%@", selectedIssueDescription];
    NSString *selectedIssueStatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserSelectedIssueStatus"];
    int status =[selectedIssueStatus intValue];//[NSString stringWithFormat:@"%@", selectedIssueStatus];
    NSString *selectedIssueDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserSelectedIssueDateAndTime"];
    isserDate.text = [NSString stringWithFormat:@"%@", selectedIssueDate];
    
    NSString *selectedIssueComment = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserSelectedIssueComment"];
    IssueComment.text = [NSString stringWithFormat:@"%@", selectedIssueComment];
    
    
    if(status == 1 )
    {
        issueStatus.text=@"Proccessing";
    }
    else if (status==2)
    {
        issueStatus.text=@"Proccessed";
    }
    else
    {
        issueStatus.text=@"No Status";
    }
    
}
-(IBAction)SubmitButton:(id)sender
{
    
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
