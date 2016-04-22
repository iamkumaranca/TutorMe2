//
//  QuestionViewController.m
//  TutorME
//
//  Created by Kriz Mayo on 2016-04-12.
//

#import "QuestionViewController.h"
#import "AppDelegate.h"
#import "Styles.h"

@interface QuestionViewController ()
@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) Firebase *qref;
@property (strong, nonatomic) Firebase *aref;
@property (strong, nonatomic) Firebase *uref;
@property (strong, nonatomic) Firebase *uscoreref;
@property FirebaseHandle ahandle;
@property (strong, nonatomic) Styles *styles;

@property (strong, nonatomic) NSString *fname;
@property (strong, nonatomic) NSString *lname;
@end

@implementation QuestionViewController

@synthesize questionTextView, ansTextView, viewBtn, clearBtn, submitBtn, activity, tapper, qid, facebook, twitter, ansList;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initialize Firebase refs
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
    self.qref = [self.ref childByAppendingPath:[@"questions/" stringByAppendingString:self.qid]];
    self.aref = [self.ref childByAppendingPath:@"answers"];
    self.uref = [self.ref childByAppendingPath:@"users"];
    self.uscoreref = [self.uref childByAppendingPath:[self.ref.authData.uid stringByAppendingString:@"/score"]];

    // Initialize Styles class
    self.styles = [[Styles alloc] init];

    // Initialize Gesture Recognizer
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];


    // Initialize Border
    [Styles textViewStyle:questionTextView];
    [Styles textViewStyle:ansTextView];

    [Styles buttonStyle:viewBtn];
    [Styles buttonStyle:submitBtn];
    [Styles buttonStyle:clearBtn];

    [Styles fontIconButton:facebook icon:@"\uF082"];
    [Styles fontIconButton:twitter icon:@"\uF081"];

    //[Styles fontIcon:facebook icon:[NSString stringWithUTF8String:"\uF230"]];
    //[Styles fontIcon:twitter icon:[NSString stringWithUTF8String:"\uF081"]];

    // Iniatilize navigation bar
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont fontWithName:@"GillSans-Bold" size:20.0]
                                                                      }];
    // Initialize Activity Indicator
    [self.activity setHidden:YES];
    [self.activity stopAnimating];

    self.ansList = [[NSMutableArray alloc] init];


}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.ansList removeAllObjects];

    [self.aref removeObserverWithHandle:self.ahandle];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // Retrieve question - description, details, submitted by, and submission date
    [self.qref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *qsnapshot) {

        NSArray *qdetails = @[
                              qsnapshot.value[@"description"],
                              qsnapshot.value[@"details"],
                              [@"Asked by " stringByAppendingFormat:@"%@\nOn %@", qsnapshot.value[@"submitted_by_name"], qsnapshot.value[@"submission_date"]]
                              ];

        self.questionTextView.text = [qdetails componentsJoinedByString:@"\n\n"];

    }];

    // Retrieve user first name and last name to write to database
    [[self.uref childByAppendingPath:self.ref.authData.uid] observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *usnapshot) {
        self.fname = usnapshot.value[@"first_name"];
        self.lname = usnapshot.value[@"last_name"];
    }];

    // Retrieve answers list if any
    self.ahandle = [[self.aref queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *asnapshot) {

        if (asnapshot.value != [NSNull null]) {
            if ([asnapshot.value[@"question_id"] isEqualToString:self.qid]) {
                [self.ansList insertObject:asnapshot.value[@"details"] atIndex:0];
            }
        }

        if ([self.ansList count] > 0) {
            [self.viewBtn setTitle:@"View Answers" forState:UIControlStateNormal];
            [self.viewBtn setEnabled:YES];
        } else {
            [self.viewBtn setTitle:@"Not Answered" forState:UIControlStateNormal];
            [self.viewBtn setEnabled:NO];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)viewAnswers:(id)sender {
    // Go to Question screen (UINavigationController)
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *answerNC = [sb instantiateViewControllerWithIdentifier:@"answerNC"];

    // Pass the qid to the Question View Controller
    AnswerViewController *answerVC = (AnswerViewController *)[answerNC topViewController];
    answerVC.qid = self.qid;

    [answerNC setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:answerNC animated:YES completion:nil];
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

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView.text.length >= MAX_LENGTH_255 && range.length == 0) {
        return NO; // Change not allowed
    } else {
        return YES; // Change allowed
    }
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


        // Firebase method for adding to the database - creates a new child for "answers" node
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

#pragma mark Social Media methods

- (IBAction)postQuestionToFacebook:(id)sender {

    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebookSLCVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];

        NSArray *questionDetails = @[
                                     @"This question was asked on the TutorMe iOS app.",
                                     self.questionTextView.text
                                     ];
        [facebookSLCVC setInitialText:[questionDetails componentsJoinedByString:@"\n\n"]];
        [self presentViewController:facebookSLCVC animated:YES completion:nil];
    } else {
        [self alert:@"ERROR" message:@"Facebook service is not available"];
    }

}

- (IBAction)postQuestionToTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *twitterSLCVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];

        NSArray *questionDetails = @[
                                     @"This question was asked on the TutorMe iOS app.",
                                     self.questionTextView.text
                                     ];
        [twitterSLCVC setInitialText:[questionDetails componentsJoinedByString:@"\n"]];
        [self presentViewController:twitterSLCVC animated:YES completion:nil];
    } else {
        [self alert:@"ERROR" message:@"Twitter service is not available"];
    }
}


@end
