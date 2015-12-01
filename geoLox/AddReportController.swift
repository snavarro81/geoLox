//
//  AddReportController.swift
//  geoLox
//
//  Add report... take picture, set location... add description. Submit
//
//  Created by snavarro on 11/25/15.
//  Copyright © 2015 snavarro. All rights reserved.
//

import UIKit
import QuartzCore

class AddReportController: UIViewController, geoMapDelegate {
    
    @IBOutlet weak var btnReport: UIButton!
    
    @IBOutlet weak var geoV: geoMap!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        geoV.delegate = self;
    
        btnReport.layer.cornerRadius = 10; // this value vary as per your desire
        btnReport.clipsToBounds = true;
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func regionDidChangeAnimated(controller: geoMap){
        
        //var a : String = "dsd"
        btnReport.hidden = false;
        
    }
    
    func mapTouchMove(controller: geoMap){
        btnReport.hidden = true;
        //var a : String = "dsd"
    }
}

