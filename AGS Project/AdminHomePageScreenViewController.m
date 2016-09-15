//
//  AdminHomePageScreenViewController.m
//  AGS Project
//
//  Created by venkat on 7/30/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "AdminHomePageScreenViewController.h"

@interface AdminHomePageScreenViewController ()

@end

@implementation AdminHomePageScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton= YES;   // code to hide navigation back button
   
    UIBarButtonItem *logoutbtn = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStyleDone target:self action:@selector(logoutAction:)];
      self.navigationItem.rightBarButtonItem = logoutbtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) logoutAction: (id)sender
{
    //self.navigationItem.rightBarButtonItem.title = @"Logout" ;
    [self.navigationController popToRootViewControllerAnimated:YES];
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
