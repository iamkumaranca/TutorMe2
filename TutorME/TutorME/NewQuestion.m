//
//  NewQuestion.m
//  TutorME
//
//  Created by Kumaran Sathianathan on 2016-04-05.
//

#import "NewQuestion.h"

@implementation NewQuestion
@synthesize desc, details;

- (id)initWithData:(NSString *)dsc details:(NSString *)dt {
    if(self = [super init])
    {
        [self setDesc:dsc];
        [self setDetails:dt];
    }
    return self;
}

- (BOOL)isDescEmpty {
    BOOL empty = NO;
    if ([self.desc isEqualToString:@""])
        empty = YES;
    return empty;
}

- (BOOL)isDetailsEmpty {
    BOOL empty = NO;
    if ([self.details isEqualToString:@""]) {
        empty = YES;
    }
    return empty;
}

@end
