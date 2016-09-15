//
//  IssueReportViewController.m
//  AGS Project
//
//  Created by venkat on 7/10/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "IssueReportViewController.h"
#import "sqlite3.h"
#import "AppDelegate.h"
#import "IssueDescriptionEditorViewController.h"

@interface IssueReportViewController ()
{
    AppDelegate *appDelegate;
     CLLocationManager *mgr;
    CLLocationManager *locationManager;
    NSInteger longitudeNumber;
    NSInteger latitudeNumber;
    NSData *imgData;
    NSInteger issueCountAtPresent;
    NSString *presentDateAndTime;

}

@end

@implementation IssueReportViewController

- (IBAction) imageOptionsPopUp{
   // UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Choose One" message:@"Please select
    //any option" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil ];
    //[alert show];
    
    /*
        UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"Choose One"
                                                               delegate:self
                                                      cancelButtonTitle: nil
                                                 destructiveButtonTitle: nil
                                                      otherButtonTitles:@"Take From Camera",@"Select From Library", @"Cancel", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        actionSheet.destructiveButtonIndex=2;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    */
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                   message:@"This is an alert."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Take From Camera" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self takePictureFromCamera];
                                                          }];
    
    UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"Pick from library" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action1) {
                                                              [self pickImageFromLibrary];
                                                          }];
    UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * cancel) {
                                                        [self dismissViewControllerAnimated:YES completion:nil];
                                                          }];

    [alertController addAction:defaultAction];
    [alertController addAction:defaultAction1];
    [alertController addAction:defaultAction2];
    [self presentViewController:alertController animated:YES completion:nil];

}

-(void) pickImageFromLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    

    }

    -(IBAction)issueDescriptionAction:(id)sender
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                        message:@"Please go back to change description"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    -(IBAction)IssueTitleAlert:(id)sender
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Alert"
                                                        message:@"Please go back to select other title"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
 


-(void) takePictureFromCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];

        }

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    imgData  = UIImagePNGRepresentation(self.imageView.image);
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex==0) {
        [self takePictureFromCamera];
    }
    else if (buttonIndex==1) {
        [self pickImageFromLibrary];
        
    }
}





@synthesize longitudeLabel,latitudeLabel, issueSelectedTitle,issueSelectedDescription, loggedEmail1,issueCreatedDate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //////////date and time opened
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    presentDateAndTime = [dateFormatter stringFromDate:[NSDate date]];
    
    ////////////date and time closed
    
    mgr =[[CLLocationManager alloc]init];
    [mgr requestWhenInUseAuthorization];
    locationManager = [[CLLocationManager alloc] init];
    
    //NSString *thisUserEmailID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserEmailIDForWholeApp1"];
   // self.loggedEmail1.text = [NSString stringWithFormat:@"%@", thisUserEmailID]; //assaigning fullname to display on Screen
    

    
    NSString *SelectedIssue = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserSelectedIssue"];
    self.issueSelectedTitle.text = [NSString stringWithFormat:@"%@", SelectedIssue]; //assaigning fullname to display on Screen
    //NSLog(@"issue title retrieved = %@", issueSelectedTitle.text);
    
    
    
    NSString *SelectedDescription = [[NSUserDefaults standardUserDefaults] objectForKey:@"IssueDescriptionEditor"];
    self.issueSelectedDescription.text = [NSString stringWithFormat:@"%@", SelectedDescription];
NSLog(@"issue title retrieved = %@", issueSelectedDescription.text);
    
//    longitudeLabel.text = [NSString stringWithFormat:@"%.8f",_mapView.userLocation.coordinate.latitude];
//    latitudeLabel.text = [NSString stringWithFormat:@"%.8f", _mapView.userLocation.coordinate.longitude];
//    longitudeNumber = [longitudeLabel.text integerValue];
//    latitudeNumber = [latitudeLabel.text integerValue];

    
    
    
    // Do any additional setup after loading the view.
}
/*
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *SelectedIssue = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserSelectedIssue"];
    if (SelectedIssue.length>0) {
        
    }
    else{
        
    }
    self.issueSelectedTitle.text = [NSString stringWithFormat:@"%@", SelectedIssue]; //assaigning fullname to display on Screen
    //NSLog(@"issue title retrieved = %@", issueSelectedTitle.text);
    
    
    
    NSString *SelectedDescription = [[NSUserDefaults standardUserDefaults] objectForKey:@"IssueDescriptionEditor"];
    self.issueSelectedDescription.text = [NSString stringWithFormat:@"%@", SelectedDescription];

    
}
 */
- (IBAction)getCurrentLocation:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        longitudeLabel.text =[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        longitudeNumber = [longitudeLabel.text integerValue];
          latitudeNumber = [latitudeLabel.text integerValue];
        }
   }

-(IBAction)SubmitIssue:(id)sender
{
    //NSString *loggedEmail = @"test";
    NSLog(@"username retrieved = %@", loggedEmail1.text);
    /*
    CFGregorianDate currentDate = CFAbsoluteTimeGetGregorianDate(CFAbsoluteTimeGetCurrent(), CFTimeZoneCopySystem());
    issueCreatedDate.text = [NSString stringWithFormat:@"%02d:%02d:%02.0f", currentDate.hour, currentDate.minute, currentDate.second];
    CFRelease(currentDate);

    */

    
    ////////////////////////////////////////////getting previous issue count
    NSInteger issueCountPrevious;
    sqlite3 *newConnection12345;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"T20.db"];
    
    if(sqlite3_open([path UTF8String], &newConnection12345) == SQLITE_OK)
    {
        //NSLog(@"Issue Count DB OK");
        //int rowID = sqlite3_last_insert_rowid(newConnection12345);
        NSString *sql = @"SELECT count(*) FROM ALLISSUESCOUNT";
        sqlite3_stmt *selectStatement;
        int returnValue = sqlite3_prepare_v2(newConnection12345, [sql UTF8String], -1, &selectStatement, NULL);
        //NSLog(@"Issue Count DB2 OK222222");
        if (returnValue == SQLITE_OK)
        {
            if(sqlite3_step(selectStatement) == SQLITE_ROW)
            {
                NSLog(@"Issue Count Retrived");
                //int numrows= sqlite3_column_count(selectStatement);
                issueCountPrevious= sqlite3_column_int(selectStatement, 0);
                //numRowsInPast= sqlite3_last_insert_rowid(1);
                //MessageNotify.text = [NSString stringWithFormat:@"%d", numrows];
                //MessageNotify.text = [NSString stringWithFormat:@"%ld", (long)numRowsInPast];
                NSLog(@"Number of issues in previous '%ld'", (long)issueCountPrevious);
            }
            else
            {
                NSLog(@"entering here in second else");
            }
        }
        else
        {
            NSLog(@"Entering IssueCount previous ELSE");
        }
        sqlite3_finalize(selectStatement);
        sqlite3_close(newConnection12345);
        
    }
    

    
    
    ///////////////////////////////////////////
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *newConnection = [appDelegate getNewConnection];
    
    
    {

        issueCountAtPresent= (issueCountPrevious+1);
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //Get documents directory
        NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains
        (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectoryPath = [directoryPaths objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/myFile%ld.png",documentsDirectoryPath,(long)issueCountAtPresent];
        if ([fileManager createFileAtPath:filePath contents:imgData attributes:nil]) {
            NSLog(@" saved");
        }
        else
        {
            NSLog(@"not saved");
        }
        

        NSLog(@"Number of issues At Present '%ld'", (long)issueCountAtPresent);

        NSInteger initialStatus= 1;
        NSString *IssueComment= @"No Comments Yet";
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO REPORTEDISSUES (EMAIL, ISSUETITLE, ISSUEDESCRIPTION, LOCATIONLONGITUDE, LOCATIONLATITUDE,DATE,TIME, STATUS, IMAGEPATH,ISSUENUMBER, IMAGE, ISSUECOMMENT) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?,?)"];
       //NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO MESSAGETABLE (IMAGE) VALUES (\"%@\")", imgData];
        //NSLog(@"loggedemail: %@", loggedEmail1);
        
        /*
         loggedEmail1.text, issueSelectedTitle.text, issueSelectedDescription.text, longitudeLabel.text, latitudeLabel.text, (long)issueCountAtPresent, (long)initialStatus, filePath
         */
        NSLog(@"issue title: %@", issueSelectedTitle.text);
        NSLog(@"issue description: %@", issueSelectedDescription.text);
        NSLog(@"longitude: %@", longitudeLabel.text);
        NSLog(@"latitude: %@", latitudeLabel.text);
        //NSLog(@"image data: %@", imgData);
        

        char *error;
        
        //if (sqlite3_step(statement) == SQLITE_DONE)
        /*if (sqlite3_exec(newConnection,[insertSQL UTF8String] , NULL, NULL, &error)== SQLITE_OK)
            
        {
            NSLog(@"Successfully Issue Saved");
            [self AddIssueNumberToCount];
            
                NSString *msg = [NSString stringWithFormat:@"Your Issue Number # %ld", (long)issueCountAtPresent]; //to show
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"IssueSuccessfully Submitted" message:msg preferredStyle:UIAlertControllerStyleAlert];
                
            
                UIAlertAction *okACtion =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                {
                    [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"mainScreen"] animated:YES];
                    
                }];
                
                [alert addAction:okACtion];
                [self presentViewController:alert animated:YES completion:nil];
        }*/
        sqlite3_stmt* statement;

        if( sqlite3_prepare_v2(newConnection, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK )
        {

            NSString *thisUserEmailID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserEmailIDForWholeApp1"];
            sqlite3_bind_text(statement, 1, [thisUserEmailID UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [issueSelectedTitle.text UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [issueSelectedDescription.text UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [longitudeLabel.text UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [latitudeLabel.text UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 6, [presentDateAndTime UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 7, [@"" UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_double(statement,8,(long)initialStatus);
            sqlite3_bind_text(statement, 9, [filePath UTF8String], -1, SQLITE_TRANSIENT);

            sqlite3_bind_double(statement,10,(long)issueCountAtPresent);
            sqlite3_bind_blob(statement, 11, [imgData bytes], (int)[imgData length], SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 12, [IssueComment UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_step(statement);
            
            
            NSString *msg = [NSString stringWithFormat:@"Your Issue Number # %ld", (long)issueCountAtPresent]; //to show
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"IssueSuccessfully Submitted" message:msg preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *okACtion =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                      {
                                          [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"mainScreen"] animated:YES];
                                          
                                      }];
            
            [alert addAction:okACtion];
            [self presentViewController:alert animated:YES completion:nil];

        }
        else
        {
            //status.text = @"Failed to add contact";
            NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection));
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(newConnection);
       
        [self AddIssueNumberToCount];


}
}
-(void)AddIssueNumberToCount
{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *newConnection123 = [appDelegate getNewConnection];
    
    
    {
        
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO ALLISSUESCOUNT (COUNT) VALUES (\"%ld\")", (long)issueCountAtPresent];
        
        
        //NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO MESSAGETABLE (IMAGE) VALUES (\"%@\")", imgData];
        char *error;
        
        //if (sqlite3_step(statement) == SQLITE_DONE)
        if (sqlite3_exec(newConnection123,[insertSQL UTF8String] , NULL, NULL, &error)== SQLITE_OK)
            
        {
            NSLog(@"Successfully entered presentIssueNumber %lu",(unsigned long)issueCountAtPresent);
            //[self presentViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"LoginPage"] animated:YES completion:nil];
            
        }
        
        else
        {
            //status.text = @"Failed to add contact";
            NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection123));
            
        }
        //sqlite3_finalize(statement);
        sqlite3_close(newConnection123);
    }
    

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
