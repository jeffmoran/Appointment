#import "AppointmentsViewController.h"
#import "AppointmentStore.h"
#import "Appointment.h"
#import "AppointmentTableViewCell.h"
#import "MapViewController.h"
#import "AppointmentDetailViewController.h"
#import "SettingsViewController.h"

@implementation AppointmentsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = @"Appointments";

	UIBarButtonItem *settings = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"]
																 style:UIBarButtonItemStyleDone
																target:self
																action:@selector(goToSettings)];

	self.navigationItem.rightBarButtonItem = settings;

	[self setUpTableView];
	[self setUpAddAppointmentButton];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	//Added short timer so that DZNEmptyDataSet was properly centered on load
	[NSTimer scheduledTimerWithTimeInterval:.01
									 target:self
								   selector:@selector(reloadData)
								   userInfo:nil
									repeats:NO];
	
}

- (void)goToSettings {
	SettingsViewController *settingsVC = [[SettingsViewController alloc] init];

	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:settingsVC];

	[self presentViewController:navigationController animated:YES completion:nil];
}

- (void)reloadData {
	[appointmentsTableView reloadData];
}

- (void)setUpTableView {
	appointmentsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
	appointmentsTableView.translatesAutoresizingMaskIntoConstraints = NO;
	appointmentsTableView.allowsSelectionDuringEditing = YES;
	appointmentsTableView.delegate = self;
	appointmentsTableView.dataSource = self;
	appointmentsTableView.rowHeight = UITableViewAutomaticDimension;
	appointmentsTableView.estimatedRowHeight = 80.0;

	appointmentsTableView.emptyDataSetSource = self;
	appointmentsTableView.emptyDataSetDelegate = self;
	appointmentsTableView.tableFooterView = [UIView new];

	[appointmentsTableView registerClass:[AppointmentTableViewCell class] forCellReuseIdentifier:@"appointmentCellIdentifier"];

	[self.view addSubview:appointmentsTableView];

	[NSLayoutConstraint
	 activateConstraints:@[
						   [appointmentsTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
						   [appointmentsTableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
						   [appointmentsTableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
						   [appointmentsTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
						   ]];
}

#pragma mark - Add new appointment

- (void)setUpAddAppointmentButton {
	UIButton *newAppointmentButton = [[UIButton alloc] init];
	newAppointmentButton.translatesAutoresizingMaskIntoConstraints = NO;
	[newAppointmentButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
	newAppointmentButton.backgroundColor = FlatTeal;
	newAppointmentButton.tintColor = [UIColor whiteColor];
	newAppointmentButton.layer.cornerRadius = 28.0;
	newAppointmentButton.layer.shadowOpacity = 0.6;
	newAppointmentButton.layer.shadowColor = [UIColor blackColor].CGColor;
	newAppointmentButton.layer.shadowOffset = CGSizeMake(0.0, 0.0);
	newAppointmentButton.alpha = 0.8;

	[newAppointmentButton addTarget:self action:@selector(addNewAppointment) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:newAppointmentButton];

	[NSLayoutConstraint
	 activateConstraints:@[
						   [newAppointmentButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant: -10],
						   [newAppointmentButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant: -10],
						   [newAppointmentButton.widthAnchor constraintEqualToConstant:56],
						   [newAppointmentButton.heightAnchor constraintEqualToAnchor:newAppointmentButton.widthAnchor]
						   ]];

}

- (void)addNewAppointment {
	AppointmentInputViewController *inputViewController = [[AppointmentInputViewController alloc] init];

	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:inputViewController];

	[self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView.editing) {
		AppointmentInputViewController *inputViewController = [[AppointmentInputViewController alloc] init];
		
		NSArray *items = [[AppointmentStore shared] allAppointments];
		Appointment *selectedItem = items[indexPath.row];
		inputViewController.appointment = selectedItem;

		UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:inputViewController];

		[self presentViewController:navigationController animated:YES completion:nil];
	} else {
		AppointmentDetailViewController *detailViewController = [[AppointmentDetailViewController alloc] init];

		detailViewController.appointment = [[AppointmentStore shared] allAppointments][indexPath.row];

		[self.navigationController pushViewController:detailViewController animated:YES];
	}
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if ([[AppointmentStore shared] allAppointments].count > 0) {
		self.navigationItem.leftBarButtonItem = self.editButtonItem;
	} else {
		self.navigationItem.leftBarButtonItem = nil;
	}

	return [[AppointmentStore shared] allAppointments].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"appointmentCellIdentifier";

	Appointment *appointment = [[AppointmentStore shared] allAppointments][indexPath.row];
	
	AppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

	cell = [[AppointmentTableViewCell alloc] init];
	
	cell.appointment = appointment;

	[cell setUpAppointmentValues];

	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if ([[AppointmentStore shared] allAppointments].count == 0) {
		return @"";
	} else if ([[AppointmentStore shared] allAppointments].count == 1) {
		return @"1 Appointment";
	} else {
		return [NSString stringWithFormat:@"%lu Appointments", (unsigned long)[[AppointmentStore shared] allAppointments].count];

	}
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		Appointment *appointment = [[AppointmentStore shared] allAppointments][indexPath.row];
		[[AppointmentStore shared] removeAppointment:appointment];

		[tableView beginUpdates];
		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
		[tableView endUpdates];

		[tableView reloadData];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 76;
}

#pragma mark - DZNEmptyDataSet

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
	NSString *text = @"No appointments";
	NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
								 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
	
	return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
	NSString *text = @"Tap on the + button to create a new appointment.";
	
	NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
	paragraph.lineBreakMode = NSLineBreakByWordWrapping;
	paragraph.alignment = NSTextAlignmentCenter;
	
	NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
								 NSForegroundColorAttributeName: [UIColor lightGrayColor],
								 NSParagraphStyleAttributeName: paragraph};
	
	return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end
