//
//  Registration.h
//  TutorME
//
//  Created by Kumaran Sathianathan on 2016-04-04.
//

#import <Foundation/Foundation.h>

@interface Registration : NSObject
{
    NSString *fname;
    NSString *lname;
    NSString *school;
    NSString *program;
    NSString *year;
    NSString *email;
    NSString *password;
    NSString *confirm;
}

@property (strong, nonatomic) NSString *fname;
@property (strong, nonatomic) NSString *lname;
@property (strong, nonatomic) NSString *school;
@property (strong, nonatomic) NSString *program;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *confirm;

- (id)initWithData:(NSString *)fn lname:(NSString *)ln school:(NSString *)s program:(NSString *)pr year:(NSString *)y email:(NSString *)e password:(NSString *)pw confirm:(NSString *)cpw;

- (BOOL)isCompleted;
- (BOOL)isValidEmail;
- (BOOL)isConfirmedPassword;

@end
