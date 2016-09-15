//
//  AdminIssueShowScreen1ViewController.m
//  AGS Project
//
//  Created by venkat on 8/1/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import "AdminIssueShowScreen1ViewController.h"
#import "sqlite3.h"
#import <MapKit/MapKit.h>
#import "MapViewAnnotation.h"
@interface AdminIssueShowScreen1ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation AdminIssueShowScreen1ViewController
@synthesize issueDescriptionLabel,issueTitleButton,IssueImageShow, databasePath,userProfilesDB1, issueTitleLabel, issuerEmailID;
-(sqlite3 *)getNewConnection
{
    sqlite3 *newConnection;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"db documents %@",documentsDirectory);
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"T20.db"];
    NSLog(@"db path %@",path);
    if(sqlite3_open([path UTF8String], &newConnection) == SQLITE_OK)
    {
        NSLog(@"database open");
    }
    else
    {
        NSLog(@"datbase error %@",[NSString stringWithCString:sqlite3_errmsg(newConnection) encoding:NSUTF8StringEncoding]);
        sqlite3_close(newConnection);
    }
    
    return newConnection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    
    {
        
        
        sqlite3 *newConnection = [self getNewConnection];
        
        sqlite3_stmt    *statement;
        const char *dbpath = [databasePath UTF8String];
        
        /////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////
        NSString *selectedIssueNumber;
        NSString *thisIssueNUmber = [defs objectForKey:@"UserSelectedIssueNumberFromReportedScreen"];
        selectedIssueNumber = [NSString stringWithFormat:@"%@", thisIssueNUmber];
        NSLog(@"username retrieved = %@", selectedIssueNumber);
        
        NSMutableData *imgData = [[NSMutableData alloc] init];
        /////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////
        
        {
            NSString *querySQL = [NSString stringWithFormat: @"SELECT ISSUETITLE, ISSUEDESCRIPTION, LOCATIONLONGITUDE, LOCATIONLATITUDE,IMAGEPATH,IMAGE, STATUS, DATE, EMAIL, ISSUECOMMENT FROM REPORTEDISSUES WHERE ISSUENUMBER =\"%@\"", selectedIssueNumber];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(newConnection, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSString *issueTitle = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    [issueTitleButton setTitle:issueTitle forState:UIControlStateNormal];
                    [defs setObject: issueTitle forKey:@"UserSelectedIssueTitle"];
                    
                    
                    //NSLog(@"inner nslog with email is: %@", nameField);
                    NSString *issueDescription = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    issueDescriptionLabel.text = issueDescription;
                    [defs setObject: issueDescriptionLabel.text forKey:@"UserSelectedIssueDescription"];
                    
                    
                    NSString *issueLocationLongitude = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    [defs setObject: issueLocationLongitude forKey:@"UserSelectedIssueLocationLongitude"];
                    
                    NSString *issueLocationLatitude = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    [defs setObject: issueLocationLatitude forKey:@"UserSelectedIssueLocationLatitude"];
                    NSString *filePath = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
                    {
                        // imgData = (NSMutableData *)[[NSFileManager defaultManager] contentsAtPath:filePath];
                    }
                    NSString *issueStatus = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                    [defs setObject: issueStatus forKey:@"UserSelectedIssueStatus"];
                    NSString *issueDate = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                    [defs setObject: issueDate forKey:@"UserSelectedIssueDateAndTime"];
                    
                    
                    //NSLog(@"inner nslog with phone is: %@", phoneField);
                    int length = sqlite3_column_bytes(statement, 5);
                    imgData = (NSMutableData *)[[NSData alloc] initWithBytes:sqlite3_column_blob(statement, 5) length:length];
                    
                    NSString *issuerRetrievedEmailID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
                    
                    issuerEmailID.text=issuerRetrievedEmailID;
                    NSString *issueComment = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)];
                    [defs setObject: issueComment forKey:@"UserSelectedIssueComment"];
                    [defs synchronize];
                }
                else
                {
                    NSLog(@"inner IF");
                    NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection));
                    
                }
                
            }
            else
            {
                NSLog(@"databse opened but could get credenrtials");
                NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(newConnection));
                
            }
            sqlite3_finalize(statement);
            
            sqlite3_close(newConnection);
        }
        
        [IssueImageShow setImage:[UIImage imageWithData:imgData]];
        [[NSUserDefaults standardUserDefaults] setObject:imgData forKey:@"UserSelectedIssueImage"];
        float longitude = [[defs objectForKey:@"UserSelectedIssueLocationLongitude"] floatValue];
        float lat = [[defs objectForKey:@"UserSelectedIssueLocationLatitude"] floatValue];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, longitude);
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coordinate;
        
        MapViewAnnotation *annotation = [[MapViewAnnotation alloc] initWithTitle:issueTitleLabel.text AndCoordinate:coordinate];
        //[_mapView addAnnotation:annotation];
        [_mapView addAnnotation:point];
        
        
    }

    // Do any additional setup after loading the view.
}
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
    annView.pinColor = MKPinAnnotationColorGreen;
    return annView;
}
-(IBAction) nextScreen:(id)sender
{
    [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"AdminIssueShowScreen2"] animated:YES];
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
