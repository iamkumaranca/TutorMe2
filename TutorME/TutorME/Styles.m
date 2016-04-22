//
//  Styles.m
//  TutorME
//
//  Created by Kumaran Sathianathan on 2016-04-21.
//

#import "Styles.h"

@implementation Styles

// Add borders to TextFields
+ (void)fieldStyle:(UITextField *)f
{
    f.layer.borderColor = [[UIColor grayColor]CGColor];
    f.layer.borderWidth = 2.0;
}

// Add borders to TextView
+ (void)textViewStyle:(UITextView *)t
{
    t.layer.borderColor = [[UIColor grayColor]CGColor];
    t.layer.borderWidth = 2.0;
}

// Add border to buttons
+ (void)buttonStyle:(UIButton *)b
{
    b.layer.borderColor = [[UIColor blackColor]CGColor];
    b.layer.borderWidth = 2.0;
    b.layer.cornerRadius = 5;
}

// Add custom FontAwesome icon to label
+ (void)fontIcon:(UILabel *)f icon:(NSString *)i
{
    [f setFont:[UIFont fontWithName:@"FontAwesome" size:17]];
    [f setText:i];
    f.textColor = [UIColor redColor];
}

// Add custom FontAwesome icon to button
+ (void)fontIconButton:(UIButton *)b icon:(NSString *)i
{
    b.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:50];
    [b setTitle:i forState:UIControlStateNormal];
}
@end
