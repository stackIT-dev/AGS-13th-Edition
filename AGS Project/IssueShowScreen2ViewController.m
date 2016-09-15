//
//  IssueShowScreen2ViewController.m
//  AGS Project
//
//  Created by venkat on 7/21/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "IssueShowScreen2ViewController.h"

@interface IssueShowScreen2ViewController ()

@end

@implementation IssueShowScreen2ViewController
@synthesize issueNumber,issueTitle,issueDescription, issueStatus, isserName, isserDate,issueImage;
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
