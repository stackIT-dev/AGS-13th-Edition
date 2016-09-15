//
//  IssueReport2ViewController.m
//  AGS Project
//
//  Created by venkat on 7/20/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "IssueReport2ViewController.h"

@interface IssueReport2ViewController ()

@end

@implementation IssueReport2ViewController
@synthesize issueSelectedTitle;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *SelectedIssue = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserSelectedIssue"];
    self.issueSelectedTitle.text = [NSString stringWithFormat:@"%@", SelectedIssue]; //assaigning fullname to display on Screen
}

-(IBAction)IssueTitleAlert1:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                    message:@"Please go back to select other"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
-(IBAction)IssueTitleAlert2:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                    message:@"Please go back to select other"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
-(IBAction)IssueTitleAlert3:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                    message:@"Please go back to select other"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
-(IBAction)IssueCameralert:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                    message:@"Please enter description"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
-(IBAction)IssueLocationAlert:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                    message:@"Please enter description"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
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
