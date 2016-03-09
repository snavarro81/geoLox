//
//  Report.swift
//  geoLox
//
//  Objeto reporte, contendra todos los datos del reporte
//  report object . it contains all data related to the report as atributes
//
//  Created by snavarro on 12/6/15.
//  Copyright © 2015 snavarro. All rights reserved.
//
import CoreData
import CoreLocation
import Foundation

class Report: NSManagedObject {
    
    var rptCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(rptLatitude, rptLongitude)
    }
    
   
    var rptMainTitle: String? {
        if rptTitle != nil {
            return "(No Description)"
        } else {
            return rptTitle
        }
    }
    
    
    var rptMainSubTitle: NSNumber? {
        return rptType
    }
    
    /*
    var hasPhoto: Bool {
        return photoID != nil
    }
    
    var photoPath: String {
        assert(photoID != nil, "No photo ID set")
        let filename = "Photo-\(photoID!.integerValue).jpg"
        return (applicationDocumentsDirectory as NSString).stringByAppendingPathComponent(filename)
    }
    
    var photoImage: UIImage? {
        return UIImage(contentsOfFile: photoPath)
    }
    
    class func nextPhotoID() -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let currentID = userDefaults.integerForKey("PhotoID")
        userDefaults.setInteger(currentID + 1, forKey: "PhotoID")
        userDefaults.synchronize()
        return currentID
    }
    
        func removePhotoFile() {
        if hasPhoto {
            let path = photoPath
            let fileManager = NSFileManager.defaultManager()
            if fileManager.fileExistsAtPath(path) {
                do {
                    try fileManager.removeItemAtPath(path)
                } catch {
                    print("Error removing file: \(error)")
                }
            }
        }
    }
    */
}
