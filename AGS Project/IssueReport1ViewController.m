//
//  IssueReport1ViewController.m
//  AGS Project
//
//  Created by venkat on 7/20/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "IssueReport1ViewController.h"
#import "LoginPageViewController.h"

@interface IssueReport1ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *mapview;

@end

@implementation IssueReport1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   }
-(IBAction)IssueDescriptionAlert:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                    message:@"Please Select Title First"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
-(IBAction)IssueDescriptionAlert2:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                    message:@"Please Select Title First"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

-(IBAction)IssueCameralert:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                    message:@"Please Select Title First"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
-(IBAction)IssueLocationAlert:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                    message:@"Please Select Title First"
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
