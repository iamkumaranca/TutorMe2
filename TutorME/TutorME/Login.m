//
//  Login.m
//  TutorME
//
//  Created by Kumaran Sathianathan on 2016-04-04.
//

#import "Login.h"

@implementation Login
@synthesize email, password;

- (id)initWithData:(NSString *)e password:(NSString *)p {
    if(self = [super init])
    {
        [self setEmail:e];
        [self setPassword:p];
    }
    return self;
}

- (BOOL)isEmailEmpty {
    BOOL empty = YES;
    if (![self.email isEqualToString: @""])
        empty = NO;
    return empty;
}

- (BOOL)isPasswordEmpty {
    BOOL empty = YES;
    if (![self.password isEqualToString: @""])
        empty = NO;
    return empty;
}

@end
