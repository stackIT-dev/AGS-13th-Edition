//
//  AdminIssueShowScreen2ViewController.h
//  AGS Project
//
//  Created by Venkat on 9/9/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminIssueShowScreen2ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *issueTitle;
@property (strong, nonatomic) IBOutlet UILabel *issueDescription;
@property (strong, nonatomic) IBOutlet UILabel *issueStatus;
@property (strong, nonatomic) IBOutlet UILabel *issueNumber;
@property (strong, nonatomic) IBOutlet UILabel *isserName;
@property (strong, nonatomic) IBOutlet UILabel *isserDate;
@property (strong, nonatomic) IBOutlet UIImageView *issueImage;
@property (weak, nonatomic) IBOutlet UIButton *SubmitButton;
@property (weak, nonatomic) IBOutlet UITextView *IssueComment;
-(IBAction)SubmitButton:(id)sender;
@end
