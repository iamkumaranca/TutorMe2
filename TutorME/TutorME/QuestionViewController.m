//
//  QuestionViewController.m
//  TutorME
//
//  Created by kmayo on 2016-04-12.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()
@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) Firebase *qref;
@end

@implementation QuestionViewController
@synthesize descLbl, detailsTextView, submittedByLbl, dateSubmittedLbl, qid;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize Firebase refs
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
    self.qref = [self.ref childByAppendingPath:[@"questions/" stringByAppendingString:self.qid]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Initialize description and details label
    self.descLbl.numberOfLines = 0;
    [self.descLbl sizeToFit];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.qref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *qsnapshot) {
        self.descLbl.text = qsnapshot.value[@"description"];
        self.detailsTextView.text = qsnapshot.value[@"details"];
        self.submittedByLbl.text = [@"Submitted By: " stringByAppendingString:qsnapshot.value[@"submitted_by_name"]];
        self.dateSubmittedLbl.text = [@"Date Submitted: " stringByAppendingString:qsnapshot.value[@"submission_date"]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
