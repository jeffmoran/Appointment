//
//  CalendarEventHandler.h
//  Appointment
//
//  Created by Jeffrey Moran on 6/12/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import <Foundation/Foundation.h>

@import EventKit;

@interface CalendarEventHandler : NSObject {
	Appointment *appointment;
	UIViewController *controller;
}

- (instancetype)initWithAppointment:(Appointment *)anAppointment;
- (void)createNewCalendarEvent;

@end
