//
//  ReportData.swift
//  geoLox
//
//  Clase singleton para contener en memoria los datos del reporte en construccion
//
//  Created by snavarro on 1/25/16.
//  Copyright © 2016 snavarro. All rights reserved.
//

import Foundation

//Singleton object
class SomeManager {
    
    static let sharedInstance = SomeManager()
    
    var rptMainTitle : String?
    
    //get JSON fron report object in memory
    func reportToDictionary(report: Report) -> [String: NSObject] {
        let dict = [
            "latitude": NSNumber(double: report.rptCoordinate.latitude)
            ,"longitude": NSNumber(double: report.rptCoordinate.longitude)
            ,"description" : report.rptDescription as NSString
        ]
        
        if NSJSONSerialization.isValidJSONObject(dict) {
            print("dictPoint is valid JSON")
            
            // Do your Alamofire requests
            return dict
        }
        return [:]
    }
}

