//
//  NewQuestion.h
//  TutorME
//
//  Created by kmayo on 2016-04-05.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewQuestion : NSObject
{
    NSString *desc;
    NSString *details;
}

@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *details;

- (id)initWithData:(NSString *)desc details:(NSString *)d;

- (BOOL)isDescEmpty;
- (BOOL)isDetailsEmpty;

@end
