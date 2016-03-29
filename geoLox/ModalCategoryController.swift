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

class category: NSManagedObject {
    var desc: String = ""
    var priority: Int = 0
    
    init(desc: String, priority: Int) {
        self.desc = desc
        self.priority = priority
    }
}


// left only 2 fields for demo
struct Business {
    var id : Int = 0
    var name = ""
}

var jsonStringAsArray = "[\n" +
    "{\n" +
    "\"id\":72,\n" +
    "\"name\":\"Batata Cremosa\",\n" +
    "},\n" +
    "{\n" +
    "\"id\":183,\n" +
    "\"name\":\"Caldeirada de Peixes\",\n" +
    "},\n" +
    "{\n" +
    "\"id\":76,\n" +
    "\"name\":\"Batata com Cebola e Ervas\",\n" +
    "},\n" +
    "{\n" +
    "\"id\":56,\n" +
    "\"name\":\"Arroz de forma\",\n" +
"}]"

var list:Array<Business> = []


// convert String to NSData
//var data: NSData = jsonStringAsArray.dataUsingEncoding(NSUTF8StringEncoding)!
//var error: NSError?

// convert NSData to 'AnyObject'
//let anyObj: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0),
//    error: &error)
//println("Error: \(error)")

// convert 'AnyObject' to Array<Business>
//list = self.parseJson(anyObj!)


func parseJson(anyObj:AnyObject) -> Array<Business>{
    
    var list:Array<Business> = []
    
    if  anyObj is Array<AnyObject> {
        
        var b:Business = Business()
        
        for json in anyObj as! Array<AnyObject>{
            b.name = (json["name"] as AnyObject? as? String) ?? "" // to get rid of null
            b.id  =  (json["id"]  as AnyObject? as? Int) ?? 0
            
            list.append(b)
        }// for
        
    } // if
    
    return list
    
}//func

func jsonResponse() -> [String : AnyObject] {
    let path : String! = NSBundle.mainBundle().pathForResource("data", ofType: "json")
    
    do {
        let data : NSData! =  try NSData(contentsOfFile:path!, options: NSDataReadingOptions.DataReadingUncached)
        
        let json: AnyObject! = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
        
        return json as! [String : AnyObject]
        
    } catch {
        return [:]
        
    }
}

func parseResponse() {
    let json = jsonResponse()
    print("JSON: \(json)")
    
    let employees = json["employees"] as! [[String : AnyObject]]
    
    for employee in employees {
        let firstName = employee["firstName"] as! String
        let lastName = employee["lastName"] as! String
        
        print("employee: \(firstName) \(lastName)")
    }
}


class ModalCategoryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedCategory: String? = ""
    
    //let dTest : [Int: category] = [ 1 : category(desc: "Categoria 1", priority: 1)]
    
    //constant dictionary to hold id:name categories values
    var dicCategoryIdName : [Int: String] = [
        1: "{desc:Categoria 1, prop: 1}"
        ,2: "{desc:Categoria 2, prop: 2}"
        ,3: "{desc:Categoria 3, prop: 3}"
    ]
    
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
        return self.dicCategoryIdName.count
        
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
        
        //let sCategory : String?  = self.categories[indexPath.row]
        
        //for (key , value ) in self.dicCategoryIdName{
        //    print (key)
        //    print (value.desc)
        //}
        
        //let sCategory : String?  = self.dicCategoryIdName[2]?.desc
        
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as!
        //CollectionViewCell
        
        //self.selectedCategory = sCategory
        
        
        
        parseResponse()
        
        SomeManager.sharedInstance.rptMainTitle = selectedCategory
        
        self.performSegueWithIdentifier("categorySelected", sender: self)
        
        //self.selectedCategory = cell.c
        // manipulate cell
        
        //self.selectedCategory = collec
        //self.performSegueWithIdentifier("colorSelected", sender: self)
        
        
        
        
        
        var dict : [String: AnyObject] = [:]
        dict["cat1"] = [ "id" : 1, "name": 100, "priority": 1]
        dict["cat2"] = [ "id" : 2, "name": 100, "priority": 2]
        dict["cat3"] = [ "id" : 3, "name": 100, "priority": 3]
        
        let jsonData   : NSData?
        do {
            jsonData = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
            
            let jsonString = NSString(data: jsonData!, encoding: NSUTF8StringEncoding)! as String
            print(jsonString)
        
        } catch _ {
            //Error handling, if needed
        }
    }
}
