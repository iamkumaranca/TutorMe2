//
//  QuestionTableViewCell.h
//  TutorME
//
//  Created by Kriz Mayo on 2016-04-12.
//

#import <UIKit/UIKit.h>

@interface AnswerTableViewCell : UITableViewCell
{
    UILabel *ansLbl;
    UILabel *nameLbl;
    UILabel *dateLbl;
}

@property (strong, nonatomic) UILabel *ansLbl;
@property (strong, nonatomic) UILabel *nameLbl;
@property (strong, nonatomic) UILabel *dateLbl;

@end
