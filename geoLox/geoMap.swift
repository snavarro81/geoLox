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
    
    
    var timer: NSTimer?
    let locationManager = CLLocationManager()
    var location: CLLocation?
    var updatingLocation = false
    
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
            stopLocationManager()
        } else {
            //location = nil
            //lastLocationError = nil
            //placemark = nil
            //lastGeocodingError = nil
            startLocationManager()
        }
        
        //updateLabels()
        //configureGetButton()
    }
    
    //start location manager
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            updatingLocation = true
            
            //updateLocationTimeOut()
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateLocationTimeOut"), userInfo: nil, repeats: false)
        }
    }
    
    //Update location time out
    func updateLocationTimeOut() {
        
        print("*** get update location time out")
        
        if location == nil {
            stopLocationManager()
            
            lastLocationError = NSError(domain: "MyLocationsErrorDomain", code: 1, userInfo: nil)
        }
        
        updateMapCenterLocation()
    
        stopLocationManager()
        
    }
    
    func updateMapCenterLocation() {
        if let location = location {
        
            print("Update Map center location")
        
            initialLoc = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            centerMapOnLocation(initialLoc);
            
            //let lat =  location.coordinate.latitude
            //let lon =  location.coordinate.longitude
        
            
            //self.centerAnnotation = target
        
        } else {
            
        }
    }
    
    //stop location manager
    func stopLocationManager() {
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
            
            if let timer = timer {
                timer.invalidate()
            }
        }
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
        
        //get current location
        getLocation()
        
        //initialLoc = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        //centerMapOnLocation(initialLoc);
        
        let gestureObj = WildcardGestureRecognizer(target: self, action: "userInteractedWithMap")
        
        gestureObj.handlerTouchesBegan = touchesBegan_handler
        gestureObj.handlerTouchesEnded = touchesEnded_handler
        map.addGestureRecognizer(gestureObj)
        
        map.delegate = self;
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        
        
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
        //let regionRadius : CLLocationDistance = 1000
        
        //let coordinateRegion  =  MKCoordinateRegionMakeWithDistance(location.coordinate,
        //    regionRadius * 2.0, regionRadius * 2.0  )
        
        //map.setRegion(coordinateRegion, animated: true)
        
        
        let span = MKCoordinateSpanMake(0.0025, 0.0025)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude), span: span)
        
        map.setRegion(region, animated: true)
        
        
       
        
        
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
        //Annotation views are loosely coubpled to a corresponding annotation object, which is an object that corresponds to the MKAnnotation protocol.
        //When an annotation’s coordinate point is in the visible region, the map view asks its delegate to provide a corresponding annotation view. Annotation views may be recycled later and put into a reuse queue that is maintained by the map view.
        
       
        let target: MKPointAnnotation = MKPointAnnotation()
        target.coordinate = map.centerCoordinate
        target.title = "Target"
        target.subtitle = "\(target.coordinate.latitude), \(target.coordinate.longitude)"
        
        map.addAnnotation(target)
        
        
        self.delegate?.regionDidChangeAnimated(self)
    }
    
    //Center map on user position
    @IBAction func showUser() {
        
        centerMapOnLocation(initialLoc);
        
        //let region = MKCoordinateRegionMakeWithDistance(map.userLocation.coordinate, 1000, 1000)
        //map.setRegion(map.regionThatFits(region), animated: true)
    }
    
    
    
    //
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("sdsds");
        
        //print("didUpdateLocations \(newLocation)")
        let newLocation = locations.last!
        
        if newLocation.timestamp.timeIntervalSinceNow < -5 {
            return
        }
        
        if newLocation.horizontalAccuracy < 0 {
            return
        }
        
        var distance = CLLocationDistance(DBL_MAX)
        if let location = location {
            distance = newLocation.distanceFromLocation(location)
        }
        
        
        if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
            
            lastLocationError = nil
            location = newLocation
            
            /*
            updateLabels()
            
            if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
                print("*** We're done!")
                stopLocationManager()
                configureGetButton()
                
                if distance > 0 {
                  performingReverseGeocoding = false
                }
            }
            
            if !performingReverseGeocoding {
            print("*** Going to geocode")
            
            performingReverseGeocoding = true
            
            geocoder.reverseGeocodeLocation(newLocation, completionHandler: {
            placemarks, error in
            
            //print("*** Found placemarks: \(placemarks), error: \(error)")
            
            self.lastGeocodingError = error
            if error == nil, let p = placemarks where !p.isEmpty {
            if self.placemark == nil {
            print("FIRST TIME!")
            self.playSoundEffect()
            }
            self.placemark = p.last!
            } else {
            self.placemark = nil
            }
            
            self.performingReverseGeocoding = false
            self.updateLabels()
            })
            }
            */
            
        }
        else if distance < 1.0 {
            
        //    print("dsdsd")
            
            /*
            let timeInterval = newLocation.timestamp.timeIntervalSinceDate(location!.timestamp)
            if timeInterval > 10 {
                print("*** Force done!")
                stopLocationManager()
                updateLabels()
                configureGetButton()
            }
            */
        }
    }
}


