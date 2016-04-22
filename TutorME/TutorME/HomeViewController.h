//
//  HomeViewController.h
//  TutorME
//
//  Created by Kriz Mayo on 2016-04-04.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import "QuestionViewController.h"

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *qidList;
    NSMutableArray *descList;
    NSMutableArray *detailsList;
    NSMutableArray *nameList;
    NSMutableArray *dateList;
    IBOutlet UITableView *homeTableView;
}

@property (strong, nonatomic) NSMutableArray *qidList;
@property (strong, nonatomic) NSMutableArray *descList;
@property (strong, nonatomic) NSMutableArray *detailsList;
@property (strong, nonatomic) NSMutableArray *nameList;
@property (strong, nonatomic) NSMutableArray *dateList;
@property (strong, nonatomic) IBOutlet UITableView *homeTableView;

@end
