//
//  Report+CoreDataProperties.swift
//  geoLox
//
//  Created by snavarro on 12/6/15.
//  Copyright © 2015 snavarro. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Report {
    @NSManaged var rptTitle: String?
    @NSManaged var rptDate: NSDate?
    @NSManaged var rptType: NSNumber?
    @NSManaged var rptDescription: String
    @NSManaged var rptLatitude: Double
    @NSManaged var rptLongitude: Double
    @NSManaged var rptPhotoId: NSNumber?
}
