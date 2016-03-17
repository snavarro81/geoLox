//
//  ModalCategoryController.swift
//  geoLox
//
//  Created by snavarro on 1/15/16.
//  Copyright © 2016 snavarro. All rights reserved.
//

import UIKit
import Foundation

protocol CategoryModalDelegate{
    func myModalDidFinish(controller:ModalCategoryController, category:String)
}


class ModalCategoryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedCategory: String? = ""
    
    let categories =  [
        "Categoria 1"," Categoria 2"," Categoria 3"," Categoria 4"
        ,"Categoria 5"," Categoria 6"," Categoria 7"," Categoria 8"
        ,"Categoria 9"," Categoria 10"," Categoria 11"," Categoria 12"
        ,"Categoria 13"," Categoria 14"," Categoria 15"," Categoria 16"]
    
    let iconArray =  [
        UIImage(named: "icon"),UIImage(named: "icon"),UIImage(named: "icon"),UIImage(named: "icon")
        ,UIImage(named: "icon"),UIImage(named: "icon"),UIImage(named: "icon"),UIImage(named: "icon")
        ,UIImage(named: "icon"),UIImage(named: "icon"),UIImage(named: "icon"),UIImage(named: "icon")
        ,UIImage(named: "icon"),UIImage(named: "icon"),UIImage(named: "icon"),UIImage(named: "icon")
    ]
    
    override func viewDidLoad() {
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
    
    
    
    //var delegate:MyModalDelegate! = nil
    //Change the method submitResult() to use the delegate:
    //@IBAction func submitResult(sender: UIButton) {
        //dismissViewControllerAnimated(true, completion: nil)
        //delegate.myModalDidFinish(self, pie: pieString)
    //}
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as!
        CollectionViewCell
        cell.imageView?.image = self.iconArray[indexPath.row]
        cell.categoryName?.text = self.categories[indexPath.row]
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        //self.performSegueWithIdentifier("Report", sender: self)
        //self.dismissViewControllerAnimated(true, completion: nil)
        
        //delegate.myModalDidFinish(self, category: "")
        
        //var selectedLabel : UILabel? = nil
        
        
        let sCategory : String?  = self.categories[indexPath.row]
        
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as!
        //CollectionViewCell
        
        self.selectedCategory = sCategory
        
        SomeManager.sharedInstance.rptMainTitle = selectedCategory
        
        self.performSegueWithIdentifier("categorySelected", sender: self)
        
        //self.selectedCategory = cell.c
        // manipulate cell
        
        //self.selectedCategory = collec
        //self.performSegueWithIdentifier("colorSelected", sender: self)
    }
}
