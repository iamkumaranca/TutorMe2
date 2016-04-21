//
//  AnswerViewController.m
//  TutorME
//
//  Created by kmayo on 2016-04-21.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import "AnswerViewController.h"
#import "QuestionTableViewCell.h"
#import "AppDelegate.h"

@interface AnswerViewController ()
@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) Firebase *aref;
@property FirebaseHandle ahandle;
@end

@implementation AnswerViewController
@synthesize ansList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize Firebase refs
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
    self.aref = [self.ref childByAppendingPath:@"answers"];
    
    // Initialize Array
    self.ansList = [[NSMutableArray alloc] init];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.ansList removeAllObjects];
    
    //[self.aref removeObserverWithHandle:self.ahandle];
}

/*- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Retrieve answers list if any
    self.ahandle = [[self.aref queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *asnapshot) {
        
        if (asnapshot.value != [NSNull null]) {
            if ([asnapshot.value[@"question_id"] isEqualToString:self.qid]) {
                NSString *details = asnapshot.value[@"details"];
                NSString *submittedBy = asnapshot.value[@"submitted_by_name"];
                NSString *submissionDate = asnapshot.value[@"submission_date"];
                [self.ansList insertObject:[details stringByAppendingFormat:@" [%@ %@]", submittedBy, submissionDate] atIndex:0];
            }
        }
        
        [self.ansTableView reloadData];
    }];
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ansList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"cell";
    
    QuestionTableViewCell *cell = (QuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[QuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSInteger row = indexPath.row;
    cell.ansTextView.text = [self.ansList objectAtIndex:row];
    
    return cell;
}

@end
