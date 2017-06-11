//
//  GoogleGeocodeAPI.h
//  Appointment
//
//  Created by Jeff Moran on 6/11/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoogleGeocodeAPI : NSObject

+ (void)requestCityWithZipCode:(NSString *)zipCode completionHandler:(void(^)(NSString *city))completionHandler;

@end
