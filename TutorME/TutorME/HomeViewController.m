//
//  HomeViewController.m
//  TutorME
//
//  Created by Kriz Mayo on 2016-04-04.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"

@interface HomeViewController ()
@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) Firebase *qref;
@property (strong, nonatomic) Firebase *uref;
@property FirebaseHandle qhandle;
@end

@implementation HomeViewController
@synthesize qidList, descList, detailsList, nameList, dateList, homeTableView;

// This method is for initializing the firebase refs and data arrays.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize Firebase reference
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
    self.qref = [self.ref childByAppendingPath:@"questions"];
    self.uref = [self.ref childByAppendingPath:@"users"];
    
    // Initialize arrays
    self.qidList = [[NSMutableArray alloc] init];
    self.descList = [[NSMutableArray alloc] init];
    self.detailsList = [[NSMutableArray alloc] init];
    self.nameList = [[NSMutableArray alloc] init];
    self.dateList = [[NSMutableArray alloc] init];
}

// This method is used to handle clean up. All objects from data array is removed and the Firebase handle is removed.
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.qidList removeAllObjects];
    [self.descList removeAllObjects];
    [self.detailsList removeAllObjects];
    [self.nameList removeAllObjects];
    [self.dateList removeAllObjects];

    [self.qref removeObserverWithHandle:self.qhandle];
}

// This method is used to retriveve question data from the database. The data is displayed in a UITableView so that
// the user can view all the questions.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.qhandle = [[self.qref queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *qsnapshot) {
                
        // Save in array so submission date is in descending order
        if (qsnapshot.value != [NSNull null]) {
            [self.qidList insertObject:qsnapshot.key atIndex:0];
            [self.descList insertObject:qsnapshot.value[@"description"] atIndex:0];
            [self.detailsList insertObject:qsnapshot.value[@"details"] atIndex:0];
            [self.nameList insertObject:qsnapshot.value[@"submitted_by_name"] atIndex:0];
            [self.dateList insertObject:qsnapshot.value[@"submission_date"] atIndex:0];
        }
        
        [self.homeTableView reloadData];
    }];
}

// Determine the number of rows required in the cell.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [qidList count];
}

// Set the height of the UITableView cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

// Load the question, detail, name and date into the cell.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"cell";
    
    HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSInteger row = indexPath.row;
    cell.descLbl.text = [self.descList objectAtIndex:row];
    cell.detailsLbl.text = [self.detailsList objectAtIndex:row];
    cell.nameLbl.text = [@"Submitted by: " stringByAppendingString:[self.nameList objectAtIndex:row]];
    cell.dateLbl.text = [@"Date Submitted: " stringByAppendingString:[self.dateList objectAtIndex:row]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

// This method will redirect the user to the QuestionViewController to show the question in more detail.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Go to Question screen (UINavigationController)
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *questionNC = [sb instantiateViewControllerWithIdentifier:@"questionNC"];
    
    // Pass the qid to the Question View Controller
    QuestionViewController *questionVC = (QuestionViewController *)[questionNC topViewController];
    questionVC.qid = [self.qidList objectAtIndex:indexPath.row];
    
    [questionNC setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:questionNC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// This method allows the user to logout of the app. It will kill the session with Firebase.
- (IBAction)logout:(id)sender {
    // Firebase logout
    [self.ref unauth];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *loginTBC = [sb instantiateViewControllerWithIdentifier:@"loginTBC"];
    [loginTBC setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:loginTBC animated:YES completion:nil];
}

@end
