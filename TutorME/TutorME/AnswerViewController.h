//
//  AnswerViewController.h
//  TutorME
//
//  Created by kmayo on 2016-04-21.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *ansList;
}
@property (strong, nonatomic) NSMutableArray *ansList;
@end
