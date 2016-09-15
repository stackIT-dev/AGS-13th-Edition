//
//  IssueDescriptionEditorViewController.h
//  AGS Project
//
//  Created by venkat on 7/20/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueDescriptionEditorViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *descriptionEditor;

@property (strong, nonatomic) IBOutlet UIButton *SubmitButton;
-(IBAction)SubmitButtonAction:(id)sender;

@end
