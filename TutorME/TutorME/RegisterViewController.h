//
//  RegisterViewController.h
//  TutorME
//
//  Created by kmayo on 2016-04-03.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import "Registration.h"

@interface RegisterViewController : UITableViewController
{
    IBOutlet UITextField *fnameField;
    IBOutlet UITextField *lnameField;
    IBOutlet UITextField *schoolField;
    IBOutlet UITextField *programField;
    IBOutlet UISegmentedControl *yearSegCtrl;
    IBOutlet UITextField *emailField;
    IBOutlet UITextField *passwordField;
    IBOutlet UITextField *confirmField;
    Registration *registration;
    IBOutlet UIActivityIndicatorView *activity;
}

@property (strong, nonatomic) IBOutlet UITextField *fnameField;
@property (strong, nonatomic) IBOutlet UITextField *lnameField;
@property (strong, nonatomic) IBOutlet UITextField *schoolField;
@property (strong, nonatomic) IBOutlet UITextField *programField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *yearSegCtrl;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *confirmField;
@property (strong, nonatomic) Registration *registration;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end