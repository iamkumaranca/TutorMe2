//
//  PageTViewController.m
//  TutorME
//
//  Created by Kriz Mayo on 2016-04-21.
//

#import "PageTViewController.h"

@interface PageTViewController ()

@end

@implementation PageTViewController
@synthesize wbPage, activity;

//Show activity when openning website
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [activity setHidden:NO];
    [activity startAnimating];
}

//Hide activity after website shown
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [activity setHidden:YES];
    [activity startAnimating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *urlAddress = [NSURL URLWithString:@"https://www.twitter.com"];
    NSURLRequest *url = [NSURLRequest requestWithURL:urlAddress];
    [wbPage loadRequest:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// A method to go back to the previous UIViewController
- (IBAction)exit:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
