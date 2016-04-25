#import "AppointmentCleanViewController.h"
#import "MapViewController.h"
#import <ChameleonFramework/Chameleon.h>

@implementation AppointmentCleanViewController
@synthesize contact, contactStore, event, eventStore;

#pragma mark View Lifecycle

- (void) loadView{
	[super loadView];
	
	TKLabelFieldCell *nameField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	nameField.label.text = @"Client\nName";
	nameField.field.text = self.nameString;
	
	TKLabelFieldCell *emailField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	emailField.label.text = @"Client\nEmail";
	emailField.field.text = self.emailString;
	
	TKLabelFieldCell *phoneNumberField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	phoneNumberField.label.text = @"Client\nNumber";
	phoneNumberField.field.text = self.phoneString;
	
	TKLabelFieldCell *timeField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	timeField.label.text = @"Time";
	timeField.field.text = self.timeString;
	
	TKLabelFieldCell *addressField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	addressField.label.text = @"Property\nAddress";
	addressField.field.text = self.addressString;
	addressField.field.adjustsFontSizeToFitWidth = YES;
	
	TKLabelFieldCell *moveInDateField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	moveInDateField.label.text = @"Move-In\nDate";
	moveInDateField.field.text = self.moveInDateString;
	
	TKLabelFieldCell *petsField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	petsField.label.text = @"Pets";
	petsField.field.text = self.petsString;
	
	TKLabelFieldCell *priceField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	priceField.label.text = @"Rent";
	priceField.field.text = self.priceString;
	
	TKLabelFieldCell *neighborhoodField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	neighborhoodField.label.text = @"Location";
	neighborhoodField.field.text = self.neighborhoodString;
	
	TKLabelFieldCell *aptsizeField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	aptsizeField.label.text = @"Apartment\nSize";
	aptsizeField.field.text = self.aptsizeString;
	
	TKLabelFieldCell *roomsField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	roomsField.label.text = @"Bedrooms";
	roomsField.field.text = self.roomsString;
	
	TKLabelFieldCell *bathsField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	bathsField.label.text = @"Bathrooms";
	bathsField.field.text = self.bathsString;
	
	TKLabelFieldCell *accessField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	accessField.label.text = @"Access";
	accessField.field.text = self.accessString;
	
	TKLabelFieldCell *guarantorField = [[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	guarantorField.label.text = @"Guarantor";
	guarantorField.field.text = self.guarantorString;
	
	self.cells = @[nameField,emailField,phoneNumberField,timeField,addressField,moveInDateField,petsField, priceField, neighborhoodField, aptsizeField, roomsField,bathsField, accessField, guarantorField];
}

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.tableView setAllowsSelection:NO];
	
	UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain
															target:self
															action:@selector(showGrid)];
	[[self navigationItem] setRightBarButtonItem:menu];
	
	_calendarNotesString = [NSString stringWithFormat:@"Property Address: %@\n\nClient Number: %@\n\nMove-In Date: %@\n\nPets Allowed: %@\n\nProperty Price: %@\n\nNeighborhood: %@\n\nApartment Size: %@\n\nNumber of Bedrooms: %@\n\nNumber of Bathrooms: %@\n\nAccess: %@\n\nGuarantor: %@", self.addressString, self.phoneString, self.moveInDateString, self.petsString, self.priceString, self.neighborhoodString, self.aptsizeString, self.roomsString, self.bathsString, self.accessString, self.guarantorString];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
	switch (itemIndex) {
		case 0:
			[self call];
			break;
		case 1:
			[self email];
			break;
		case 2:
			//[self map];
			//NSTimer is temporary solution to "Unbalanced calls to begin/end appearance transitions" bug
			//NSTimer is set to wait .26 seconds for RNGridMenu to completely dismiss.
			[NSTimer scheduledTimerWithTimeInterval:.26
											 target:self
										   selector:@selector(map)
										   userInfo:nil
											repeats:NO];
			break;
		case 3:
			[self newContact];
			break;
		case 4:
			[self calendar];
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
	NSInteger numberOfOptions = 6;
	NSArray *items = @[
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"phone128"] title:@"Call client"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"email128"] title:@"Email client"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"map128"] title:@"Find on map"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"contact128"] title:@"Add contact"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"calendar128"] title:@"Calendar"],
					   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"cancel"] title:@"Cancel"],
					   ];
	
	RNGridMenu *menu = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
	menu.delegate = self;
	menu.highlightColor = [UIColor flatRedColor];
	menu.itemSize = CGSizeMake(128, 128);
	[menu showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

#pragma mark - Grid methods

- (void)call {
	UIDevice *device = [UIDevice currentDevice];
	if ([[device model] isEqualToString:@"iPhone"] ) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",self.phoneString]]];
	} else {
		
		UIAlertController *notPermitted = [UIAlertController
											  alertControllerWithTitle:@"Alert"
											  message:@"Your device doesn't support this feature."
											  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"OK"
									   style:UIAlertActionStyleCancel
									   handler:^(UIAlertAction *action) {
										   NSLog(@"Cancel action");
									   }];
		
		[notPermitted addAction:cancelAction];
		
		[self presentViewController:notPermitted animated:YES completion:nil];
	}
}

- (void)email{
	if ([MFMailComposeViewController canSendMail])
	{
		MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
		
		controller.mailComposeDelegate = self;
		
		[controller setSubject: [NSString stringWithFormat: @"%@ Appointment With %@", self.timeString, self.nameString]];
		
		NSArray *toRecipients = [NSArray arrayWithObjects:self.emailString, nil];
		
		[controller setToRecipients:toRecipients];
		
		NSString *emailBody = [NSString stringWithFormat: @"<b>Client Name:</b><br/>%@  <br/><br/> <b>Appointment Time:</b><br/>%@ <br/><br/> <b>Property Address:</b><br/>%@ <br/><br/> <b>Client Number:</b><br/>%@ <br/><br/> <b>Move-In Date:</b><br/>%@ <br/><br/> <b>Pets Allowed:</b><br/>%@ <br/><br/> <b>Property Price:</b><br/>%@<br/><br/> <b>Neighborhood:</b><br/>%@  <br/><br/> <b>Apartment Size:</b><br/>%@ <br/><br/> <b>Number of Bedrooms:</b><br/>%@ <br/><br/> <b>Number of Bathrooms:</b><br/>%@ <br/><br/> <b>Access:</b><br/>%@ <br/><br/> <b>Guarantor:</b><br/>%@", self.nameString, self.timeString, self.addressString, self.phoneString, self.moveInDateString, self.petsString, self.priceString, self.neighborhoodString, self.aptsizeString, self.roomsString, self.bathsString, self.accessString, self.guarantorString];
		
		[controller setMessageBody:emailBody isHTML:YES];
		
		[self presentViewController:controller animated:YES completion: nil];
	}
	else
	{
		UIAlertController *alertController = [UIAlertController
											  alertControllerWithTitle:@"Failure"
											  message:@"Your device doesn't support the composer sheet"
											  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"OK"
									   style:UIAlertActionStyleCancel
									   handler:^(UIAlertAction *action) {
										   NSLog(@"Cancel action");
									   }];
		
		[alertController addAction:cancelAction];
		
		[self presentViewController:alertController animated:YES completion:nil];
	}
}

-(void)calendar{
	eventStore = [[EKEventStore alloc] init];
	
	
	UIAlertController *alertController = [UIAlertController
										  alertControllerWithTitle:[NSString stringWithFormat:@"%@ appointment with %@",self.timeString, self.nameString]
										  message:@"Add this appointment to your calendar?"
										  preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction
								   actionWithTitle:@"Maybe later"
								   style:UIAlertActionStyleCancel
								   handler:^(UIAlertAction *action) {
									   NSLog(@"Cancel action");
								   }];
	
	UIAlertAction *yesAction = [UIAlertAction
								actionWithTitle:@"Yes"
								style:UIAlertActionStyleDefault
								handler:^(UIAlertAction *action) {
									[eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
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
																				   handler:^(UIAlertAction *action) {
																					   NSLog(@"Cancel action");
																				   }];
													
													[alertController addAction:cancelAction];
													
													[self presentViewController:alertController animated:YES completion:nil];
												}
													break;
												case EKAuthorizationStatusAuthorized: {
													NSLog(@"The app is authorized to access the service.");
													
													event  = [EKEvent eventWithEventStore:eventStore];
													event.title = [NSString stringWithFormat:@"%@ appointment with %@",self.timeString, self.nameString];
													event.location = [NSString stringWithFormat:@"%@", self.addressString];
													event.notes = _calendarNotesString;
													
													NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
													
													[dateFormatter setDateFormat:@"MMMM d yyyy h:mm aa"];
													NSDate *dateFromString = [[NSDate alloc] init];
													
													dateFromString = [dateFormatter dateFromString:self.timeString];
													
													event.startDate = dateFromString;
													event.endDate = [NSDate dateWithTimeInterval:3600 sinceDate:dateFromString];
													
													NSLog(@"%@", dateFromString);
													NSLog(@"%@", self.timeString);
													
													NSArray *alarms = @[
																		[EKAlarm alarmWithRelativeOffset:-3600], // 1 hour
																		[EKAlarm alarmWithRelativeOffset:-86400] // 1 day
																		];
													
													event.alarms = alarms;
													[event setCalendar:[eventStore defaultCalendarForNewEvents]];
													
													[self saveNewEvent];
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
																				   handler:^(UIAlertAction *action) {
																					   NSLog(@"Cancel action");
																				   }];
													
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

- (void)saveNewEvent {
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
									   handler:^(UIAlertAction *action) {
										   
									   }];
		
		[alertController addAction:cancelAction];
		
		[self presentViewController:alertController animated:YES completion:nil];
	}
	
	else {
		NSLog(@"Event not saved. %@", saveError);
		
		UIAlertController *alertController = [UIAlertController
											  alertControllerWithTitle:[NSString stringWithFormat:@"Appointment not added to your calendar."]
											  message:@"Please check your Calendar Permissions in Settings and try again."
											  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"OK"
									   style:UIAlertActionStyleCancel
									   handler:^(UIAlertAction *action) {
										   NSLog(@"Cancel action");
									   }];
		
		[alertController addAction:cancelAction];
		
		[self presentViewController:alertController animated:YES completion:nil];
	}
}

- (void)map {
	NSLog(@"Maps segue");
	if (self.navigationController.visibleViewController == self){
	[self performSegueWithIdentifier:@"map" sender:self];
	}
}

- (void)newContact {
	//Initialize contactStore and contact
	contactStore = [[CNContactStore alloc] init];
	contact = [[CNMutableContact alloc] init];
	
	//Request access from contactStore
	[contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL accessGranted, NSError *_Nullable error) {
		
		//Create authorizationStatus and assign it to CNContactStore
		CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
		dispatch_async(dispatch_get_main_queue(), ^{
			
			switch (authorizationStatus) {
				case CNAuthorizationStatusNotDetermined:
					NSLog(@"The user has not yet made a choice regarding whether the application may access contact data.");
					NSLog(@"%@", error);
					break;
				case CNAuthorizationStatusRestricted: {
					NSLog(@"The application is not authorized to access contact data. The user cannot change this application’s status, possibly due to active restrictions such as parental controls being in place.");
					
					UIAlertController *alertController = [UIAlertController
														  alertControllerWithTitle:@"Unable to add contact"
														  message:@"Please check your Contact Permissions in Settings and try again."
														  preferredStyle:UIAlertControllerStyleAlert];
					
					UIAlertAction *cancelAction = [UIAlertAction
												   actionWithTitle:@"OK"
												   style:UIAlertActionStyleCancel
												   handler:^(UIAlertAction *action) {
													   NSLog(@"Cancel action");
												   }];
					
					[alertController addAction:cancelAction];
					
					[self presentViewController:alertController animated:YES completion:nil];
					
					break;
				}
				case CNAuthorizationStatusAuthorized:
					NSLog(@"The application is authorized to access contact data.");
					contact.givenName = _nameString;
					contact.phoneNumbers = [[NSArray alloc]initWithObjects:[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:[CNPhoneNumber phoneNumberWithStringValue:_phoneString]], nil];
					contact.emailAddresses = [[NSArray alloc] initWithObjects:[CNLabeledValue labeledValueWithLabel:CNLabelHome value:_emailString], nil];
					
					[self saveNewContact];
					
					break;
				case CNAuthorizationStatusDenied: {
					NSLog(@"The user explicitly denied access to contact data for the application.");
					
					UIAlertController *alertController = [UIAlertController
														  alertControllerWithTitle:@"Unable to add contact"
														  message:@"Please check your Contact Permissions in Settings and try again."
														  preferredStyle:UIAlertControllerStyleAlert];
					
					UIAlertAction *cancelAction = [UIAlertAction
												   actionWithTitle:@"OK"
												   style:UIAlertActionStyleCancel
												   handler:^(UIAlertAction *action) {
													   NSLog(@"Cancel action");
												   }];
					
					[alertController addAction:cancelAction];
					
					[self presentViewController:alertController animated:YES completion:nil];
					
					break;
				}
				default:
					break;
			}
		});
	}];
}

- (void)saveNewContact {
	CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
	[saveRequest addContact:contact toContainerWithIdentifier:nil];
	
	NSError *saveError = nil;
	
	if ([contactStore executeSaveRequest:saveRequest error:&saveError]){
		NSLog(@"Contact saved.");
		
		UIAlertController *alertController = [UIAlertController
											  alertControllerWithTitle:[NSString stringWithFormat:@"%@ contact saved successfully.", _nameString]
											  message:nil
											  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"OK"
									   style:UIAlertActionStyleCancel
									   handler:^(UIAlertAction *action) {
										   NSLog(@"Cancel action");
									   }];
		
		[alertController addAction:cancelAction];
		
		[self presentViewController:alertController animated:YES completion:nil];
	}
	
	else{
		NSLog(@"Contact not saved. %@", saveError);
		
		UIAlertController *alertController = [UIAlertController
											  alertControllerWithTitle:[NSString stringWithFormat:@"%@ contact not saved.", _nameString]
											  message:@"Please check your Contact Permissions in Settings and try again."
											  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"OK"
									   style:UIAlertActionStyleCancel
									   handler:^(UIAlertAction *action) {
										   NSLog(@"Cancel action");
									   }];
		
		[alertController addAction:cancelAction];
		
		[self presentViewController:alertController animated:YES completion:nil];
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"map"]) {
		MapViewController *destViewController = segue.destinationViewController;
		destViewController.addressName = self.addressString;
	}
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.cells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return self.cells[indexPath.row];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 50;
}

#pragma mark - MFMailComposeViewController Delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
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
	
	[self dismissViewControllerAnimated:YES completion: nil];
}

@end