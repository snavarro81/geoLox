//
//  LocationController.swift
//  geoLox app
//
//  All geo-locations functions
//
//  Created by snavarro on 11/27/15.
//  Copyright © 2015 snavarro. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData
import QuartzCore
import AudioToolbox
import Foundation

let locationManager = CLLocationManager()
var location: CLLocation?
var updatingLocation = false
var lastLocationError: NSError?






