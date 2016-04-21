//
//  LoginViewController.m
//  TutorME
//
//  Created by kmayo on 2016-04-03.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController ()
@property (strong, nonatomic) Firebase *ref;
@end

@implementation LoginViewController
@synthesize emailField, passwordField, activity, login, signInBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize Firebase reference
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
    
    // Initialize Activity Indicator
    [self.activity setHidden:YES];
    [self.activity stopAnimating];
    
    emailField.layer.borderColor = [[UIColor redColor]CGColor];
    emailField.layer.borderWidth = 2.0;
    emailField.layer.cornerRadius = 5;
    
    passwordField.layer.borderColor = [[UIColor redColor]CGColor];
    passwordField.layer.borderWidth = 2.0;
    passwordField.layer.cornerRadius = 5;
    
    signInBtn.layer.borderColor = [[UIColor blackColor]CGColor];
    signInBtn.layer.borderWidth = 2.0;
    signInBtn.layer.cornerRadius = 5;
    
    [self.tabBarController.tabBar setBarTintColor:[UIColor redColor]];
    [self.tabBarController.tabBar setTranslucent:NO];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont fontWithName:@"GillSans-Bold" size:20.0]
                                                                      }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)login:(id)sender {
    NSString *msg = @"";
    
    self.login = [[Login alloc] initWithData:self.emailField.text password:self.passwordField.text];
    
    if (self.login.isPasswordEmpty && login.isEmailEmpty) {
        msg = @"Please enter your email and password.";
        [self alert:msg];
    } else if (self.login.isPasswordEmpty) {
        msg = @"Please enter your password.";
        [self alert:msg];
    } else if (self.login.isEmailEmpty) {
        msg = @"Please enter your email.";
        [self alert:msg];
    } else {
        
        // Start Activity Indicator
        [self.activity setHidden:NO];
        [self.activity startAnimating];
        
        // Firebase authentication
        [self.ref authUser:login.email password:login.password withCompletionBlock:^(NSError* error, FAuthData* authData) {
            NSString *msg = @"";
            if (error != nil) {
                // an error occurred while attempting login
                switch(error.code) {
                    case FAuthenticationErrorUserDoesNotExist:
                        // Handle invalid user
                        msg = @"Invalid user.";
                        [self alert:msg];
                        break;
                    case FAuthenticationErrorInvalidEmail:
                        // Handle invalid email
                        msg = @"Invalid email.";
                        [self alert:msg];
                        break;
                    case FAuthenticationErrorInvalidPassword:
                        // Handle invalid password
                        msg = @"Invalid password";
                        break;
                    default:
                        break;
                }
            } else {
                // User is logged in
                
                // Go to home screen (UITabBarController)
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UITabBarController *homeTBC = [sb instantiateViewControllerWithIdentifier:@"homeTBC"];
                [homeTBC setModalPresentationStyle:UIModalPresentationFullScreen];
                [self presentViewController:homeTBC animated:YES completion:nil];
            }
            
            // End Activity Indicator
            [self.activity setHidden:YES];
            [self.activity stopAnimating];
         }];
    }
}

- (void)alert:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ERROR" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
