//
//  CalendarEventHandler.m
//  Appointment
//
//  Created by Jeffrey Moran on 6/12/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import "CalendarEventHandler.h"

@implementation CalendarEventHandler

- (instancetype)initWithAppointment:(Appointment *)anAppointment {
	self = [super init];

	if (self) {
		appointment = anAppointment;
		controller = [UIApplication sharedApplication].keyWindow.rootViewController;
	}

	return self;
}

- (void)createNewCalendarEvent {

	UIAlertController *alertController = [UIAlertController
										  alertControllerWithTitle:[NSString stringWithFormat: @"%@ appointment with %@", appointment.appointmentDateString, appointment.clientName]
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
									[self authorizeEventStore];
								}];

	[alertController addAction:cancelAction];
	[alertController addAction:yesAction];
	[controller presentViewController:alertController animated:YES completion:nil];
}

- (void)authorizeEventStore {
	EKEventStore *eventStore = [[EKEventStore alloc] init];

	[eventStore requestAccessToEntityType:EKEntityTypeEvent completion: ^(BOOL granted, NSError *_Nullable error) {
		EKAuthorizationStatus authorizationStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
		dispatch_async(dispatch_get_main_queue(), ^{
			switch (authorizationStatus) {
				case EKAuthorizationStatusNotDetermined: {
					NSLog(@"The user has not yet made a choice regarding whether the app may access the service.");
					break;
				}
				case EKAuthorizationStatusAuthorized: {
					NSLog(@"The app is authorized to access the service.");

					EKEvent *event = [EKEvent eventWithEventStore:eventStore];
					event.title = [NSString stringWithFormat: @"%@ appointment with %@", appointment.appointmentDateString, appointment.clientName];
					event.location = [NSString stringWithFormat: @"%@", appointment.address];
					event.notes = appointment.calendarNotesString;

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
					break;
				}
				default: {
					UIAlertController *alertController = [UIAlertController
														  alertControllerWithTitle:@"Unable to add event"
														  message:@"Please check your Calendar Permissions in Settings and try again."
														  preferredStyle:UIAlertControllerStyleAlert];

					UIAlertAction *dismissAction = [UIAlertAction
													actionWithTitle:@"Dismiss"
													style:UIAlertActionStyleCancel
													handler:nil];

					[alertController addAction:dismissAction];

					[controller presentViewController:alertController animated:YES completion:nil];
					break;
				}
			}
		});
	}];

}

- (void)saveNewEvent:(EKEvent *)event store:(EKEventStore *)eventStore {
	NSError *saveError;

	UIAlertController *alertController = nil;

	if ([eventStore saveEvent:event span:EKSpanThisEvent error:&saveError]) {
		alertController = [UIAlertController
						   alertControllerWithTitle:[NSString stringWithFormat:@"Appointment added to your calendar successfully."]
						   message:nil
						   preferredStyle:UIAlertControllerStyleAlert];
	} else {
		alertController = [UIAlertController
						   alertControllerWithTitle:[NSString stringWithFormat:@"Appointment not added to your calendar."]
						   message:saveError.localizedDescription
						   preferredStyle:UIAlertControllerStyleAlert];

	}

	UIAlertAction *dismissAction = [UIAlertAction
									actionWithTitle:@"Dismiss"
									style:UIAlertActionStyleDefault
									handler:nil];

	[alertController addAction:dismissAction];

	[controller presentViewController:alertController animated:YES completion:nil];
}

@end
