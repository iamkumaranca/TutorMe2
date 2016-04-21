//
//  QuestionTableViewCell.h
//  TutorME
//
//  Created by kmayo on 2016-04-12.
//  Copyright © 2016 kmayo. All rights reserved.
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
