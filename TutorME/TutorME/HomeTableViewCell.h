//
//  HomeTableViewCell.h
//  TutorME
//
//  Created by kmayo on 2016-04-05.
//  Copyright © 2016 kmayo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell
{
    UILabel *descLbl;
    UILabel *detailsLbl;
    UILabel *nameLbl;
    UILabel *dateLbl;
}

@property (strong, nonatomic) UILabel *descLbl;
@property (strong, nonatomic) UILabel *detailsLbl;
@property (strong, nonatomic) UILabel *nameLbl;
@property (strong, nonatomic) UILabel *dateLbl;

@end
