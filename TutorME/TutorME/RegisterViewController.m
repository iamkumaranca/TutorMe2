//
//  RegisterViewController.m
//  TutorME
//
//  Created by Kumaran Sathianathan on 2016-04-03.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "Styles.h"

@interface RegisterViewController ()

@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) Firebase *userRef;
@property (strong, nonatomic) Styles *styles;

@end

@implementation RegisterViewController
@synthesize fnameField, lnameField, schoolField, programField, yearSegCtrl, emailField, passwordField, confirmField, registration, activity, clearBtn, submitBtn, personIcon, schoolIcon, registerIcon;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize Firebase reference
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
    self.userRef = [self.ref childByAppendingPath:@"users"];
    
    // Initialize Styles class
    self.styles = [[Styles alloc] init];
    
    // Initialize Activity Indicator
    [self.activity setHidden:YES];
    [self.activity stopAnimating];
    
    [Styles fontIcon:personIcon icon:[NSString stringWithUTF8String:"\uF007"]];
    [Styles fontIcon:schoolIcon icon:[NSString stringWithUTF8String:"\uF19D"]];
    [Styles fontIcon:registerIcon icon:[NSString stringWithUTF8String:"\uF084"]];
    
    // Styling
    [Styles fieldStyle:fnameField];
    [Styles fieldStyle:lnameField];
    [Styles fieldStyle:schoolField];
    [Styles fieldStyle:programField];
    [Styles fieldStyle:emailField];
    [Styles fieldStyle:passwordField];
    [Styles fieldStyle:confirmField];
    
    [Styles buttonStyle:clearBtn];
    [Styles buttonStyle:submitBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetAll:(id)sender {
    self.fnameField.text = @"";
    self.lnameField.text = @"";
    self.schoolField.text = @"";
    self.programField.text = @"";
    [self.yearSegCtrl setSelectedSegmentIndex:0];
    self.emailField.text = @"";
    self.passwordField.text = @"";
    self.confirmField.text = @"";
}

- (IBAction)submitRegistration:(id)sender {
    NSString *msg = @"";
    
    self.registration = [[Registration alloc]initWithData:fnameField.text lname:lnameField.text school:schoolField.text program:programField.text year:[self.yearSegCtrl titleForSegmentAtIndex:self.yearSegCtrl.selectedSegmentIndex] email:emailField.text password:passwordField.text confirm:confirmField.text];
    
    // Input Validation
    if (!self.registration.isCompleted) {
        msg = @"All information are required to complete the registration.";
        [self alert:@"ERROR" message:msg];
    } else if (!self.registration.isValidEmail) {
        msg = @"Invalid email format.";
        [self alert:@"ERROR" message:msg];
    } else if (!self.registration.isConfirmedPassword) {
        msg = @"The password does not match.";
        [self alert:@"ERROR" message:msg];
    } else {
        // Start Activity Indicator
        [self.activity setHidden:NO];
        [self.activity startAnimating];
        
        // TESTING - TO BE REMOVED
        //msg = [msg stringByAppendingFormat:@"%@||%@||%@||%@||%@||%@||%@||%@", self.registration.fname, self.registration.lname, self.registration.school, self.registration.program, self.registration.year, self.registration.email, self.registration.password, self.registration.confirm];
        //[self alert:msg];
        
        // Firebase user creation
        [self.ref createUser:self.registration.email password:self.registration.password withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
            
            NSString *msg = @"";
            if (error) {
                msg = @"Failed to create user. Try Again.";
                [self alert:@"ERROR" message:msg];
            } else {
                
                // User details
                NSDictionary *userDetails = @{
                                              @"first_name" : self.registration.fname,
                                              @"last_name" : self.registration.lname,
                                              @"school" : self.registration.school,
                                              @"program" : self.registration.program,
                                              @"year": self.registration.year,
                                              @"score" : @0
                                              };
                
                // Add user details to JSON Tree
                NSString *userID = [result objectForKey:@"uid"];
                [[self.userRef childByAppendingPath:userID] setValue:userDetails];
                
                // Alert Message
                msg = [msg stringByAppendingFormat:@"Thank you %@ %@ for your registration.", self.registration.fname, self.registration.lname];
                [self alert:@"SUCCESS" message:msg];
                
                // Reset all fields;
                [self resetAll:nil];
            }
            
            // End Activity Indicator
            [self.activity setHidden:YES];
            [self.activity stopAnimating];
        }];
    }
}

- (void)alert:(NSString *)title message:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// Maximum length for each text field
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int allowedLength;
    switch(textField.tag) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
            allowedLength = MAX_LENGTH_50;
            break;
        case 6:
        case 7:
            allowedLength = MAX_LENGTH_10;
            break;
        default:
            allowedLength = MAX_LENGTH_255;
            break;
    }
    
    if (textField.text.length >= allowedLength && range.length == 0) {
        return NO; // Change not allowed
    } else {
        return YES; // Change allowed
    }
}

@end
