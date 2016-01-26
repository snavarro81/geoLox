//
//  ModalCategoryController.swift
//  geoLox
//
//  Created by snavarro on 1/15/16.
//  Copyright © 2016 snavarro. All rights reserved.
//

import UIKit
import Foundation

class ModalCategoryController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func BackAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
