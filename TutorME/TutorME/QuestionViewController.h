//
//  QuestionViewController.h
//  TutorME
//
//  Created by kmayo on 2016-04-12.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface QuestionViewController : UITableViewController <UITextViewDelegate>
{
    IBOutlet UITextView *descTextView;
    IBOutlet UITextView *detailsTextView;
    IBOutlet UILabel *submittedByLbl;
    IBOutlet UILabel *dateSubmittedLbl;
    IBOutlet UITextView *ansTextView;
    IBOutlet UIActivityIndicatorView  *activity;
    UIGestureRecognizer *tapper;
    NSString *qid;
}

@property (strong, nonatomic) IBOutlet UITextView *descTextView;
@property (strong, nonatomic) IBOutlet UITextView *detailsTextView;
@property (strong, nonatomic) IBOutlet UILabel *submittedByLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateSubmittedLbl;
@property (strong, nonatomic) IBOutlet UITextView *ansTextView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView  *activity;
@property (strong, nonatomic) UIGestureRecognizer *tapper;
@property (strong, nonatomic) NSString *qid;

@end
