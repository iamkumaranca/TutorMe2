//
//  PageFViewController.h
//  TutorME
//
//  Created by Keith Lu on 2016-04-17.
//

#import <UIKit/UIKit.h>

@interface PageFViewController : UIViewController<UIWebViewDelegate>{
    IBOutlet UIWebView *wbPage;
    IBOutlet UIActivityIndicatorView *activity;
}

@property (nonatomic, strong) IBOutlet UIWebView *wbPage;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activity;

@end
