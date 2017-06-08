#import <UIKit/UIKit.h>
#import <TapkuLibrary/TapkuLibrary.h>
#import "RNGridMenu.h"
#import "Appointment.h"

@import Contacts;
@import EventKit;
@import MessageUI;

@interface AppointmentCleanViewController : UITableViewController <MFMailComposeViewControllerDelegate, RNGridMenuDelegate>

@property (nonatomic, strong) NSArray *cells;

@property (nonatomic, strong) Appointment *appointment;

@property (nonatomic, strong) NSString *calendarNotesString;
@property (nonatomic, strong) NSString *emailBodyString;

@property (nonatomic, strong) CNContactStore *contactStore;
@property (nonatomic, strong) CNMutableContact *contact;

@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic, strong) EKEvent *event;

@end
