//
//  NewQuestionViewController.m
//  TutorME
//
//  Created by kmayo on 2016-04-04.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import "NewQuestionViewController.h"
#import "AppDelegate.h"

@interface NewQuestionViewController ()
@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) Firebase *qref;
@property (strong, nonatomic) Firebase *uref;
@property (strong, nonatomic) Firebase *uscoreref;

@property (strong, nonatomic) NSString *fname;
@property (strong, nonatomic) NSString *lname;
@end

@implementation NewQuestionViewController
@synthesize descTextField, detailsTextView, nq, activity, tapper, editIcon, editIcon2;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize Firebase reference
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
    self.qref = [self.ref childByAppendingPath:@"questions"];
    self.uref = [self.ref childByAppendingPath:@"users"];
    self.uscoreref = [self.uref childByAppendingPath:[self.ref.authData.uid stringByAppendingString:@"/score"]];
    
    // Initialize Activity Indicator
    [self.activity setHidden:YES];
    [self.activity stopAnimating];
    
    // Gesture recognizer
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    //[editIcon setFont:[UIFont fontWithName:@"FontAwesome" size:17]];
    editIcon.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:17];
    [editIcon setTitle:@"\uF12D" forState:UIControlStateNormal];
    
    editIcon2.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:17];
    [editIcon2 setTitle:@"\uF12D" forState:UIControlStateNormal];
    
    descTextField.layer.borderColor=[[UIColor redColor]CGColor];
    descTextField.layer.borderWidth=1.0;
    descTextField.layer.cornerRadius=5;
    
    detailsTextView.layer.borderColor=[[UIColor redColor]CGColor];
    detailsTextView.layer.borderWidth=1.0;
    detailsTextView.layer.cornerRadius=5;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Retrieve user first name and last name to write to database
    [[self.uref childByAppendingPath:self.ref.authData.uid] observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *usnapshot) {
        self.fname = usnapshot.value[@"first_name"];
        self.lname = usnapshot.value[@"last_name"];
    }];
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearDesc:(id)sender {
    descTextField.text = @"";
}

- (IBAction)clearDetails:(id)sender {
    detailsTextView.text = @"";
}

- (IBAction)clearBoth:(id)sender {
    descTextField.text = @"";
    detailsTextView.text = @"";
}

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

- (void)resetBoth {
    self.descTextField.text = @"";
    self.detailsTextView.text = @"Enter additional details here.";
}

- (void)alert:(NSString *)title message:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
