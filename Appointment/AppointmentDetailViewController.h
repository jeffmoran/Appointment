#import <UIKit/UIKit.h>
#import "AppointmentDetailTableViewCell.h"
#import "ContactHandler.h"
#import "CalendarEventHandler.h"
#import <MessageUI/MessageUI.h>

@interface AppointmentDetailViewController : UITableViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) Appointment *appointment;

@end
