//
//  AnswerViewController.m
//  TutorME
//
//  Created by Kriz Mayo on 2016-04-21.
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

#pragma marks View Methods
// Initialization of arrays and firebase methods are completed when the view loads
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize Firebase refs
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
    self.aref = [self.ref childByAppendingPath:@"answers"];
    
    // Initialize Array
    self.ansList = [[NSMutableArray alloc] init];
    self.nameList = [[NSMutableArray alloc] init];
    self.dateList = [[NSMutableArray alloc] init];
}

// Remove Firebase handle and all objects in data arrays when the view disappears
// Removing the Firebase handle in this method is recommended by Firebase
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.ansList removeAllObjects];
    [self.nameList removeAllObjects];
    [self.dateList removeAllObjects];
    
    [self.aref removeObserverWithHandle:self.ahandle];
}

// When the view is about to appear, the database is queried to find any answers for the particular question
// being viewed by the user, if any. A firebase data retrieval method was used to accomplish this task.
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

#pragma mark TableView Methods

// The following methods are as taught in class for creating custom UITableViewCells.
// The definition of the custom UITableViewCell is in the AnswerTableViewCell class.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSArray *ansDetails = @[
                            [self.ansList objectAtIndex:row],
                            [@"Answered by " stringByAppendingFormat:@"%@\nOn %@", [self.nameList objectAtIndex:row], [self.dateList objectAtIndex:row]]
                            ];
    NSString *msg = [ansDetails componentsJoinedByString:@"\n\n"];
    [self alert:@"Answer" message:msg];
}

#pragma mark Alert methods
// A simple alert dialog that displays the content of the answer. This was required to display all content entered
// by a user as some of the info is cut off on the UITableViewCell in scenarios where a user enters a lot of text.
- (void)alert:(NSString *)title message:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark Navigation methods
// A method to transition back to the QuestionViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
