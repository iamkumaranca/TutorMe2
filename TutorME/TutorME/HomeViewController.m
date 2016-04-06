//
//  HomeViewController.m
//  TutorME
//
//  Created by kmayo on 2016-04-04.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"

@interface HomeViewController ()
@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) Firebase *qref;
@property (strong, nonatomic) Firebase *uref;
@end

@implementation HomeViewController
@synthesize descList, nameList, dateList, homeTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.homeTableView.dataSource = self;
    self.homeTableView.delegate = self;
    
    // Initialize Firebase reference
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
    self.qref = [self.ref childByAppendingPath:@"questions"];
    self.uref = [self.ref childByAppendingPath:@"users"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //NSLog(@"User Logged In with UID||%@", self.ref.authData.uid);
    
    // Initialize arrays
    self.descList = [[NSMutableArray alloc] init];
    self.nameList = [[NSMutableArray alloc] init];
    self.dateList = [[NSMutableArray alloc] init];
    
    // Retrieve question details from the database
    [[self.qref queryOrderedByChild:@"submission_date"] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {

        // Save in array so score is in descending order
        [self.descList insertObject:snapshot.value[@"description"] atIndex:0];
        [self.nameList insertObject:[@"Submitted by: " stringByAppendingString:snapshot.value[@"submitted_by"]] atIndex:0];
        [self.dateList insertObject:[@"Date submitted: " stringByAppendingString:snapshot.value[@"submission_date"]] atIndex:0];
        [self.homeTableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.descList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"cell";
    
    HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSInteger row = indexPath.row;
    cell.descLbl.text = [self.descList objectAtIndex:row];
    cell.nameLbl.text = [self.nameList objectAtIndex:row];
    cell.dateLbl.text = [self.dateList objectAtIndex:row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
    // Firebase logout
    [self.ref unauth];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *loginTBC = [sb instantiateViewControllerWithIdentifier:@"loginTBC"];
    [loginTBC setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:loginTBC animated:YES completion:nil];
}

@end
