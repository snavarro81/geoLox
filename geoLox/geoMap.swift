//
//  geoMap.swift
//  geoLox
//
//  Created by snavarro on 11/27/15.
//  Copyright © 2015 snavarro. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol geoMapDelegate{
        func regionDidChangeAnimated(controller: geoMap)
        func mapTouchMove(controller: geoMap)
        func mapTouchMoveEnded(controller: geoMap)
}


class geoMap: UIView, MKMapViewDelegate, CLLocationManagerDelegate  {
    
    //Outlets
    //Simplicity rules in swift. If you have a property defined 
    //that you want to make accessible to your storyboards,
    //just add the @IBOutlet attribute before your property.
    //Similarly with @IBAction to connect storyboard actions back to code.
    @IBOutlet weak var map: MKMapView!
    
    //
      let locationManager = CLLocationManager()
    
    // Our custom view from the XIB file
    var view: UIView!
    
    //var target: pinPointMarker
    var centerAnnotation: MKPointAnnotation = MKPointAnnotation();
    var initialLoc: CLLocation = CLLocation();
    
    //protocol delegate
    var delegate : geoMapDelegate?
    
    typealias WildcardGestureRecognizerHandler = ( touches: NSSet, event: UIEvent) -> ()
    
    var handler:WildcardGestureRecognizerHandler?
    
    //var mapHasUserInteraction = false
    //var userInteractionActive = false
    //var userInteractionTimer:NSTimer?
    
    
    //override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
    //    super.init(frame: frame)
        
        // 3. Setup view from .xib file
    //    xibSetup()
    //}
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    func getLocation() {
        
       let authStatus = CLLocationManager.authorizationStatus()
        
        if authStatus == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if authStatus == .Denied || authStatus == .Restricted {
            //showLocationServicesDeniedAlert()
            return
        }
        
        //if logoVisible {
            //hideLogoView()
        //}
        
        if updatingLocation {
            //stopLocationManager()
        } else {
            //location = nil
            //lastLocationError = nil
            //placemark = nil
            //lastGeocodingError = nil
            //startLocationManager()
        }
        
        //updateLabels()
        //configureGetButton()
    }
    
    
    
    
    //touches began handler
    func touchesBegan_handler(touches: NSSet, withEvent event: UIEvent) {
        // do your stuff
        //self.state = .Began
        self.delegate?.mapTouchMove(self)
    }
    
    
    //touches ended handler
    func touchesEnded_handler(touches: NSSet, withEvent event: UIEvent) {
        // do your stuff
        //self.state = .Began
        self.delegate?.mapTouchMoveEnded(self)
    }
    
    func xibSetup() {
        
        view = loadViewFromNib()
        
        initialLoc = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        centerMapOnLocation(initialLoc);
        
        let gestureObj = WildcardGestureRecognizer(target: self, action: "userInteractedWithMap")
        
        gestureObj.handlerTouchesBegan = touchesBegan_handler
        gestureObj.handlerTouchesEnded = touchesEnded_handler
        map.addGestureRecognizer(gestureObj)
        
        map.delegate = self;
        
        
        
        //let target: MKPointAnnotation = MKPointAnnotation()
        //t arget.coordinate = listMapView.centerCoordinate
        //target.title = "Target"
        //target.subtitle = "\(target.coordinate.latitude), \(target.coordinate.longitude)"
        //listMapView.addAnnotation(target)
        //self.centerAnnotation = target
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        
        
        
        getLocation()
    }
    
    //
    func userInteractedWithMap() {
        //self.userInteractionActive = true
        //self.mapHasUserInteraction = true
        //if !(self.userInteractionTimer==nil) {
        //    self.userInteractionTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "userInteractionUpdate", userInfo: nil, repeats: true)
        //}
    }
    
    //
    func userInteractionUpdate() {
        //if self.userInteractionActive {
        //    self.userInteractionActive = false
        //} else {
        //    self.userInteractionTimer?.invalidate()
        //    self.userInteractionTimer = nil
        //    self.mapHasUserInteraction = false
        //}
    }
    
    //Load view from Nib (xib file)
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "geoMap", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    
    
    //Center map on specified location
    func centerMapOnLocation(location : CLLocation){
        let regionRadius : CLLocationDistance = 1000
        
        let coordinateRegion  =  MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0  )
        
        map.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    
    // If you add custom drawing, it'll be behind any view loaded from XIB
    
    
    }
    
    
    //
    //mapView MKMapViewDelegate
    //
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool){
        
        //centerMapOnLocation(initialLoc);
        
        //self.centerAnnotation.coordinate = mapView.centerCoordinate
        //self.centerAnnotation.subtitle = "\(centerAnnotation.coordinate.latitude), \(centerAnnotation.coordinate.longitude)"
        
        //mapView.region.center
        
        //The MKAnnotationView class is responsible for presenting annotations visually in a map view.
        //Annotation views are loosely coupled to a corresponding annotation object, which is an object that corresponds to the MKAnnotation protocol.
        //When an annotation’s coordinate point is in the visible region, the map view asks its delegate to provide a corresponding annotation view. Annotation views may be recycled later and put into a reuse queue that is maintained by the map view.
        
        self.delegate?.regionDidChangeAnimated(self)
    }
}


