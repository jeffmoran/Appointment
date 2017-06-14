#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
	MKPointAnnotation *locationAnnotation;
	UIBarButtonItem *zoomToUserLocationButton;
	MKMapView *mapView;
}

@property (nonatomic, strong) NSString *address;

@end
