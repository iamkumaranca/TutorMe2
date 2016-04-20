//
//  NewQuestionViewController.h
//  TutorME
//
//  Created by kmayo on 2016-04-04.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import "NewQuestion.h"

@interface NewQuestionViewController : UITableViewController <UITextViewDelegate>
{
    IBOutlet UITextField *descTextField;
    IBOutlet UITextView *detailsTextView;
    IBOutlet UIButton *clearBtn;
    IBOutlet UIButton *submitBtn;
    NewQuestion *nq;
    IBOutlet UIActivityIndicatorView *activity;
    UIGestureRecognizer *tapper;
}

@property (strong, nonatomic) IBOutlet UITextField *descTextField;
@property (strong, nonatomic) IBOutlet UITextView *detailsTextView;
@property (strong, nonatomic) NewQuestion *nq;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIGestureRecognizer *tapper;
@property (strong, nonatomic) IBOutlet UIButton *clearBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;

@end
