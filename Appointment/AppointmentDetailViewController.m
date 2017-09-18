#import "AppointmentDetailViewController.h"
#import "MapViewController.h"

@implementation AppointmentDetailViewController

@synthesize appointment;

static NSString *cellIdentifier = @"appointmentDetailCellIdentifier";

// MARK: - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];

	self.tableView.allowsSelection = NO;

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu"]
																			  style:UIBarButtonItemStylePlain
																			 target:self
																			 action:@selector(showGrid)];


	[self.tableView registerClass:[AppointmentDetailTableViewCell class] forCellReuseIdentifier:cellIdentifier];

	self.tableView.rowHeight = UITableViewAutomaticDimension;
	self.tableView.estimatedRowHeight = 50.0;

	self.title = appointment.clientName;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

// MARK: - Grid

- (void)showGrid {
	NSArray *items = @[
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed: @"phone128"] title: @"Call client"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed: @"email128"] title: @"Email client"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed: @"map128"] title: @"Find on map"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed: @"contact128"] title: @"Add contact"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed: @"calendar"] title: @"Calendar"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed: @"cancel"] title: @"Cancel"],
					   ];

	RNGridMenu *menu = [[RNGridMenu alloc] initWithItems:items];

	menu.delegate = self;
	menu.highlightColor = FlatTeal;
	menu.itemSize = CGSizeMake(128, 128);

	[menu showInViewController:self.navigationController center:self.view.center];
}

// MARK: - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
	switch (itemIndex) {
		case 0:
			[self callContact];
			break;
		case 1:
			[self showEmailComposer];
			break;
		case 2:
			//[self goToMapView];
			//NSTimer is temporary solution to "Unbalanced calls to begin/end appearance transitions" bug
			//NSTimer is set to wait .26 seconds for RNGridMenu to completely dismiss.
			[NSTimer scheduledTimerWithTimeInterval:.26
											 target:self
										   selector:@selector(goToMapView)
										   userInfo:nil
											repeats:NO];
			break;
		case 3:
			[self createNewContact];
			break;
		case 4:
			[self createNewCalendarEvent];
			break;
		case 5:
			NSLog(@"Cancelled");
			break;
		default:
			break;
	}
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
	mapVC.address = [NSString stringWithFormat:@"%@ %@", appointment.address, appointment.zipCode];

	[self.navigationController pushViewController:mapVC animated:YES];
}

- (void)createNewContact {
	ContactHandler *handler = [[ContactHandler alloc] initWithAppointment:appointment];
	[handler createNewContact];
}

- (void)createNewCalendarEvent {
	CalendarEventHandler *handler = [[CalendarEventHandler alloc] initWithAppointment:appointment];
	[handler createNewCalendarEvent];
}

// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return appointment.appointmentProperties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	AppointmentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

	[cell setAppointment:appointment with:indexPath];

	return cell;
}

// MARK: - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
