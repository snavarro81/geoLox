//
//  ModalCategoryController.swift
//  geoLox
//
//  Created by snavarro on 1/15/16.
//  Copyright © 2016 snavarro. All rights reserved.
//

import UIKit
import Foundation
import CoreData

protocol CategoryModalDelegate{
    func myModalDidFinish(controller:ModalCategoryController, category:String)
}



//read json content from file data.json
func getJsonCategoryData() -> [String : AnyObject] {
    let path : String! = NSBundle.mainBundle().pathForResource("data", ofType: "json")
    do {
        let data : NSData! =  try NSData(contentsOfFile:path!, options: NSDataReadingOptions.DataReadingUncached)
        let json: AnyObject! = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
        return json as! [String : AnyObject]
    } catch {
        return [:]
    }
}

class category {
    
    let id      : NSNumber
    let categoryName  : String
    let icon: String
    
    init(id: NSNumber, categoryName: String, icon : String ) {
        self.id             = id
        self.categoryName   = categoryName
        self.icon = icon
    }
}


class ModalCategoryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedCategory: String? = ""
    
    var aCategories : [AnyObject] = []

    override func viewDidLoad() {
        
        let jsonData = getJsonCategoryData()
        
        //print("JSON category data: \(json)")
        let employees = jsonData["categories"] as! [[String : AnyObject]]
        
        for employee in employees {
            let categoryId = employee["categoryId"] as! NSNumber
            let categoryName = employee["categoryName"] as! String
            let type = employee["typeId"] as! NSNumber
            let icon = employee["icon"] as! String
            
            aCategories.append(category(id: categoryId, categoryName: categoryName, icon: icon))
            
            //print("category: \(categoryId) \(categoryName)")
        }

        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    var delegate:CategoryModalDelegate! = nil
    
    @IBAction func BackAction(sender: AnyObject) {
        //self.dismissViewControllerAnimated(true, completion: nil)
        //delegate.myModalDidFinish(self, "1")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.dicCategoryIdName.count
        return self.aCategories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as!
        CollectionViewCell
        cell.imageView?.image = UIImage(named: (self.aCategories[indexPath.row] as! category).icon)
        cell.categoryName?.text = (self.aCategories[indexPath.row] as! category).categoryName
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        SomeManager.sharedInstance.rptMainTitle = selectedCategory
        self.performSegueWithIdentifier("categorySelected", sender: self)
    }
}
