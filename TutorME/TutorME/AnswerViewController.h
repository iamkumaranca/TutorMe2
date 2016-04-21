//
//  AnswerViewController.h
//  TutorME
//
//  Created by kmayo on 2016-04-21.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *ansTableView;
    NSMutableArray *ansList;
    NSString *qid;
}
@property (strong, nonatomic) IBOutlet UITableView *ansTableView;
@property (strong, nonatomic) NSMutableArray *ansList;
@property (strong, nonatomic) NSString *qid;
@end
