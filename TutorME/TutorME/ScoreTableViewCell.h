//
//  ScoreTableViewCell.h
//  TutorME
//
//  Created by kmayo on 2016-04-05.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreTableViewCell : UITableViewCell
{
    UILabel *nameLbl;
    UILabel *schoolLbl;
    UILabel *scoreLbl;
}

@property (strong, nonatomic) UILabel *nameLbl;
@property (strong, nonatomic) UILabel *schoolLbl;
@property (strong, nonatomic) UILabel *scoreLbl;

@end
