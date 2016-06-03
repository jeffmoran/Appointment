#import "MapViewController.h"
#import <ChameleonFramework/Chameleon.h>

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView, addressName;

#pragma mark - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Do any additional setup after loading the view, typically from a nib.
	
	//Instantiate a location object.
	locationManager = [[CLLocationManager alloc] init];
	
	//Make this controller the delegate for the location manager.
	locationManager.delegate = self;
	
	//Set some paramater for the location object.
	locationManager.distanceFilter = kCLDistanceFilterNone;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	
	[locationManager requestWhenInUseAuthorization];
	[locationManager requestLocation];
	
	MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
	request.naturalLanguageQuery = addressName;
	request.region = mapView.region;
	
	MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest: request];
	[localSearch startWithCompletionHandler: ^(MKLocalSearchResponse *response, NSError *error) {
		if (!error) {
			for (MKMapItem *mapItem in response.mapItems) {
				//NSLog(@"Name: %@, Placemark title: %@", [mapItem name], [[mapItem placemark] title]);
				
				MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
				annotation.coordinate = mapItem.placemark.coordinate;
				annotation.title = mapItem.name;
				[self.mapView addAnnotation: annotation];
				//NSLog(@"%@", mapItem);
				[self getDirections: mapItem];
			}
		} else {
			NSLog(@"Search Request Error: %@", error.localizedDescription);
		}
	}];
	
	self.title = addressName;

	firstLaunch = true;
}

- (void)viewDidUnload {
	[self setMapView: nil];
	[super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
	[self.navigationController setToolbarHidden: NO animated: YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getDirections:(MKMapItem *)destination {
	MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
	
	request.source = [MKMapItem mapItemForCurrentLocation];
	
	request.destination = destination;
	request.requestsAlternateRoutes = NO;
	MKDirections *directions = [[MKDirections alloc] initWithRequest: request];
	
	[directions calculateDirectionsWithCompletionHandler: ^(MKDirectionsResponse *response, NSError *error) {
		 if (error) {
			 NSLog(@"BIG ERROR %@", error);
		 }
		 else {
			 [self showRoute: response];
		 }
	 }];
}

- (void)showRoute:(MKDirectionsResponse *)response {
	for (MKRoute *route in response.routes) {
		[self.mapView addOverlay: route.polyline level: MKOverlayLevelAboveRoads];
		
		for (MKRouteStep *step in route.steps) {
			NSLog(@"%@", step.instructions);
		}
	}
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay {
	MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay: overlay];
	renderer.strokeColor = [UIColor flatRedColor];
	renderer.lineWidth = 5.0;
	
	return renderer;
}

#pragma mark - MKMapViewDelegate methods.

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
	if (firstLaunch) {
		MKCoordinateRegion region;
		MKCoordinateSpan span;
		span.latitudeDelta = 0.005;
		span.longitudeDelta = 0.005;
		CLLocationCoordinate2D location;
		location.latitude = aUserLocation.coordinate.latitude;
		location.longitude = aUserLocation.coordinate.longitude;
		region.span = span;
		region.center = location;
		[aMapView setRegion: region animated: YES];
		NSLog(@"Zooming");
	}
	
	firstLaunch = false;
}

# pragma mark-CLLocationManager Delegate Methods

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
	NSLog(@"%@", error);
}

@end