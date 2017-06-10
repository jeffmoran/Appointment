#import <UIKit/UIKit.h>
#import "RNGridMenu.h"
#import "Appointment.h"
#import "AppointmentDetailTableViewCell.h"

@import Contacts;
@import EventKit;
@import MessageUI;

@interface AppointmentDetailViewController : UITableViewController <MFMailComposeViewControllerDelegate, RNGridMenuDelegate>

@property (nonatomic, strong) Appointment *appointment;

@property (nonatomic, strong) NSString *calendarNotesString;
@property (nonatomic, strong) NSString *emailBodyString;

@end
