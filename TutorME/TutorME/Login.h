//
//  Login.h
//  TutorME
//
//  Created by Kumaran Sathianathan on 2016-04-04.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject
{
    NSString *email;
    NSString *password;
}

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;

- (id)initWithData:(NSString *)e password:(NSString *)p;
- (BOOL)isEmailEmpty;
- (BOOL)isPasswordEmpty;

@end
