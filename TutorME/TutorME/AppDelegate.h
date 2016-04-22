//
//  AppDelegate.h
//  TutorME
//
//  Created by Kriz Mayo on 2016-04-03.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AboutViewController.h"

// Max length for input fields
#define MAX_LENGTH_50 50
#define MAX_LENGTH_255 255
#define MAX_LENGTH_10 10
#define MAX_LENGTH_140 140

// Points for asking a question and answering a question
#define QUESTION_INC 2
#define ANSWER_INC 3

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LoginViewController *loginVC;

@end

