//
//  PageGViewController.h
//  TutorME
//
//  Created by Jimmy Lin on 2016-04-21.
//

#import <UIKit/UIKit.h>

@interface PageGViewController : UIViewController<UIWebViewDelegate>{
    IBOutlet UIWebView *wbPage;
    IBOutlet UIActivityIndicatorView *activity;
}

@property (nonatomic, strong) IBOutlet UIWebView *wbPage;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activity;

@end
