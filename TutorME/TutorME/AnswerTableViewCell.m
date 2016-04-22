//
//  QuestionTableViewCell.m
//  TutorME
//
//  Created by Kriz Mayo on 2016-04-12.
//

#import "AnswerTableViewCell.h"

@implementation AnswerTableViewCell
@synthesize ansLbl, nameLbl, dateLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        ansLbl = [[UILabel alloc] init];
        nameLbl = [[UILabel alloc] init];
        dateLbl = [[UILabel alloc] init];
        
        ansLbl.textAlignment = NSTextAlignmentLeft;
        ansLbl.textColor = [UIColor blackColor];
        ansLbl.font = [UIFont fontWithName:@"GillSans" size:14.0f];
        ansLbl.lineBreakMode = NSLineBreakByWordWrapping;
        ansLbl.numberOfLines = 0;
        [ansLbl sizeToFit];
        
        nameLbl.textAlignment = NSTextAlignmentRight;
        nameLbl.textColor = [UIColor grayColor];
        nameLbl.font = [UIFont fontWithName:@"GillSans-Italic" size:12.0f];
        
        dateLbl.textAlignment = NSTextAlignmentRight;
        dateLbl.textColor = [UIColor grayColor];
        dateLbl.font = [UIFont fontWithName:@"GillSans-Italic" size:12.0f];
        
        [self.contentView addSubview:ansLbl];
        [self.contentView addSubview:nameLbl];
        [self.contentView addSubview:dateLbl];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame;
    
    frame = CGRectMake(20, 5, 270, 60);
    ansLbl.frame = frame;
    
    frame = CGRectMake(20, 70, 270, 15);
    nameLbl.frame = frame;
    
    frame = CGRectMake(20, 85, 270, 15);
    dateLbl.frame = frame;
}

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
