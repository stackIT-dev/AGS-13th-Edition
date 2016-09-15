//
//  AdminMessagesScreenViewController.h
//  AGS Project
//
//  Created by venkat on 7/28/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface AdminMessagesScreenViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray *messagesArray;

    IBOutlet UITableView *tableView;
}

@property (strong, nonatomic) IBOutlet UIButton *sendMessageButton;
@property (strong, nonatomic) IBOutlet UITextView *messageText;
-(IBAction)createMessageAlert:(id)sender;
@end
