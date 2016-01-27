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
    
    var kbHeight: CGFloat!
    
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(false)
    }

    //TODO Move upwards txt textview in case keyboard is shown
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = keyboardSize.height - 150.00
                self.animateTextField(true)
            }
        }
    }
    
    func animateTextField(up: Bool) {
        let movement = (up ? -kbHeight : kbHeight)
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
    }

    //func keyboardWillHide(notification: NSNotification) {
        //    var info = notification.userInfo!
        //    var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        //    UIView.animateWithDuration(0.1, animations: { () -> Void in
        //self.bottomConstraint.constant = keyboardFrame.size.height + 20
        //    })
    //}
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    
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

