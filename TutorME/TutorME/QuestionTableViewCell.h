//
//  QuestionTableViewCell.h
//  TutorME
//
//  Created by kmayo on 2016-04-12.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTableViewCell : UITableViewCell
{
    UITextView *ansTextView;
}

@property (strong, nonatomic) UITextView *ansTextView;

@end
