//
//  Styles.m
//  TutorME
//
//  Created by Kumaran Sathianathan on 2016-04-21.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import "Styles.h"

@implementation Styles

+ (void)fieldStyle:(UITextField *)f
{
    f.layer.borderColor = [[UIColor redColor]CGColor];
    f.layer.borderWidth = 2.0;
    f.layer.cornerRadius = 5;
}

+ (void)textViewStyle:(UITextView *)t
{
    t.layer.borderColor = [[UIColor redColor]CGColor];
    t.layer.borderWidth = 2.0;
    t.layer.cornerRadius = 5;
}

+ (void)buttonStyle:(UIButton *)b
{
    b.layer.borderColor = [[UIColor blackColor]CGColor];
    b.layer.borderWidth = 2.0;
    b.layer.cornerRadius = 5;
}

+ (void)fontIcon:(UILabel *)f icon:(NSString *)i;
{
    [f setFont:[UIFont fontWithName:@"FontAwesome" size:17]];
    [f setText:i];
    f.textColor = [UIColor redColor];
}
@end
