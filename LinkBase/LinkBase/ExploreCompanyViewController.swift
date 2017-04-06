//
//  ExploreCompanyViewController.swift
//  LinkBase
//
//  Created by Rob Hernandez on 4/4/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ExploreCompanyViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager?.requestWhenInUseAuthorization()
        
        var mapCenter: CLLocationCoordinate2D
        
        if let location = self.currentLocation?.coordinate{
            mapCenter = location
        }else{
            mapCenter = CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667)
        }
        self.setMapRegion(mapCenter: mapCenter)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMapRegion(mapCenter: CLLocationCoordinate2D){
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
        
        self.mapView.setRegion(region, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Get current location

extension ExploreCompanyViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Updating with current location")
        self.currentLocation = locations[0]
        self.setMapRegion(mapCenter: (self.currentLocation?.coordinate)!)
        self.locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error trying to get gps: \(error.localizedDescription)")
    }
}
