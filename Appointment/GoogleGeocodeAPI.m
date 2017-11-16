//
//  GoogleGeocodeAPI.m
//  Appointment
//
//  Created by Jeff Moran on 6/11/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

#import "GoogleGeocodeAPI.h"
#import "Config.h"
//Create a file called "Config.h" and add a NSString like so:

//NSString *const googleAPIKey = @"API_KEY_HERE";

@implementation GoogleGeocodeAPI

+ (void)requestCityWithZipCode:(NSString *)zipCode completionHandler:(void(^)(NSString *city))completionHandler {
	NSString *baseURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=%@", zipCode, googleAPIKey];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		NSURL *URL = [NSURL URLWithString:baseURL];
		
		NSURLRequest *request = [NSURLRequest requestWithURL:URL
												 cachePolicy:NSURLRequestReturnCacheDataElseLoad
											 timeoutInterval:60];
		
		NSURLSession *session = [NSURLSession sharedSession];
		NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			
			if (error) {
				NSLog(@"%@", error);
			} else {
				dispatch_async(dispatch_get_main_queue(), ^{
					completionHandler([self parseResponse:data]);
				});
			}
		}];
		
		[task resume];
	});
}

+ (NSString *)parseResponse:(NSData *)data {
	NSError *error;
	NSDictionary *mainresponseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
	
	if (!error) {
		NSDictionary *resultsDict = mainresponseDict[@"results"];
		
		NSArray *addressComponentsDict = [resultsDict valueForKey:@"address_components"];
		
		if (addressComponentsDict.count > 0) {
			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
			
			return [addressComponentsDict[0][1] valueForKey:@"long_name"];
		}
	}
	
	return @"";
}

@end
