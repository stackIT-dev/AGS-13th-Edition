//
//  AppDelegate.h
//  AGS Project
//
//  Created by venkat on 7/9/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
-(sqlite3 *)getNewConnection;



@end

