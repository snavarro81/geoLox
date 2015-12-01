//
//  ViewController.swift
//  geoLox
//
//
//
//
//  Created by snavarro on 11/25/15.
//  Copyright © 2015 snavarro. All rights reserved.
//

import UIKit
import MapKit


//struct Constants{
//    static let embedSegue = "embedSegue"
//}


//class ReportsListController: UIViewController , MKMapViewDelegate{
class ReportsListController: UIViewController , geoMapDelegate {
    
    @IBOutlet weak var geoV: geoMap!
    
    //let geoV = geoMap(nibName: "geoMap", bundle: nil)
    
    //@IBOutlet weak var mapView: MKMapView!
    //@IBOutlet weak var image: UIImageView!
    
    //var target: pinPointMarker
    //var centerAnnotation: MKPointAnnotation = MKPointAnnotation();
    //var initialLoc: CLLocation = CLLocation();
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    //func regionDidChangeAnimated(controller: geoMap){
        //
    //}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        geoV.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //initialLoc = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        //centerMapOnLocation(initialLoc);
        
        //listMapView.delegate = self;
        
        //let target: MKPointAnnotation = MKPointAnnotation()
        //target.coordinate = listMapView.centerCoordinate
        //target.title = "Target"
        //target.subtitle = "\(target.coordinate.latitude), \(target.coordinate.longitude)"
        //listMapView.addAnnotation(target)
        //self.centerAnnotation = target
        
    }
    
    //override func didReceiveMemoryWarning() {
    //    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    //}
    
    
    //func centerMapOnLocation(location : CLLocation){
        //    let regionRadius : CLLocationDistance = 1000
        
        //  let coordinateRegion  =  MKCoordinateRegionMakeWithDistance(location.coordinate,
        //     regionRadius * 2.0, regionRadius * 2.0  )
        
        //        listMapView.setRegion(coordinateRegion, animated: true)
    //}
    
    //func screenSize() -> CGSize {
    //    let screenSize = UIScreen.mainScreen().bounds.size
    //    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation) {
    //        return CGSizeMake(screenSize.height, screenSize.width)
    //    }
    //    return screenSize
   //}
    
    //func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool){
    //centerMapOnLocation(initialLoc);
    //self.centerAnnotation.coordinate = mapView.centerCoordinate
    //self.centerAnnotation.subtitle = "\(centerAnnotation.coordinate.latitude), \(centerAnnotation.coordinate.longitude)"
    
    //mapView.region.center
    
    //The MKAnnotationView class is responsible for presenting annotations visually in a map view.
    //Annotation views are loosely coupled to a corresponding annotation object, which is an object that corresponds to the MKAnnotation protocol.
    //When an annotation’s coordinate point is in the visible region, the map view asks its delegate to provide a corresponding annotation view. Annotation views may be recycled later and put into a reuse queue that is maintained by the map view.
    //}
    
    func regionDidChangeAnimated(controller: geoMap){
    
        //var a : String = "dsd"
    }
    
    
    func mapTouchMove(controller: geoMap){
        
        //var a : String = "dsd"
    }
}








