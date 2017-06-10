#import "MapViewController.h"
#import <ChameleonFramework/Chameleon.h>

@implementation MapViewController

@synthesize mapView, address;

#pragma mark - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self setUpMapView];

	MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
	request.naturalLanguageQuery = address;
	request.region = mapView.region;
	
	MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:request];

	[localSearch startWithCompletionHandler: ^(MKLocalSearchResponse *response, NSError *error) {
		if (!error) {
			for (MKMapItem *locationMapItem in response.mapItems) {
				locationAnnotation = [[MKPointAnnotation alloc] init];
				locationAnnotation.coordinate = locationMapItem.placemark.coordinate;
				locationAnnotation.title = [NSString stringWithFormat:@"%@ %@ %@", locationMapItem.placemark.name, locationMapItem.placemark.locality, locationMapItem.placemark.postalCode];
				[self.mapView addAnnotation: locationAnnotation];
				[self zoomToFitMapAnnotations];
				//	[self getDirectionsToMapItem:mapItem];
			}
		} else {
			NSLog(@"Search Request Error: %@", error.localizedDescription);
		}
	}];
	
	//Instantiate a location object.
	locationManager = [[CLLocationManager alloc] init];
	
	//Make this controller the delegate for the location manager.
	locationManager.delegate = self;
	
	//Set some paramater for the location object.
	locationManager.distanceFilter = kCLDistanceFilterNone;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	
	[locationManager requestWhenInUseAuthorization];

	self.title = address;
	
	firstLaunch = true;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[self.navigationController setToolbarHidden:NO animated:YES];
	
	NSMutableArray *barItems = [[NSMutableArray alloc] init];
	
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																		   target:self
																		   action:nil];
	
	UIBarButtonItem *zoomToUserLocationButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"userLocation"]
																				 style:UIBarButtonItemStylePlain
																				target:self action:@selector(zoomToUserLocation)];
	
	UIBarButtonItem *zoomToLocationButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"location"]
																			 style:UIBarButtonItemStylePlain
																			target:self action:@selector(zoomToLocation)];
	
	UIBarButtonItem *zoomToFitAnnotationsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zoomToFitAnnotations"]
																				   style:UIBarButtonItemStylePlain
																				  target:self action:@selector(zoomToFitMapAnnotations)];
	
	UIBarButtonItem *changeMapTypeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mapType"]
																			style:UIBarButtonItemStylePlain
																		   target:self action:@selector(changeMapType)];
	
	[barItems addObject:zoomToUserLocationButton];
	[barItems addObject:space];
	[barItems addObject:zoomToFitAnnotationsButton];
	[barItems addObject:space];
	[barItems addObject:zoomToLocationButton];
	[barItems addObject:space];
	[barItems addObject:changeMapTypeButton];
	
	if (!([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
		zoomToUserLocationButton.enabled = NO;
	} else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
		zoomToUserLocationButton.enabled = YES;
	}
	
	[self.navigationController.toolbar setItems:barItems animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[locationManager stopUpdatingLocation];
	[self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)setUpMapView {
	self.mapView = [[MKMapView alloc] init];
	self.mapView.translatesAutoresizingMaskIntoConstraints = NO;

	[self.view addSubview:mapView];

	[NSLayoutConstraint
	 activateConstraints:@[
						   [self.mapView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
						   [self.mapView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
						   [self.mapView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor],
						   [self.mapView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor],
						   ]];

}

#pragma mark - Toolbar methods

- (void)zoomToLocation {
	MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
	CLLocationCoordinate2D location = CLLocationCoordinate2DMake(locationAnnotation.coordinate.latitude, locationAnnotation.coordinate.longitude);
	MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
	
	NSArray *selectedAnnotations = mapView.selectedAnnotations;

	for (id annotation in selectedAnnotations) {
		[mapView deselectAnnotation:annotation animated:NO];
	}
	
	[mapView selectAnnotation:locationAnnotation animated:YES];
	[mapView setRegion:region animated:YES];
}

- (void)zoomToUserLocation {
	[locationManager stopUpdatingLocation];
	[locationManager startUpdatingLocation];
	NSLog(@"Zoom to user location");
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.005;
	span.longitudeDelta = 0.005;
	CLLocationCoordinate2D location;
	location.latitude = self.mapView.userLocation.coordinate.latitude;
	location.longitude = self.mapView.userLocation.coordinate.longitude;
	region.span = span;
	region.center = location;
	
	NSArray *selectedAnnotations = mapView.selectedAnnotations;

	for (id annotation in selectedAnnotations) {
		[mapView deselectAnnotation:annotation animated:NO];
	}
	
	[mapView selectAnnotation:mapView.userLocation animated:YES];
	
	[mapView setRegion:region animated:YES];
}

- (void)zoomToFitMapAnnotations {
	NSArray *selectedAnnotations = mapView.selectedAnnotations;

	for (id annotation in selectedAnnotations) {
		[mapView deselectAnnotation:annotation animated:NO];
	}
	
	[self zoomToFitMapAnnotations:mapView];
}

- (void)zoomToFitMapAnnotations:(MKMapView *)aMapView {
	[locationManager stopUpdatingLocation];
	dispatch_async(dispatch_get_main_queue(), ^{
		NSLog(@"Zoom to fit map annotations");
		
		if (aMapView.annotations.count == 0) {
			return;
		}
		
		CLLocationCoordinate2D topLeftCoord;
		topLeftCoord.latitude = -90;
		topLeftCoord.longitude = 180;
		
		CLLocationCoordinate2D bottomRightCoord;
		bottomRightCoord.latitude = 90;
		bottomRightCoord.longitude = -180;
		
		for (MKPointAnnotation *annotation in aMapView.annotations) {
			topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
			topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
			
			bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
			bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
		}
		
		MKCoordinateRegion region;
		region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
		region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
		region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1;
		region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1;
		
		region = [aMapView regionThatFits:region];
		[aMapView setRegion:region animated:YES];
	});
}

- (void)changeMapType {
	UIAlertController *actionView = [UIAlertController alertControllerWithTitle:@"Change Map Type"
																		message:nil
																 preferredStyle:UIAlertControllerStyleActionSheet];
	
	UIAlertAction *standard = [UIAlertAction actionWithTitle:@"Standard"
													   style:UIAlertActionStyleDefault
													 handler:^(UIAlertAction *action){
														 mapView.mapType = MKMapTypeStandard;
													 }];
	
	UIAlertAction *satellite = [UIAlertAction actionWithTitle:@"Satellite"
														style:UIAlertActionStyleDefault
													  handler:^(UIAlertAction *action){
														  mapView.mapType = MKMapTypeSatellite;
													  }];
	
	UIAlertAction *hybrid = [UIAlertAction actionWithTitle:@"Hybrid"
													 style:UIAlertActionStyleDefault
												   handler:^(UIAlertAction *action){
													   mapView.mapType = MKMapTypeHybrid;
												   }];
	
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
													 style:UIAlertActionStyleCancel
												   handler:nil];
	
	[actionView addAction:standard];
	[actionView addAction:satellite];
	[actionView addAction:hybrid];
	[actionView addAction:cancel];
	
	[self.navigationController presentViewController:actionView animated:YES completion:nil];
}

#pragma mark - MKMapViewDelegate methods.

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
	NSLog(@"User location: %f %f", aUserLocation.coordinate.longitude, aUserLocation.coordinate.latitude);
	//using firstLaunch BOOL to prevent constant zooming to user location
	if (firstLaunch) {
		if (locationAnnotation) {
			[self zoomToFitMapAnnotations:mapView];
			firstLaunch = false;
		}
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
	static NSString *identifier = @"MapPoint";
	MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
	
	if (!annotationView) {
		annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
	}
	
	if ([annotation isKindOfClass:[MKUserLocation class]]) {
		return nil;
	} else {
		annotationView.enabled = YES;
		annotationView.canShowCallout = YES;
		annotationView.animatesDrop = YES;
		
		annotationView.pinTintColor = FlatGreen;
		annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		
		return annotationView;
	}
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Apple Maps"
																   message:@"Would you like to open this location in Maps?"
															preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes"
														style:UIAlertActionStyleDefault
													  handler:^(UIAlertAction *action) {
														  //using dispatch_async to get rid of _BSMachError errors
														  dispatch_async(dispatch_get_main_queue(), ^{
															  [self openAppleMaps];
																});
													  }];
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No"
														   style:UIAlertActionStyleCancel
														 handler:nil];
	
	[alert addAction:yesAction];
	[alert addAction:cancelAction];
	
	[self presentViewController:alert animated:YES completion:nil];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay {
	MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
	renderer.strokeColor = [UIColor flatGreenColor];
	renderer.lineWidth = 4.0;
	
	return renderer;
}

#pragma mark - Directions/Route

- (void)openAppleMaps {
	NSMutableCharacterSet *allowedCharacterSet = [NSMutableCharacterSet alphanumericCharacterSet];
	
	NSURL *appleMapsURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?&daddr=%@", [locationAnnotation.title stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet]]];
	
	[[UIApplication sharedApplication] openURL:appleMapsURL options:@{} completionHandler:nil];
}

//- (void)getDirectionsToMapItem:(MKMapItem *)destination {
//	MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
//	
//	request.source = [MKMapItem mapItemForCurrentLocation];
//	
//	request.destination = destination;
//	request.requestsAlternateRoutes = NO;
//	
//	MKDirections *directions = [[MKDirections alloc] initWithRequest: request];
//	[directions calculateDirectionsWithCompletionHandler: ^(MKDirectionsResponse *response, NSError *error) {
//		if (error) {
//			NSLog(@"BIG ERROR %@", error);
//		}
//		else {
//			[self showRouteWithResponse: response];
//		}
//	}];
//}
//
//- (void)showRouteWithResponse:(MKDirectionsResponse *)response {
//	for (MKRoute *route in response.routes) {
//		[self.mapView addOverlay:route.polyline level: MKOverlayLevelAboveRoads];
//		
//		for (MKRouteStep *step in route.steps) {
//			NSLog(@"%@", step.instructions);
//		}
//	}
//}

# pragma mark - CLLocationManager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
	NSLog(@"didChangeAuthorizationStatus");

	if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
		[locationManager requestLocation];
	} else {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot get location"
																	   message:@"Please check your location permissions and try again."
																preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *action = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
													   handler:nil];
		
		[alert addAction:action];
		
		[self presentViewController:alert animated:YES completion:nil];
	}
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
	//CLLocation *location = locations.firstObject;
	//NSLog(@"First location: %@", location);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"%@", error);
}

@end
