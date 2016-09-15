//
//  IssueReportViewController.h
//  AGS Project
//
//  Created by venkat on 7/10/16.
//  Copyright © 2016 venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "sqlite3.h"
#import "AppDelegate.h"

#import "LoginPageViewController.h"



@interface IssueReportViewController : UIViewController<MKMapViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *CameraListOptionButton;
-(IBAction) imageOptionsPopUp;
@property (strong, nonatomic) IBOutlet UIButton *getLocation;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *loggedEmail1;
@property (strong, nonatomic) IBOutlet UILabel *issueCreatedDate;
@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (strong, nonatomic) IBOutlet UIButton *issueDescriptionButton;

@property (strong, nonatomic) IBOutlet UILabel *issueSelectedTitle;
@property (strong, nonatomic) IBOutlet UILabel *issueSelectedDescription;

-(IBAction)getCurrentLocation:(id)sender;
-(IBAction)issueDescriptionAction:(id)sender;
-(IBAction)SubmitIssue:(id)sender;


@end
