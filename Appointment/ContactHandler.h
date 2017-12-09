//
//  ContactHandler.h
//  Appointment
//
//  Created by Jeffrey Moran on 6/12/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>

@interface ContactHandler : NSObject

+ (void)createNewContactWith:(Appointment *)appointment on:(UIViewController *)controller;

@end
