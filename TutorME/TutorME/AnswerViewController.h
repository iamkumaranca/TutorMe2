//
//  AnswerViewController.h
//  TutorME
//
//  Created by Kriz Mayo on 2016-04-21.
//

#import <UIKit/UIKit.h>

@interface AnswerViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *ansTableView;
    NSMutableArray *ansList;
    NSMutableArray *nameList;
    NSMutableArray *dateList;
    NSString *qid;
}
@property (strong, nonatomic) IBOutlet UITableView *ansTableView;
@property (strong, nonatomic) NSMutableArray *ansList;
@property (strong, nonatomic) NSMutableArray *nameList;
@property (strong, nonatomic) NSMutableArray *dateList;
@property (strong, nonatomic) NSString *qid;
@end
