//
//  NewQuestion.h
//  TutorME
//
//  Created by Kumaran Sathianathan on 2016-04-05.
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
