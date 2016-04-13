//
//  QuestionViewController.m
//  TutorME
//
//  Created by kmayo on 2016-04-12.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import "QuestionViewController.h"
#import "AppDelegate.h"

@interface QuestionViewController ()
@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) Firebase *qref;
@property (strong, nonatomic) Firebase *aref;
@property (strong, nonatomic) Firebase *uref;
@property (strong, nonatomic) Firebase *uscoreref;

@property (strong, nonatomic) NSString *fname;
@property (strong, nonatomic) NSString *lname;
@end

@implementation QuestionViewController
@synthesize descTextView, detailsTextView, submittedByLbl, dateSubmittedLbl, ansTextView, activity, tapper, qid;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize Firebase refs
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
    self.qref = [self.ref childByAppendingPath:[@"questions/" stringByAppendingString:self.qid]];
    self.aref = [self.ref childByAppendingPath:@"answers"];
    self.uref = [self.ref childByAppendingPath:@"users"];
    self.uscoreref = [self.uref childByAppendingPath:[self.ref.authData.uid stringByAppendingString:@"/score"]];
    
    // Initialize Gesture Recognizer
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Retrieve question - description, details, submitted by, and submission date
    [self.qref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *qsnapshot) {
        self.descTextView.text = qsnapshot.value[@"description"];
        self.detailsTextView.text = qsnapshot.value[@"details"];
        self.submittedByLbl.text = [@"Submitted By: " stringByAppendingString:qsnapshot.value[@"submitted_by_name"]];
        self.dateSubmittedLbl.text = [@"Date Submitted: " stringByAppendingString:qsnapshot.value[@"submission_date"]];
    }];
    
    // Retrieve user first name and last name to write to database
    [[self.uref childByAppendingPath:self.ref.authData.uid] observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *usnapshot) {
        self.fname = usnapshot.value[@"first_name"];
        self.lname = usnapshot.value[@"last_name"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearAnswer:(id)sender {
    self.ansTextView.text = @"";
}

- (void)resetAnswer{
    self.ansTextView.text = @"Enter your answer here...";
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (IBAction)post:(id)sender {
    NSString *msg = @"";
    
    if ([self.ansTextView.text containsString:@"Enter your answer here"] || [self.ansTextView.text isEqualToString:@""]) {
        msg = @"Please enter your answer.";
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
        
        // The answer
        NSDictionary *answer = @{
                                 @"details" : self.ansTextView.text,
                                 @"submitted_by_name" : fullName,
                                 @"question_id" : self.qid,
                                 @"submitted_by_id" : self.ref.authData.uid,
                                 @"submission_date" : dateSubmitted
                                 };
        
        // Start Activity Indicator
        [self.activity setHidden:NO];
        [self.activity startAnimating];
        
        
        // Firebase method for adding to the database - creates a new child for "questions" node
        [[self.aref childByAutoId] setValue:answer withCompletionBlock:^(NSError *error, Firebase *ref) {
            
            NSString *msg = @"";
            
            if (error) {
                msg = @"The answer could not be saved. Try again";
                [self alert:@"ERROR" message:msg];
            } else {
                
                // Update the score of the user for posting an answer - Firebase method
                [self.uscoreref runTransactionBlock:^FTransactionResult *(FMutableData *currentData) {
                    NSNumber *value = currentData.value;
                    if (currentData.value == [NSNull null]) {
                        value = 0;
                    }
                    [currentData setValue:[NSNumber numberWithInt:(ANSWER_INC + [value intValue])]];
                    return [FTransactionResult successWithValue:currentData];
                }];
                
            }
            
            // Stop Activity Indicator
            [self.activity setHidden:YES];
            [self.activity stopAnimating];
            
            // Success message
            msg = @"The answer was saved successfully. Thank you.";
            [self alert:@"SUCCESS" message:msg];
            
            [self resetAnswer];
        }];
    }
}

- (void)alert:(NSString *)title message:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
