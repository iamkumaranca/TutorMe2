//
//  ProfileViewController.h
//  TutorME
//
//  Created by Jimmy Lin on 2016-04-03.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface ProfileViewController : UITableViewController
{
    IBOutlet UILabel *fnameLbl;
    IBOutlet UILabel *lnameLbl;
    IBOutlet UILabel *schoolLbl;
    IBOutlet UILabel *programLbl;
    IBOutlet UILabel *yearLbl;
    IBOutlet UILabel *scoreLbl;
}

@property (strong, nonatomic) IBOutlet UILabel *fnameLbl;
@property (strong, nonatomic) IBOutlet UILabel *lnameLbl;
@property (strong, nonatomic) IBOutlet UILabel *schoolLbl;
@property (strong, nonatomic) IBOutlet UILabel *programLbl;
@property (strong, nonatomic) IBOutlet UILabel *yearLbl;
@property (strong, nonatomic) IBOutlet UILabel *scoreLbl;
@end
