//
//  Styles.h
//  TutorME
//
//  Created by Kumaran Sathianathan on 2016-04-21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Styles : NSObject

+ (void)fieldStyle:(UITextField *)f;
+ (void)textViewStyle:(UITextView *)t;
+ (void)buttonStyle:(UIButton *)b;
+ (void)fontIcon:(UILabel *)f icon:(NSString *)i;
+ (void)fontIconButton:(UIButton *)b icon:(NSString *)i;
@end
