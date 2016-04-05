//
//  ProfileViewController.m
//  TutorME
//
//  Created by kmayo on 2016-04-04.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) Firebase *userRef;
@end

@implementation ProfileViewController
@synthesize fnameLbl, lnameLbl, schoolLbl, programLbl, yearLbl, scoreLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize Firebase reference
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
    // Points to the JSON tree node "users" with child "uid"
    self.userRef = [[self.ref childByAppendingPath:@"users"] childByAppendingPath:self.ref.authData.uid];
}

- (void)viewWillAppear:(BOOL)animated {
    // Retrieve user details data - Firebase method
    [self.userRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        fnameLbl.text = snapshot.value[@"first_name"];
        lnameLbl.text = snapshot.value[@"last_name"];
        schoolLbl.text = snapshot.value[@"school"];
        programLbl.text = snapshot.value[@"program"];
        yearLbl.text = snapshot.value[@"year"];
        scoreLbl.text = [snapshot.value[@"score"] stringValue];
    }];
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
