//
//  NewQuestion.m
//  TutorME
//
//  Created by Kumaran Sathianathan on 2016-04-05.
//

#import "NewQuestion.h"

@implementation NewQuestion
@synthesize desc, details;

// A method to initialize a New Question object
- (id)initWithData:(NSString *)dsc details:(NSString *)dt {
    if(self = [super init])
    {
        [self setDesc:dsc];
        [self setDetails:dt];
    }
    return self;
}

// A method to check if the description field is empty
- (BOOL)isDescEmpty {
    BOOL empty = NO;
    if ([self.desc isEqualToString:@""])
        empty = YES;
    return empty;
}

// A method to check if the details field is empty
- (BOOL)isDetailsEmpty {
    BOOL empty = NO;
    if ([self.details isEqualToString:@""]) {
        empty = YES;
    }
    return empty;
}

@end
