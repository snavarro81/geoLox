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
import Alamofire

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


//Arrange your model classes
class Object {
    var id: Int = 182371823
}
class Animal: Object {
    var weight: Double = 2.5
    var age: Int = 2
    var name: String? = "An animal"
}
class Cat: Animal {
    var fur: Bool = true
}

class ModalCategoryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedCategory: String? = ""
    
    var aCategories : [AnyObject] = []

    override func viewDidLoad() {
        
        let jsonData = getJsonCategoryData()
        
        //print("JSON category data: \(json)")
        let employees = jsonData["categories"] as! [[String : AnyObject]]
        
        //loop through employees object, object value for "categories" key value
        for employee in employees {
            let categoryId = employee["categoryId"] as! NSNumber
            let categoryName = employee["categoryName"] as! String
            let type = employee["typeId"] as! NSNumber
            let icon = employee["icon"] as! String
            
            //array of objects
            aCategories.append(category(id: categoryId, categoryName: categoryName, icon: icon))
            
            //print("category: \(categoryId) \(categoryName)")
        }
        
        
        let m = Cat()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"fur\": true, \"weight\": 2.5, \"age\": 2, \"name\": \"An animal\", \"id\": 182371823}"
        
        let isEqual = (json == expected)
        //stringCompareHelper(json, expected) //returns true

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
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.imageView?.image = UIImage(named: (self.aCategories[indexPath.row] as! category).icon)
        
        cell.categoryName?.text = (self.aCategories[indexPath.row] as! category).categoryName
        
        self.selectedCategory = cell.categoryName?.text
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        SomeManager.sharedInstance.rptMainTitle = selectedCategory
        
        self.performSegueWithIdentifier("categorySelected", sender: self)
    }
    
    
    
    //----------------------------------------------------------------------------------------------------------------------------------
    //funcion para obtener las categorias desde el server... 
    //----------------------------------------------------------------------------------------------------------------------------------
    //Pasos...
    //1) Verificar cada cierto periodo
    //2) Si ya es fecha, contactar al server, con la fecha de hoy, para verificar si es que hay un nuevo file
    //3) retornar flag de si hay necesidad de actualizar, persistir en la app
    //4) si flag es true, obtener el nvo json con las categorias ...
    //5) persistir el archivo json con las categorias
    
    func obtenerCategoriasDeServer() -> [AnyObject]? {
        
        //enviar a cola concurrente
        let queue = dispatch_queue_create("com.cnoon.manager-response-queue", DISPATCH_QUEUE_CONCURRENT)
        
        let request = Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
        request.response(
            queue: queue,  //ejecuta en cola concurrente
            
            responseSerializer: Request.JSONResponseSerializer(options: .AllowFragments),
            
            completionHandler: { response in
                
                // You are now running on the concurrent `queue` you created earlier.
                print("Parsing JSON on thread: \(NSThread.currentThread()) is main thread: \(NSThread.isMainThread())")
                
                // Validate your JSON response and convert into model objects if necessary
                // Valido el JSON que retorna y lo convierto a mi modelo de objetos si es necesario
                print(response.result.value)
                
                // To update anything on the main thread, just jump back on like so.
                dispatch_async(dispatch_get_main_queue()) {
                    print("Am I back on the main thread: \(NSThread.isMainThread())")
                }
            }
        )

        return [];  //retorno diccionario con categorias, en forma de keyvalue array
    }
}
