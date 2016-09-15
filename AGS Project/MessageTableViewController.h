//
//  MessageTableViewController.h
//  AGS Project
//
//  Created by venkat on 7/18/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface MessageTableViewController : UITableViewController
//NSMutableArray *todoArray;
@property(nonatomic, retain) NSMutableArray *messagesArray;
@end
