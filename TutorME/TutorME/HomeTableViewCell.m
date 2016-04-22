//
//  HomeTableViewCell.m
//  TutorME
//
//  Created by Kriz Mayo on 2016-04-05.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell
@synthesize descLbl, detailsLbl, nameLbl, dateLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        descLbl = [[UILabel alloc] init];
        detailsLbl = [[UILabel alloc] init];
        nameLbl = [[UILabel alloc] init];
        dateLbl = [[UILabel alloc] init];
        
        descLbl.textAlignment = NSTextAlignmentLeft;
        descLbl.textColor = [UIColor blackColor];
        descLbl.font = [UIFont fontWithName:@"GillSans-Bold" size:18.0f];
        
        detailsLbl.textAlignment = NSTextAlignmentLeft;
        detailsLbl.textColor = [UIColor grayColor];
        detailsLbl.font = [UIFont fontWithName:@"GillSans" size:14.0f];
        detailsLbl.lineBreakMode = NSLineBreakByWordWrapping;
        detailsLbl.numberOfLines = 0;
        [detailsLbl sizeToFit];
        
        nameLbl.textAlignment = NSTextAlignmentRight;
        nameLbl.textColor = [UIColor grayColor];
        nameLbl.font = [UIFont fontWithName:@"GillSans-Italic" size:12.0f];
        
        dateLbl.textAlignment = NSTextAlignmentRight;
        dateLbl.textColor = [UIColor grayColor];
        dateLbl.font = [UIFont fontWithName:@"GillSans-Italic" size:12.0f];
        
        [self.contentView addSubview:descLbl];
        [self.contentView addSubview:detailsLbl];
        [self.contentView addSubview:nameLbl];
        [self.contentView addSubview:dateLbl];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame;
    
    frame = CGRectMake(10, 5, 270, 20);
    descLbl.frame = frame;
    
    frame = CGRectMake(10, 25, 270, 40);
    detailsLbl.frame = frame;
    
    frame = CGRectMake(10, 70, 270, 15);
    nameLbl.frame = frame;
    
    frame = CGRectMake(10, 85, 270, 15);
    dateLbl.frame = frame;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
