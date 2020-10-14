#import <Foundation/Foundation.h>
#import "AppointmentInputViewController.h"

@interface AppointmentsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	UIButton *newAppointmentButton;
	UITableView *appointmentsTableView;
}

@end
