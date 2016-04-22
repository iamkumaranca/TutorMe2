//
//  QuestionViewController.h
//  TutorME
//
//  Created by kmayo on 2016-04-12.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import <Social/Social.h>
#import "AnswerViewController.h"

@interface QuestionViewController : UITableViewController <UITextViewDelegate>
{
    IBOutlet UITextView *questionTextView;
    IBOutlet UITextView *ansTextView;
    IBOutlet UIButton *viewBtn;
    IBOutlet UIButton *clearBtn;
    IBOutlet UIButton *submitBtn;
    IBOutlet UIActivityIndicatorView *activity;
    UIGestureRecognizer *tapper;
    NSString *qid;
    NSMutableArray *ansList;
}

@property (strong, nonatomic) IBOutlet UITextView *questionTextView;
@property (strong, nonatomic) IBOutlet UITextView *ansTextView;
@property (strong, nonatomic) IBOutlet UIButton *viewBtn;
@property (strong, nonatomic) IBOutlet UIButton *clearBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIGestureRecognizer *tapper;
@property (strong, nonatomic) NSString *qid;
@property (strong, nonatomic) NSMutableArray *ansList;

@end
