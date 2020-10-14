#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppointmentsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	UIButton *newAppointmentButton;
	UITableView *appointmentsTableView;
}

@end
