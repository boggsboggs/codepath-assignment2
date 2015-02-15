//
//  MapViewController.swift
//  Project
//
//  Created by Nidhi Kulkarni on 2/15/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var businesses : Array<Business>?
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let businesses = self.businesses {
            let centerLocation = CLLocationCoordinate2D(
                latitude: businesses[0].lat,
                longitude: businesses[0].long
            )
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: centerLocation, span: span)
            mapView.setRegion(region, animated: true)
            
            for business in businesses {
                let location = CLLocationCoordinate2D(
                    latitude: business.lat,
                    longitude: business.long
                )
                let annotation = MKPointAnnotation()
                annotation.setCoordinate(location)
                annotation.title = business.name
                annotation.subtitle = business.categories[0]
                mapView.addAnnotation(annotation)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
