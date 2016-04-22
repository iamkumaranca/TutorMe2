//
//  HomeTableViewCell.h
//  TutorME
//
//  Created by Kriz Mayo on 2016-04-05.
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
