#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
	BOOL firstLaunch;
	MKPointAnnotation *locationAnnotation;
}

@property (strong, nonatomic) MKMapView *mapView;
@property (nonatomic, strong) NSString *address;

@end
