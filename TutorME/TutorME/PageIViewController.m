//
//  PageIViewController.m
//  TutorME
//
//  Created by iOS Xcode User on 2016-04-21.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import "PageIViewController.h"

@interface PageIViewController ()

@end

@implementation PageIViewController
@synthesize wbPage, activity;

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [activity setHidden:NO];
    [activity startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [activity setHidden:YES];
    [activity startAnimating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *urlAddress = [NSURL URLWithString:@"https://www.instagram.com"];
    NSURLRequest *url = [NSURLRequest requestWithURL:urlAddress];
    [wbPage loadRequest:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)exit:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
