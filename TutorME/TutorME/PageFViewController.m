//
//  PageFViewController.m
//  TutorME
//
//  Created by Keith Lu on 2016-04-17.
//

#import "PageFViewController.h"

@interface PageFViewController ()

@end

@implementation PageFViewController
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
    NSURL *urlAddress = [NSURL URLWithString:@"https://www.facebook.com"];
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
