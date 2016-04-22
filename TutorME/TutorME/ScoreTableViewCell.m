//
//  ScoreTableViewCell.m
//  TutorME
//
//  Created by Jimmy Lin on 2016-04-05.
//

#import "ScoreTableViewCell.h"

@implementation ScoreTableViewCell
@synthesize nameLbl, schoolLbl, scoreLbl;

// A method to initialize the UITableViewCell for the ScoreViewController
// Formats the three UILabels contained in the UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    
        nameLbl = [[UILabel alloc] init];
        schoolLbl = [[UILabel alloc] init];
        scoreLbl = [[UILabel alloc] init];
        
        nameLbl.textAlignment = NSTextAlignmentLeft;
        nameLbl.textColor = [UIColor blackColor];
        nameLbl.font = [UIFont fontWithName:@"GillSans-Bold" size:14.0f];
        schoolLbl.textAlignment = NSTextAlignmentLeft;
        schoolLbl.textColor = [UIColor blackColor];
        schoolLbl.font = [UIFont fontWithName:@"GillSans-Italic" size:12.0f];
        scoreLbl.textAlignment = NSTextAlignmentCenter;
        scoreLbl.layer.masksToBounds = YES;
        scoreLbl.layer.cornerRadius = 25;
        scoreLbl.backgroundColor = [UIColor redColor];
        scoreLbl.textColor = [UIColor whiteColor];
        scoreLbl.font = [UIFont fontWithName:@"GillSans-Bold" size:20.0f];
        
        [self.contentView addSubview:nameLbl];
        [self.contentView addSubview:schoolLbl];
        [self.contentView addSubview:scoreLbl];
    }
    
    return self;
}

// A method for positioning and sizing the UILabels on the UITableViewCell
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame;
        
    frame = CGRectMake(15, 10, 50, 50);
    scoreLbl.frame = frame;
        
    frame = CGRectMake(80, 10, 240, 20);
    nameLbl.frame = frame;
        
    frame = CGRectMake(80, 40, 240, 20);
    schoolLbl.frame = frame;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
