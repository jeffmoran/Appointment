#import <UIKit/UIKit.h>
#import "RNGridMenu.h"
#import "AppointmentDetailTableViewCell.h"
#import "ContactHandler.h"
#import "CalendarEventHandler.h"
#import <MessageUI/MessageUI.h>

@interface AppointmentDetailViewController : UITableViewController <MFMailComposeViewControllerDelegate, RNGridMenuDelegate>

@property (nonatomic, strong) Appointment *appointment;

@end
