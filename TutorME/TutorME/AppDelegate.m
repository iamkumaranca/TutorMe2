//
//  AppDelegate.m
//  TutorME
//
//  Created by kmayo on 2016-04-03.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window, loginVC;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont fontWithName:@"GillSans-Bold" size:20.0]
                                                           }];
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    [[UITabBar appearance] setTranslucent:NO];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
