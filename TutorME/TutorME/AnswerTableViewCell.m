//
//  QuestionTableViewCell.m
//  TutorME
//
//  Created by kmayo on 2016-04-12.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import "AnswerTableViewCell.h"

@implementation AnswerTableViewCell
@synthesize ansTextView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        ansTextView = [[UITextView alloc] init];
        
        ansTextView.editable = NO;
        ansTextView.textAlignment = NSTextAlignmentLeft;
        ansTextView.textColor = [UIColor blackColor];
        ansTextView.font = [UIFont fontWithName:@"GillSans" size:14.0f];
        
        [self.contentView addSubview:ansTextView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame;
    
    frame = CGRectMake(0, 0, 320, 60);
    ansTextView.frame = frame;
}

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
