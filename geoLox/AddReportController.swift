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

class AddReportController: UIViewController, geoMapDelegate, UITextViewDelegate {
    
    @IBOutlet weak var btnSubmitReport: UIButton!
  
    @IBOutlet weak var geoV: geoMap!
    
    @IBOutlet weak var txt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        geoV.delegate = self;
        txt.delegate = self;
        
        
        //txt.backgroundColor = UIColor.clearColor();
        
        //this value vary as per your desire
        btnSubmitReport.layer.cornerRadius = 10;
        
        btnSubmitReport.clipsToBounds = true;
        
        
        
        //TODO
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
   
    //TODO
    //func keyboardWasShown(notification: NSNotification) {
    //    var info = notification.userInfo!
    //    var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
    //    UIView.animateWithDuration(0.1, animations: { () -> Void in
            //self.bottomConstraint.constant = keyboardFrame.size.height + 20
    //    })
    //}

    //func keyboardWillHide(notification: NSNotification) {
        //    var info = notification.userInfo!
        //    var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        //    UIView.animateWithDuration(0.1, animations: { () -> Void in
        //self.bottomConstraint.constant = keyboardFrame.size.height + 20
        //    })
    //}

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func regionDidChangeAnimated(controller: geoMap){
        btnSubmitReport.hidden = false;
    }
    
    func mapTouchMove(controller: geoMap){
        btnSubmitReport.hidden = true;
        //SomeManager.sharedInstance.
    }
    
    func mapTouchMoveEnded(controller: geoMap){
        btnSubmitReport.hidden = false;
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

