//
//  Login.h
//  TutorME
//
//  Created by kmayo on 2016-04-04.
//  Copyright © 2016 kmayo. All rights reserved.
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
