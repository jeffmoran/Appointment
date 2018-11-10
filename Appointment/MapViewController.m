#import "MapViewController.h"

@implementation MapViewController

// MARK: - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self setUpMapView];
	
	MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
	request.naturalLanguageQuery = self.addressString;
	request.region = mapView.region;
	
	MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:request];
	
	[localSearch startWithCompletionHandler: ^(MKLocalSearchResponse *response, NSError *error) {
		if (!error) {
			for (MKMapItem *locationMapItem in response.mapItems) {
				locationAnnotation = [[MKPointAnnotation alloc] init];
				locationAnnotation.coordinate = locationMapItem.placemark.coordinate;
				locationAnnotation.title = [NSString stringWithFormat:@"%@ %@ %@", locationMapItem.placemark.name, locationMapItem.placemark.locality, locationMapItem.placemark.postalCode];
				[mapView addAnnotation: locationAnnotation];
			}
		} else {
			NSLog(@"Search Request Error: %@", error.localizedDescription);
		}
		
		[self zoomToFitMapAnnotations];
	}];
	
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	[locationManager requestWhenInUseAuthorization];
	
	self.title = self.addressString;

	[self setUpToolbar];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)setUpMapView {
	mapView = [[MKMapView alloc] init];
	mapView.translatesAutoresizingMaskIntoConstraints = NO;
	mapView.showsUserLocation = YES;
	mapView.delegate = self;
	
	[self.view addSubview:mapView];
	
	[NSLayoutConstraint
	 activateConstraints:@[
						   [mapView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
						   [mapView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
						   [mapView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
						   [mapView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
						   ]];
}

// MARK: - Toolbar methods

- (void)setUpToolbar {
	[self.navigationController setToolbarHidden:NO animated:YES];
	
	NSMutableArray *barItems = [[NSMutableArray alloc] init];
	
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																		   target:self
																		   action:nil];
	
	zoomToUserLocationButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"userLocation"]
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

	self.toolbarItems = barItems;
}

- (void)deselectAllAnnotations {
	for (MKPointAnnotation *annotation in mapView.selectedAnnotations) {
		[mapView deselectAnnotation:annotation animated:NO];
	}
}

- (void)zoomToLocation {
	[self deselectAllAnnotations];
	
	MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
	CLLocationCoordinate2D location = CLLocationCoordinate2DMake(locationAnnotation.coordinate.latitude, locationAnnotation.coordinate.longitude);
	MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
	
	[mapView selectAnnotation:locationAnnotation animated:YES];
	[mapView setRegion:region animated:YES];
}

- (void)zoomToUserLocation {
	[self deselectAllAnnotations];
	
	MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
	CLLocationCoordinate2D location = CLLocationCoordinate2DMake(mapView.userLocation.coordinate.latitude, mapView.userLocation.coordinate.longitude);
	MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
	
	[mapView selectAnnotation:mapView.userLocation animated:YES];
	[mapView setRegion:region animated:YES];
}

- (void)zoomToFitMapAnnotations {
	if (mapView.annotations.count == 0) {
		return;
	}
	
	[self deselectAllAnnotations];
	
	CLLocationCoordinate2D topLeftCoord;
	topLeftCoord.latitude = -90;
	topLeftCoord.longitude = 180;
	
	CLLocationCoordinate2D bottomRightCoord;
	bottomRightCoord.latitude = 90;
	bottomRightCoord.longitude = -180;
	
	for (MKPointAnnotation *annotation in mapView.annotations) {
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
	
	region = [mapView regionThatFits:region];
	[mapView setRegion:region animated:YES];
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
	
	[self presentViewController:actionView animated:YES completion:nil];
}

// MARK: - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[MKUserLocation class]]) {
		return nil;
	}
	
	static NSString *identifier = @"MapPoint";
	
	MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [aMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
	
	if (!annotationView) {
		annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
	}
	
	annotationView.canShowCallout = YES;
	annotationView.animatesDrop = YES;
	
	annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	
	return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Apple Maps"
																   message:@"Would you like to open this location in Maps?"
															preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes"
														style:UIAlertActionStyleDefault
													  handler:^(UIAlertAction *action) {
														  [self openAppleMaps];
													  }];
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No"
														   style:UIAlertActionStyleCancel
														 handler:nil];
	
	[alert addAction:yesAction];
	[alert addAction:cancelAction];
	
	[self presentViewController:alert animated:YES completion:nil];
}

- (void)openAppleMaps {
	NSMutableCharacterSet *allowedCharacterSet = [NSMutableCharacterSet alphanumericCharacterSet];
	
	NSURL *appleMapsURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?&daddr=%@", [locationAnnotation.title stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet]]];
	
	[[UIApplication sharedApplication] openURL:appleMapsURL options:@{} completionHandler:nil];
}

// MARK: - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
	NSLog(@"didChangeAuthorizationStatus");
	
	if (status == kCLAuthorizationStatusNotDetermined) {
		zoomToUserLocationButton.enabled = NO;
	} else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
		zoomToUserLocationButton.enabled = YES;
	} else {
		zoomToUserLocationButton.enabled = NO;
		
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
