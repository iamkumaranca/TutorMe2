//
//  PageFViewController.h
//  TutorME
//
//  Created by iOS Xcode User on 2016-04-17.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageFViewController : UIViewController{
    IBOutlet UIWebView *wbPage;
    IBOutlet UIActivityIndicatorView *activity;
}

@property (nonatomic, strong) IBOutlet UIWebView *wbPage;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activity;

@end