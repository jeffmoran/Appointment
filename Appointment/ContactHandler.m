//
//  ContactHandler.m
//  Appointment
//
//  Created by Jeffrey Moran on 6/12/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import "ContactHandler.h"

@implementation ContactHandler

- (instancetype)initWithAppointment:(Appointment *)anAppointment {
	self = [super init];
	
	if (self) {
		appointment = anAppointment;
		controller = [UIApplication sharedApplication].keyWindow.rootViewController;
	}
	
	return self;
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
									[self authorizeContactStore];
								}];
	
	[alertController addAction:cancelAction];
	[alertController addAction:yesAction];
	
	[controller presentViewController:alertController animated:YES completion:nil];
}

- (void)authorizeContactStore {
	CNContactStore *contactStore = [[CNContactStore alloc] init];
	
	[contactStore requestAccessForEntityType: CNEntityTypeContacts completionHandler: ^(BOOL accessGranted, NSError *_Nullable error) {
		CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
		dispatch_async(dispatch_get_main_queue(), ^{
			switch (authorizationStatus) {
				case CNAuthorizationStatusNotDetermined: {
					NSLog(@"The user has not yet made a choice regarding whether the application may access contact data.");
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
				default: {
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
					
					[controller presentViewController:alertController animated:YES completion:nil];
					break;
				}
			}
		});
	}];
}

- (void)saveNewContact:(CNMutableContact *)contact store:(CNContactStore *)contactStore {
	CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
	[saveRequest addContact:contact toContainerWithIdentifier:nil];
	
	NSError *saveError = nil;
	
	UIAlertController *alertController = nil;
	
	if ([contactStore executeSaveRequest: saveRequest error:&saveError]) {
		alertController = [UIAlertController
						   alertControllerWithTitle:[NSString stringWithFormat: @"%@ contact saved successfully.", appointment.clientName]
						   message:nil
						   preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"Dismiss"
									   style:UIAlertActionStyleDefault
									   handler:nil];
		
		[alertController addAction:cancelAction];
	} else {
		alertController = [UIAlertController
						   alertControllerWithTitle:[NSString stringWithFormat: @"%@ contact not saved.", appointment.clientName]
						   message: saveError.localizedDescription
						   preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *cancelAction = [UIAlertAction
									   actionWithTitle:@"Dismiss"
									   style:UIAlertActionStyleDefault
									   handler:nil];
		
		[alertController addAction:cancelAction];
	}
	
	[controller presentViewController:alertController animated:YES completion:nil];
}

@end
