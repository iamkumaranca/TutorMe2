//
//  QuestionViewController.h
//  TutorME
//
//  Created by Kriz Mayo on 2016-04-12.
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
    IBOutlet UIButton *facebook;
    IBOutlet UIButton *twitter;
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
@property (strong, nonatomic) IBOutlet UIButton *facebook;
@property (strong, nonatomic) IBOutlet UIButton *twitter;
@property (strong, nonatomic) NSMutableArray *ansList;

@end
