//
//  ScoreViewController.h
//  TutorME
//
//  Created by Jimmy Lin on 2016-04-04.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface ScoreViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *nameList;
    NSMutableArray *schoolList;
    NSMutableArray *scoreList;
    IBOutlet UITableView *scoreTableView;
}

@property (strong, nonatomic) NSMutableArray *nameList;
@property (strong, nonatomic) NSMutableArray *schoolList;
@property (strong, nonatomic) NSMutableArray *scoreList;
@property (strong, nonatomic) IBOutlet UITableView *scoreTableView;
@end
