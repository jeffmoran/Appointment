#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView, addressName;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Do any additional setup after loading the view, typically from a nib.
    
    //Instantiate a location object.
    locationManager = [[CLLocationManager alloc] init];
    
    //Make this controller the delegate for the location manager.
    [locationManager setDelegate:self];
    
    //Set some paramater for the location object.
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
	
	[locationManager requestWhenInUseAuthorization];
	[locationManager requestLocation];
	
	MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
	request.naturalLanguageQuery = addressName;
	request.region = mapView.region;
	
	MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:request];
	[localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
		if (!error) {
			for (MKMapItem *mapItem in [response mapItems]) {
				NSLog(@"Name: %@, Placemark title: %@", [mapItem name], [[mapItem placemark] title]);
				
				MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
				annotation.coordinate = mapItem.placemark.coordinate;
				annotation.title = mapItem.name;
				[self.mapView addAnnotation:annotation];
			}
		} else {
			NSLog(@"Search Request Error: %@", [error localizedDescription]);
		}
	}];
	
	self.title = addressName;
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - MKMapViewDelegate methods.

# pragma mark - CLLocationManager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
	if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
		[locationManager requestLocation];
	}
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
	CLLocation *location = locations.firstObject;
	NSLog(@"First location: %@", location);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog([NSString stringWithFormat:@"Error: %@", error]);
}

@end