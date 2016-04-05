//
//  Registration.m
//  TutorME
//
//  Created by kmayo on 2016-04-04.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import "Registration.h"

@implementation Registration
@synthesize fname, lname, school, program, year, email, password, confirm;

- (id)initWithData:(NSString *)fn lname:(NSString *)ln school:(NSString *)s program:(NSString *)pr year:(NSString *)y email:(NSString *)e password:(NSString *)pw confirm:(NSString *)cpw {
    if(self = [super init])
    {
        [self setFname:fn];
        [self setLname:ln];
        [self setSchool:s];
        [self setProgram:pr];
        [self setYear:y];
        [self setEmail:e];
        [self setPassword:pw];
        [self setConfirm:cpw];
    }
    return self;
}

- (BOOL)isCompleted {
    BOOL completed = YES;
    if ([self.fname  isEqualToString: @""] || [self.lname  isEqualToString: @""] || [self.school  isEqualToString: @""] || [self.program  isEqualToString: @""] || [self.email  isEqualToString: @""] || [self.password  isEqualToString: @""] || [self.confirm  isEqualToString: @""]) {
        completed = NO;
    }
    return completed;
}
- (BOOL)isValidEmail {
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self.email];
}
- (BOOL)isConfirmedPassword {
    BOOL confirmed = NO;
    if ([self.password isEqualToString:self.confirm]) {
        confirmed = YES;
    }
    return confirmed;
}

@end
