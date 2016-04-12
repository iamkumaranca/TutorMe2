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
    IBOutlet UILabel *descLbl;
    IBOutlet UILabel *detailsLbl;
}

@property (strong, nonatomic) IBOutlet UILabel *descLbl;
@property (strong, nonatomic) IBOutlet UILabel *detailsLbl;

@end
