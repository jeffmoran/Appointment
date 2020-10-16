#import "AppointmentDetailViewController.h"
#import "MapViewController.h"

#import "Appointment-Swift.h"

@implementation AppointmentDetailViewController

@synthesize appointment;

// MARK: - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.tableView.allowsSelection = NO;

    [self setUpMenu];

    [self.tableView registerClass:AppointmentDetailTableViewCell.class forCellReuseIdentifier:AppointmentDetailTableViewCell.reuseIdentifier];
	
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	self.tableView.estimatedRowHeight = 50.0;
	
	self.title = appointment.clientName;
}

// MARK: - Menu Actions

- (void)setUpMenu {
    UIAction *phoneAction = [UIAction actionWithTitle:@"Call client" image:[UIImage systemImageNamed:@"phone"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self callContact];
    }];
    
    UIAction *emailAction = [UIAction actionWithTitle:@"Email client" image:[UIImage systemImageNamed:@"envelope"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self showEmailComposer];
    }];

    UIAction *mapAction = [UIAction actionWithTitle:@"Find on map" image:[UIImage systemImageNamed:@"mappin.and.ellipse"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self goToMapView];
    }];

    UIAction *addContactAction = [UIAction actionWithTitle:@"Add contact" image:[UIImage systemImageNamed:@"person.crop.circle.badge.plus"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self createNewContact];
    }];

    UIAction *calendarAction = [UIAction actionWithTitle:@"Calendar" image:[UIImage systemImageNamed:@"calendar.badge.plus"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self createNewCalendarEvent];
    }];

    UIMenu *menu = [UIMenu menuWithTitle:@"" children:@[ phoneAction, emailAction, mapAction, addContactAction, calendarAction]];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"ellipsis.circle"] menu:menu];
}

- (void)callContact {
	NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat: @"telprompt:%@", appointment.clientPhone]];
	
	if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
		[[UIApplication sharedApplication] openURL:phoneURL options:@{} completionHandler:nil];
	} else {
		UIAlertController *alertController = [UIAlertController
											  alertControllerWithTitle:@"Error"
											  message:@"Your device cannot make calls."
											  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *dismissAction = [UIAlertAction
										actionWithTitle:@"Dismiss"
										style:UIAlertActionStyleCancel
										handler:nil];
		
		[alertController addAction:dismissAction];
		
		[self presentViewController:alertController animated:YES completion:nil];
	}
}

- (void)showEmailComposer {
	if ([MFMailComposeViewController canSendMail]) {
		MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
		
		controller.navigationBar.tintColor = [UIColor whiteColor];
		
		controller.mailComposeDelegate = self;
		
		[controller setSubject: [NSString stringWithFormat: @"%@ Appointment With %@", appointment.appointmentDateString, appointment.clientName]];
		[controller setToRecipients: @[appointment.clientEmail]];
		[controller setMessageBody:appointment.emailBodyString isHTML:YES];
		
		[self presentViewController:controller animated:YES completion:nil];
	} else {
		UIAlertController *alertController = [UIAlertController
											  alertControllerWithTitle:@"Failure"
											  message:@"Your device doesn't support the composer sheet"
											  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"OK"
									   style:UIAlertActionStyleCancel
									   handler:nil];
		
		[alertController addAction:cancelAction];
		
		[self presentViewController:alertController animated:YES completion:nil];
	}
}

- (void)goToMapView {
	MapViewController *mapVC = [[MapViewController alloc] init];
	mapVC.addressString = [NSString stringWithFormat:@"%@ %@", appointment.address, appointment.zipCode];
	
	[self.navigationController pushViewController:mapVC animated:YES];
}

- (void)createNewContact {
	[ContactHandler createNewContactWith:appointment on:self];
}

- (void)createNewCalendarEvent {
	[CalendarEventHandler createNewCalendarEventWith:appointment on:self];
}

// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return appointment.appointmentProperties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	AppointmentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AppointmentDetailTableViewCell.reuseIdentifier];

    [cell styleWith:appointment index:indexPath.row];

	return cell;
}

// MARK: - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
