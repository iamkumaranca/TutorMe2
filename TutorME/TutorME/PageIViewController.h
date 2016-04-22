//
//  PageIViewController.h
//  TutorME
//
//  Created by Kumaran Sathianathan on 2016-04-21.
//

#import <UIKit/UIKit.h>

@interface PageIViewController : UIViewController<UIWebViewDelegate>{
    IBOutlet UIWebView *wbPage;
    IBOutlet UIActivityIndicatorView *activity;
}

@property (nonatomic, strong) IBOutlet UIWebView *wbPage;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activity;

@end
