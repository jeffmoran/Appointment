#import <UIKit/UIKit.h>
#import "RNGridMenu.h"
#import "Appointment.h"
#import "AppointmentDetailTableViewCell.h"

@import Contacts;
@import EventKit;
@import MessageUI;

@interface AppointmentDetailViewController : UITableViewController <MFMailComposeViewControllerDelegate, RNGridMenuDelegate>

@property (nonatomic, strong) Appointment *appointment;

@end
