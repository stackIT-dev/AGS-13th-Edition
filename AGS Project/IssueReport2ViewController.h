//
//  IssueReport2ViewController.h
//  AGS Project
//
//  Created by venkat on 7/20/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueReport2ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *issueSelectedTitle;
@property (strong, nonatomic) IBOutlet UIButton *IssueTitleButton1;
@property (strong, nonatomic) IBOutlet UIButton *IssueTitleButton2;
@property (strong, nonatomic) IBOutlet UIButton *IssueTitleButton3;
-(IBAction)IssueTitleAlert1:(id)sender;
-(IBAction)IssueTitleAlert2:(id)sender;
-(IBAction)IssueTitleAlert3:(id)sender;
-(IBAction)IssueCameralert:(id)sender;
-(IBAction)IssueLocationAlert:(id)sender;


@end
