//
//  HomeViewController.h
//  TutorME
//
//  Created by kmayo on 2016-04-04.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *qidList;
    NSMutableArray *descList;
    NSMutableArray *nameList;
    NSMutableArray *dateList;
    IBOutlet UITableView *homeTableView;
}

@property (strong, nonatomic) NSMutableArray *qidList;
@property (strong, nonatomic) NSMutableArray *descList;
@property (strong, nonatomic) NSMutableArray *nameList;
@property (strong, nonatomic) NSMutableArray *dateList;
@property (strong, nonatomic) IBOutlet UITableView *homeTableView;

@end
