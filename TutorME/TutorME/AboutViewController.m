//
//  AboutViewController.m
//  TutorME
//
//  Created by Keith Lu on 2016-04-03.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (strong, nonatomic) Firebase *ref;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize Firebase reference
    self.ref = [[Firebase alloc] initWithUrl:@"https://burning-heat-7302.firebaseio.com/"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
