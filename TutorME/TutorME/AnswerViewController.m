//
//  AnswerViewController.m
//  TutorME
//
//  Created by kmayo on 2016-04-21.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerTableViewCell.h"
#import "AppDelegate.h"

@interface AnswerViewController ()
@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) Firebase *aref;
@property FirebaseHandle ahandle;
@end

@implementation AnswerViewController
@synthesize ansTableView, ansList, nameList, dateList, qid;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize Firebase refs
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
    self.aref = [self.ref childByAppendingPath:@"answers"];
    
    // Initialize Array
    self.ansList = [[NSMutableArray alloc] init];
    self.nameList = [[NSMutableArray alloc] init];
    self.dateList = [[NSMutableArray alloc] init];
    
    // Iniatilize navigation bar
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont fontWithName:@"GillSans-Bold" size:20.0]
                                                                      }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.ansList removeAllObjects];
    [self.nameList removeAllObjects];
    [self.dateList removeAllObjects];
    
    [self.aref removeObserverWithHandle:self.ahandle];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Retrieve answers list if any
    self.ahandle = [[self.aref queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *asnapshot) {
        
        if (asnapshot.value != [NSNull null]) {
            if ([asnapshot.value[@"question_id"] isEqualToString:self.qid]) {
                
                [self.ansList insertObject:asnapshot.value[@"details"] atIndex:0];
                [self.nameList insertObject:asnapshot.value[@"submitted_by_name"] atIndex:0];
                [self.dateList insertObject:asnapshot.value[@"submission_date"] atIndex:0];
            }
        }
        
        [self.ansTableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ansList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"cell";
    
    AnswerTableViewCell *cell = (AnswerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[AnswerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSInteger row = indexPath.row;
    cell.ansLbl.text = [self.ansList objectAtIndex:row];
    cell.nameLbl.text = [@"Submitted by: " stringByAppendingString:[self.nameList objectAtIndex:row]];
    cell.dateLbl.text = [@"Date Submitted: " stringByAppendingString:[self.dateList objectAtIndex:row]];
    
    return cell;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
