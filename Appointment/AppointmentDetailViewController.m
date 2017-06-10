#import "AppointmentDetailViewController.h"
#import "MapViewController.h"
#import <ChameleonFramework/Chameleon.h>

@implementation AppointmentDetailViewController

@synthesize appointment;

#pragma mark -  Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];

	self.tableView.allowsSelection = NO;

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu"]
																			  style:UIBarButtonItemStylePlain
																			 target:self
																			 action:@selector(showGrid)];

//	_calendarNotesString = [NSString stringWithFormat: @"Property Address: %@\n\nClient Number: %@\n\nMove-In Date: %@\n\nPets Allowed: %@\n\nProperty Price: %@\n\nNeighborhood: %@\n\n Size: %@\n\nNumber of Bedrooms: %@\n\nNumber of Bathrooms: %@\n\nAccess: %@\n\nGuarantor: %@", self.addressString, self.phoneString, self.moveInDateString, self.petsString, self.priceString, self.neighborhoodString, self.aptsizeString, self.roomsString, self.bathsString, self.accessString, self.guarantorString];
//	
//	_emailBodyString = [NSString stringWithFormat: @"<b>Client Name:</b><br/>%@  <br/><br/> <b>Client Number:</b><br/>%@ <br/><br/><b>Appointment Time:</b><br/>%@ <br/><br/> <b>Property Address:</b><br/>%@ %@ <br/><br/>  <b>Neighborhood:</b><br/>%@ <br/><br/><b>Property Price:</b><br/>%@<br/><br/><b>Move-In Date:</b><br/>%@ <br/><br/> <b>Pets Allowed:</b><br/>%@ <br/><br/><b>Size:</b><br/>%@ Sq. Ft.<br/><br/> <b>Number of Bedrooms:</b><br/>%@ <br/><br/> <b>Number of Bathrooms:</b><br/>%@ <br/><br/> <b>Access:</b><br/>%@ <br/><br/> <b>Guarantor:</b><br/>%@", appointment.clientName, self.phoneString, appointment.appointmentTime, self.addressString, self.zipString, self.neighborhoodString, self.priceString, self.moveInDateString, self.petsString, self.aptsizeString, self.roomsString, self.bathsString, self.accessString, self.guarantorString];

	[self.tableView registerClass:[AppointmentDetailTableViewCell class] forCellReuseIdentifier:@"appointmentDetailCellIdentifier"];

	self.title = appointment.clientName;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
	switch (itemIndex) {
		case 0:
			[self makeCallWithString:appointment.clientPhone];
			break;
		case 1:
			[self makeEmailWithEmailString:appointment.clientEmail andTimeString:appointment.appointmentTime andNameString:appointment.clientName];
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

#pragma mark - Grid

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
	[menu showInViewController: self.navigationController center: CGPointMake(self.view.bounds.size.width / 2.f, self.view.bounds.size.height / 2.f)];
}

#pragma mark - Grid methods

- (void)makeCallWithString:(NSString *)number {
	UIDevice *device = [UIDevice currentDevice];
	
	if ([device.model isEqualToString: @"iPhone"] ) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"telprompt:%@", number]] options:@{} completionHandler:nil];
	} else {
		
		UIAlertController *notPermitted = [UIAlertController
										   alertControllerWithTitle:@"Alert"
										   message:@"Your device doesn't support this feature."
										   preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"OK"
									   style:UIAlertActionStyleCancel
									   handler:nil];
		
		[notPermitted addAction:cancelAction];
		
		[self presentViewController:notPermitted animated:YES completion:nil];
	}
}

- (void)makeEmailWithEmailString:(NSString *)email andTimeString:(NSString *)time andNameString:(NSString *)name {
	
	if ([MFMailComposeViewController canSendMail]) {
		MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
		
		controller.navigationBar.tintColor = [UIColor whiteColor];
		
		controller.mailComposeDelegate = self;
		
		[controller setSubject: [NSString stringWithFormat: @"%@ Appointment With %@", time, name]];
		[controller setToRecipients: @[email]];
		[controller setMessageBody:_emailBodyString isHTML:YES];
		
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

- (void)createNewCalendarEvent {
	EKEventStore *eventStore = [[EKEventStore alloc] init];
	
	UIAlertController *alertController = [UIAlertController
										  alertControllerWithTitle:[NSString stringWithFormat: @"%@ appointment with %@", appointment.appointmentTime, appointment.clientName]
										  message: @"Add this appointment to your calendar?"
										  preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction
								   actionWithTitle:@"Maybe later"
								   style:UIAlertActionStyleCancel
								   handler:nil];
	
	UIAlertAction *yesAction = [UIAlertAction
								actionWithTitle:@"Yes"
								style:UIAlertActionStyleDefault
								handler:^(UIAlertAction *action) {
									[eventStore requestAccessToEntityType:EKEntityTypeEvent completion: ^(BOOL granted, NSError *_Nullable error) {
										EKAuthorizationStatus authorizationStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
										dispatch_async(dispatch_get_main_queue(), ^{
											switch (authorizationStatus) {
												case EKAuthorizationStatusNotDetermined: {
													NSLog(@"The user has not yet made a choice regarding whether the app may access the service.");
												}
													break;
												case EKAuthorizationStatusRestricted: {
													NSLog(@"The app is not authorized to access the service. The user cannot change this app’s authorization status, possibly due to active restrictions such as parental controls being in place.");
													
													UIAlertController *alertController = [UIAlertController
																						  alertControllerWithTitle:@"Unable to add event"
																						  message:@"Please check your Calendar Permissions in Settings and try again."
																						  preferredStyle:UIAlertControllerStyleAlert];
													
													UIAlertAction *cancelAction = [UIAlertAction
																				   actionWithTitle:@"OK"
																				   style:UIAlertActionStyleCancel
																				   handler:nil];
													
													[alertController addAction:cancelAction];
													
													[self presentViewController:alertController animated:YES completion:nil];
												}
													break;
												case EKAuthorizationStatusAuthorized: {
													NSLog(@"The app is authorized to access the service.");
													
													EKEvent *event = [EKEvent eventWithEventStore:eventStore];
													event.title = [NSString stringWithFormat: @"%@ appointment with %@", appointment.appointmentTime, appointment.clientName];
													event.location = [NSString stringWithFormat: @"%@", appointment.address];
													event.notes = _calendarNotesString;

													event.startDate = appointment.appointmentTime;
													event.endDate = [NSDate dateWithTimeInterval:3600 sinceDate:appointment.appointmentTime];
													
													NSLog(@"Event startDate %@", event.startDate);
													NSLog(@"Event endDate%@",  event.endDate);
													
													NSArray *alarms = @[
																		[EKAlarm alarmWithRelativeOffset:-3600], // 1 hour
																		[EKAlarm alarmWithRelativeOffset:-86400] // 1 day
																		];
													
													event.alarms = alarms;
													event.calendar = eventStore.defaultCalendarForNewEvents;

													[self saveNewEvent:event store:eventStore];
												}
													break;
												case EKAuthorizationStatusDenied: {
													NSLog(@"The user explicitly denied access to the service for the app.");
													
													UIAlertController *alertController = [UIAlertController
																						  alertControllerWithTitle:@"Unable to add event"
																						  message:@"Please check your Calendar Permissions in Settings and try again."
																						  preferredStyle:UIAlertControllerStyleAlert];
													
													UIAlertAction *cancelAction = [UIAlertAction
																				   actionWithTitle:@"OK"
																				   style:UIAlertActionStyleCancel
																				   handler:nil];
													
													[alertController addAction:cancelAction];
													
													[self presentViewController:alertController animated:YES completion:nil];
												}
													break;
												default:
													break;
											}
										});
									}];
								}];
	
	[alertController addAction:cancelAction];
	[alertController addAction:yesAction];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)saveNewEvent:(EKEvent *)event store:(EKEventStore *)eventStore {
	NSError *saveError;
	
	if ([eventStore saveEvent:event span:EKSpanThisEvent error:&saveError]) {
		NSLog(@"Event saved.");
		
		UIAlertController *alertController = [UIAlertController
											  alertControllerWithTitle:[NSString stringWithFormat:@"Appointment added to your calendar successfully."]
											  message:nil
											  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"OK"
									   style:UIAlertActionStyleCancel
									   handler:nil];
		
		[alertController addAction:cancelAction];

		[self presentViewController:alertController animated:YES completion:nil];
	} else {
		NSLog(@"Event not saved. %@", saveError);
		
		UIAlertController *alertController = [UIAlertController
											  alertControllerWithTitle:[NSString stringWithFormat:@"Appointment not added to your calendar."]
											  message:@"Please check your Calendar Permissions in Settings and try again."
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
	UIAlertController *alertController = [UIAlertController
										  alertControllerWithTitle:[NSString stringWithFormat: @"%@", appointment.clientName]
										  message:@"Add this person to your contacts?"
										  preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction
								   actionWithTitle:@"Maybe later"
								   style:UIAlertActionStyleCancel
								   handler:nil];
	
	UIAlertAction *yesAction = [UIAlertAction
								actionWithTitle:@"Yes"
								style:UIAlertActionStyleDefault
								handler:^(UIAlertAction *action) {
									CNContactStore *contactStore = [[CNContactStore alloc] init];
									[contactStore requestAccessForEntityType: CNEntityTypeContacts completionHandler: ^(BOOL accessGranted, NSError *_Nullable error) {
										
										//Create authorizationStatus and assign it to CNContactStore
										CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
										dispatch_async(dispatch_get_main_queue(), ^{
											
											switch (authorizationStatus) {
												case CNAuthorizationStatusNotDetermined: {
													NSLog(@"The user has not yet made a choice regarding whether the application may access contact data.");
													NSLog(@"%@", error);
													break;
												}
												case CNAuthorizationStatusRestricted: {
													NSLog(@"The application is not authorized to access contact data. The user cannot change this application’s status, possibly due to active restrictions such as parental controls being in place.");
													
													UIAlertController *alertController = [UIAlertController
																						  alertControllerWithTitle:@"Unable to add contact"
																						  message:@"Please check your Contact Permissions in Settings and try again."
																						  preferredStyle:UIAlertControllerStyleAlert];
													
													UIAlertAction *cancelAction = [UIAlertAction
																				   actionWithTitle:@"OK"
																				   style:UIAlertActionStyleCancel
																				   handler:nil];
													
													[alertController addAction:cancelAction];
													
													[self presentViewController:alertController animated:YES completion:nil];
													break;
												}
												case CNAuthorizationStatusAuthorized: {
													NSLog(@"The application is authorized to access contact data.");

													CNMutableContact *contact = [[CNMutableContact alloc] init];

													contact.givenName = appointment.clientName;
													contact.phoneNumbers = @[[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:[CNPhoneNumber phoneNumberWithStringValue:appointment.clientPhone]]];
													contact.emailAddresses = @[[CNLabeledValue labeledValueWithLabel:CNLabelHome value:appointment.clientEmail]];
													
													[self saveNewContact:contact store:contactStore];
													break;
												}
												case CNAuthorizationStatusDenied: {
													NSLog(@"The user explicitly denied access to contact data for the application.");
													
													UIAlertController *alertController = [UIAlertController
																						  alertControllerWithTitle:@"Unable to add contact"
																						  message:@"Please check your Contact Permissions in Settings and try again."
																						  preferredStyle:UIAlertControllerStyleAlert];
													
													UIAlertAction *cancelAction = [UIAlertAction
																				   actionWithTitle:@"OK"
																				   style:UIAlertActionStyleCancel
																				   handler:nil];
													
													[alertController addAction:cancelAction];
													
													[self presentViewController:alertController animated:YES completion:nil];
													break;
												}
												default:
													break;
											}
										});
									}];
								}];
	
	[alertController addAction:cancelAction];
	[alertController addAction:yesAction];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)saveNewContact:(CNMutableContact *)contact store:(CNContactStore *)contactStore {
	CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
	[saveRequest addContact:contact toContainerWithIdentifier:nil];
	
	NSError *saveError = nil;
	
	if ([contactStore executeSaveRequest: saveRequest error:&saveError]) {
		NSLog(@"Contact saved.");
		
		UIAlertController *alertController = [UIAlertController
											  alertControllerWithTitle:[NSString stringWithFormat: @"%@ contact saved successfully.", appointment.clientName]
											  message:nil
											  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"OK"
									   style:UIAlertActionStyleCancel
									   handler:nil];
		
		[alertController addAction:cancelAction];
		[self presentViewController:alertController animated:YES completion:nil];
	} else {
		NSLog(@"Contact not saved. %@", saveError);
		
		UIAlertController *alertController = [UIAlertController
											  alertControllerWithTitle:[NSString stringWithFormat: @"%@ contact not saved.", appointment.clientName]
											  message: @"Please check your Contact Permissions in Settings and try again."
											  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"OK"
									   style:UIAlertActionStyleCancel
									   handler:nil];
		
		[alertController addAction:cancelAction];
		
		[self presentViewController:alertController animated:YES completion:nil];
	}
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return appointment.appointmentProperties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"appointmentDetailCellIdentifier";

	AppointmentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

	cell = [[AppointmentDetailTableViewCell alloc] init];
	cell.appointmentHeaderLabel.text = appointment.appointmentPropertiesHeader[indexPath.row];
	cell.appointmentValueLabel.text = appointment.appointmentProperties[indexPath.row];

	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}

#pragma mark - MFMailComposeViewController Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	switch (result) {
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
	
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
