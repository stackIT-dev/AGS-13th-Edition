//
//  IssueDescriptionEditorViewController.m
//  AGS Project
//
//  Created by venkat on 7/20/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "IssueDescriptionEditorViewController.h"
#import "LoginPageViewController.h"

@interface IssueDescriptionEditorViewController ()

@end

@implementation IssueDescriptionEditorViewController
@synthesize descriptionEditor,SubmitButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}
-(IBAction)SubmitButtonAction:(id)sender
{
    //[descriptionEditor resignFirstResponder] ;
    //NSString* textViewContents = descriptionEditor.text ;
   // NSLog(@"textViewContents is: %@", textViewContents) ;
    
    //NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults] ;
    //[userDefaults setObject:textViewContents forKey:@"IssueDescriptionEditor"] ;
    //[userDefaults synchronize] ;
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject: descriptionEditor.text forKey:@"IssueDescriptionEditor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"Issue Report Screen"] animated:YES];
    
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
