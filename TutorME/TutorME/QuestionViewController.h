//
//  QuestionViewController.h
//  TutorME
//
//  Created by kmayo on 2016-04-12.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface QuestionViewController : UIViewController <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITextView *descTextView;
    IBOutlet UITextView *detailsTextView;
    IBOutlet UITextView *ansTextView;
    IBOutlet UIActivityIndicatorView  *activity;
    IBOutlet UITableView *ansTableView;
    NSMutableArray *ansList;
    UIGestureRecognizer *tapper;
    NSString *qid;
}

@property (strong, nonatomic) IBOutlet UITextView *descTextView;
@property (strong, nonatomic) IBOutlet UITextView *detailsTextView;
@property (strong, nonatomic) IBOutlet UITextView *ansTextView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView  *activity;
@property (strong, nonatomic) IBOutlet UITableView *ansTableView;
@property (strong, nonatomic) NSMutableArray *ansList;
@property (strong, nonatomic) UIGestureRecognizer *tapper;
@property (strong, nonatomic) NSString *qid;

@end
