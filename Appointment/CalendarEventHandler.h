//
//  CalendarEventHandler.h
//  Appointment
//
//  Created by Jeffrey Moran on 6/12/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface CalendarEventHandler : NSObject

+ (void)createNewCalendarEventWith:(Appointment *)appointment on:(UIViewController *)controller;

@end
