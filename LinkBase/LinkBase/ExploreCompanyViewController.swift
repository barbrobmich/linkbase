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
    
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var mapCenter: CLLocationCoordinate2D
        
        // switch this to pull from parse the user's address
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


