//
//  MapViewController.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/16/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import MapKit

class MapViewController: UIViewController {

    // MARK: - Private Properties

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        mapView.delegate = self

        return mapView
    }()

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self

        return manager
    }()

    private lazy var changeMapTypeMenu: UIMenu = {
        let standardAction = UIAction(title: "Standard") { _ in
            self.mapView.mapType = .standard
        }

        let satelliteAction = UIAction(title: "Satellite") { _ in
            self.mapView.mapType = .satellite
        }

        let hybridAction = UIAction(title: "Hybrid") { _ in
            self.mapView.mapType = .hybrid
        }

        let actions = [hybridAction, satelliteAction, standardAction]

        return UIMenu(title: "Map Type", children: actions)
    }()

    private var addressString: String

    // MARK: - Initializers

    init(with addressString: String) {
        self.addressString = addressString

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = addressString
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never

        locationManager.requestWhenInUseAuthorization()

        addSubviews()
        setUpConstraints()
        setUpToolbar()
        performAddressSearchRequest()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setToolbarHidden(true, animated: true)
    }

    // MARK: - Private Methods

    private func addSubviews() {
        view.addSubview(mapView)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setUpToolbar() {
        navigationController?.setToolbarHidden(false, animated: true)

        var barItems = [UIBarButtonItem]()

        let zoomToUserLocationImage = UIImage(systemName: "location")
        let zoomToUserLocationButton = UIBarButtonItem(image: zoomToUserLocationImage, style: .plain, target: self, action: #selector(zoomToUserLocation))

        let zoomToLocationImage = UIImage(systemName: "house")
        let zoomToLocationButton = UIBarButtonItem(image: zoomToLocationImage, style: .plain, target: self, action: #selector(zoomToAddressLocation))

        let zoomToFitAnnotationsImage = UIImage(systemName: "mappin.circle")
        let zoomToFitAnnotationsButton = UIBarButtonItem(image: zoomToFitAnnotationsImage, style: .plain, target: self, action: #selector(zoomToFitAllAnnotations))

        let changeMapTypeImage = UIImage(systemName: "map")
        let changeMapTypeButton = UIBarButtonItem(image: changeMapTypeImage, menu: changeMapTypeMenu)

        let space: UIBarButtonItem = .flexibleSpace()

        barItems.append(contentsOf: [
            zoomToUserLocationButton,
            space,
            zoomToLocationButton,
            space,
            zoomToFitAnnotationsButton,
            space,
            changeMapTypeButton
        ])

        toolbarItems = barItems
    }

    private func performAddressSearchRequest() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = addressString
        request.region = mapView.region

        MKLocalSearch(request: request).start { response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            response?.mapItems.forEach {
                let placemark = $0.placemark

                let annotation = MKPointAnnotation()
                annotation.coordinate = placemark.coordinate
                annotation.title = "\(placemark.name ?? "") \(placemark.locality ?? "") \(placemark.postalCode ?? "")"

                self.mapView.addAnnotation(annotation)
            }

            self.zoomToFitAllAnnotations()
        }
    }

    private func deselectAllAnnotations() {
        mapView.annotations.forEach {
            mapView.deselectAnnotation($0, animated: true)
        }
    }

    @objc private func zoomToUserLocation() {
        zoomToCoordinate(mapView.userLocation.coordinate)
    }

    @objc private func zoomToAddressLocation() {
        let annotations = mapView.annotations.filter { $0 is MKPointAnnotation }

        guard let coordinate = annotations.first?.coordinate else { return }

        zoomToCoordinate(coordinate)
    }

    private func zoomToCoordinate(_ coordinate: CLLocationCoordinate2D) {
        deselectAllAnnotations()

        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let locationCoordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        let region = MKCoordinateRegion(center: locationCoordinate, span: coordinateSpan)

        mapView.selectAnnotation(mapView.userLocation, animated: true)
        mapView.setRegion(region, animated: true)
    }

    @objc private func zoomToFitAllAnnotations() {
        deselectAllAnnotations()

        mapView.showAnnotations(mapView.annotations, animated: true)
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    private static let identifier = "mapPoint"

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }

        var view = mapView.dequeueReusableAnnotationView(withIdentifier: MapViewController.identifier) as? MKPinAnnotationView

        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: MapViewController.identifier)
        }

        view?.canShowCallout = true
        view?.animatesDrop = true

        return view
    }
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .restricted, .denied:
            toolbarItems?.first?.isEnabled = false
        case .authorizedAlways, .authorizedWhenInUse, .notDetermined:
            break
        @unknown default:
            break
        }
    }
}
