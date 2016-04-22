//
//  NewQuestionViewController.m
//  TutorME
//
//  Created by Kumaran Sathianathan on 2016-04-04.
//

#import "NewQuestionViewController.h"
#import "AppDelegate.h"
#import "Styles.h"

@interface NewQuestionViewController ()
@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) Firebase *qref;
@property (strong, nonatomic) Firebase *uref;
@property (strong, nonatomic) Firebase *uscoreref;
@property (strong, nonatomic) Styles *styles;

@property (strong, nonatomic) NSString *fname;
@property (strong, nonatomic) NSString *lname;

@end

@implementation NewQuestionViewController
@synthesize descTextField, detailsTextView, nq, activity, tapper, clearBtn, submitBtn;

#pragma mark View Methods
// This method is for initializing firebase refs, UIView styles, activity indicator, Gesture Recognizer.
// The gesture recognizer is for dismissing the keyboard
- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize Firebase reference
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
    self.qref = [self.ref childByAppendingPath:@"questions"];
    self.uref = [self.ref childByAppendingPath:@"users"];
    self.uscoreref = [self.uref childByAppendingPath:[self.ref.authData.uid stringByAppendingString:@"/score"]];
    
    // Initialize Styles class
    self.styles = [[Styles alloc] init];
    
    // Initialize Activity Indicator
    [self.activity setHidden:YES];
    [self.activity stopAnimating];
    
    // Gesture recognizer
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    // Styling
    [Styles fieldStyle:descTextField];
    [Styles textViewStyle:detailsTextView];

    [Styles buttonStyle:clearBtn];
    [Styles buttonStyle:submitBtn];
}

// This method is for retrieving the user's first name and last name. The full name is added to the
// firebase database in the question tree node when a new question is submitted.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Retrieve user first name and last name to write to database
    [[self.uref childByAppendingPath:self.ref.authData.uid] observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *usnapshot) {
        self.fname = usnapshot.value[@"first_name"];
        self.lname = usnapshot.value[@"last_name"];
    }];
}

#pragma mark Keyboard Related Method
// This method is for dismissing the keyboard when no editing is happening.
- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma make Button Methods
// This method is for transitioning to the last UIViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// This method is for clearing the all question fields.
- (IBAction)clearBoth:(id)sender {
    descTextField.text = @"";
    detailsTextView.text = @"";
}

#pragma mark Text Field Related Methods
// This method limits the number of characters for the description field.
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= MAX_LENGTH_140 && range.length == 0) {
        return NO; // Change not allowed
    } else {
        return YES; // Change allowed
    }
}

// This method limits the number of characters for the details field.
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView.text.length >= MAX_LENGTH_255 && range.length == 0) {
        return NO; // Change not allowed
    } else {
        return YES; // Change allowed
    }
}

#pragma mark Submit Question Related Methods
// This method is for submitting a question to the database. Error checking is included when the user does not
// complete the appropriate fields
- (IBAction)submit:(id)sender {

    NSString *msg = @"";
    
    self.nq = [[NewQuestion alloc] initWithData:descTextField.text details:detailsTextView.text];
    
    if ([self.nq.details containsString:@"Enter additional details here..."]) {
        msg = @"Please enter your own details.";
        [self alert:@"ERROR" message:msg];
        
    } else if (self.nq.isDescEmpty && self.nq.isDetailsEmpty) {
        msg = @"Please enter the description and the details.";
        [self alert:@"ERROR" message:msg];
    } else if (self.nq.isDetailsEmpty) {
        msg = @"Please enter the details.";
        [self alert:@"ERROR" message:msg];
    } else if (self.nq.isDescEmpty) {
        msg = @"Please enter the description.";
        [self alert:@"ERROR" message:msg];
    } else {
        
        // The date of submission
        NSString *dateSubmitted;
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM d, yyyy 'at' h:mma"];
        dateSubmitted = [dateFormatter stringFromDate:date];
        
        // Build the full name from the first name and last name
        NSString *fullName = [self.fname stringByAppendingFormat:@" %@", self.lname];
        
        // The details of the question
        NSDictionary *question = @{
                                          @"description" : self.nq.desc,
                                          @"details" : self.nq.details,
                                          @"submitted_by_name" : fullName,
                                          @"submitted_by_id" : self.ref.authData.uid,
                                          @"submission_date" : dateSubmitted
                                          };
        
        // Start Activity Indicator
        [self.activity setHidden:NO];
        [self.activity startAnimating];
        
        
        // Firebase method for adding to the database - creates a new child for "questions" node
        [[self.qref childByAutoId] setValue:question withCompletionBlock:^(NSError *error, Firebase *ref) {
            
            NSString *msg = @"";
            
            if (error) {
                msg = @"The question could not be saved. Try again";
                [self alert:@"ERROR" message:msg];
            } else {
                
                // Update the score of the user for posting a question - Firebase method
                [self.uscoreref runTransactionBlock:^FTransactionResult *(FMutableData *currentData) {
                    NSNumber *value = currentData.value;
                    if (currentData.value == [NSNull null]) {
                        value = 0;
                    }
                    [currentData setValue:[NSNumber numberWithInt:(QUESTION_INC + [value intValue])]];
                    return [FTransactionResult successWithValue:currentData];
                }];
                
            }
            
            // Stop Activity Indicator
            [self.activity setHidden:YES];
            [self.activity stopAnimating];
            
            // Success message
            msg = @"The question was saved successfully. Thank you.";
            [self alert:@"SUCCESS" message:msg];
           
            [self resetBoth];
        }];
    }
}

// This method is for resetting the question fields to initial state when view is loaded.
- (void)resetBoth {
    self.descTextField.text = @"";
    self.detailsTextView.text = @"Enter additional details here.";
}

// This is a simple Alert dialog for informing the user of any error when attempting to submit a question
// to the database. Also used to inform the user if submitting a question to the database is successful.
- (void)alert:(NSString *)title message:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
