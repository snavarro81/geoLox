//
//  ReportsListController
//  geoLox
//
//  Lista los markups de los reportes sobre el mapa.
//  Permite filtros.
//  Acceso a pantalla con lista
//
//  Created by snavarro on 11/25/15.
//

import UIKit
import MapKit

//struct Constants{
//    static let embedSegue = "embedSegue"
//}

//class ReportsListController: UIViewController , MKMapViewDelegate{
class ReportsListController: UIViewController , geoMapDelegate, CategoryModalDelegate {
    
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var geoV: geoMap!
    
    var selectedCategory: String? = ""
    
    //instancia referencia al objeto modal!
    //let pieVC = MyModalVC(nibName: "MyModalVC", bundle: nil)
    
    
    
    //let geoV = geoMap(nibName: "geoMap", bundle: nil)
    
    //@IBOutlet weak var mapView: MKMapView!
    //@IBOutlet weak var image: UIImageView!
    
    //var target: pinPointMarker
    //var centerAnnotation: MKPointAnnotation = MKPointAnnotation();
    //var initialLoc: CLLocation = CLLocation();
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    //func regionDidChangeAnimated(controller: geoMap){
    //
    //}
    
    
    //deinit {
    //    NSNotificationCenter.defaultCenter().removeObserver(self);
    //}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        geoV.delegate = self
        
        self.lblCategory?.text =  "sebas"
        
        
        //makeapppie.com/tag/modal-view-in-swift/
        //gracefullycoded.com/display-a-popover-in-swift/
        //pieVC.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //initialLoc = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        //centerMapOnLocation(initialLoc);
        
        //listMapView.delegate = self;
    }
    
    
    //override func didReceiveMemoryWarning() {
    //    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    //}
    
    
    //func centerMapOnLocation(location : CLLocation){
    //    let regionRadius : CLLocationDistance = 1000
    
    //  let coordinateRegion  =  MKCoordinateRegionMakeWithDistance(location.coordinate,
    //     regionRadius * 2.0, regionRadius * 2.0  )
    
    //        listMapView.setRegion(coordinateRegion, animated: true)
    //}
    
    //func screenSize() -> CGSize {
    //    let screenSize = UIScreen.mainScreen().bounds.size
    //    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation) {
    //        return CGSizeMake(screenSize.height, screenSize.width)
    //    }
    //    return screenSize
    //}
    
    //func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool){
    //centerMapOnLocation(initialLoc);
    //self.centerAnnotation.coordinate = mapView.centerCoordinate
    //self.centerAnnotation.subtitle = "\(centerAnnotation.coordinate.latitude), \(centerAnnotation.coordinate.longitude)"
    
    //mapView.region.center
    
    //The MKAnnotationView class is responsible for presenting annotations visually in a map view.
    //Annotation views are loosely coupled to a corresponding annotation object, which is an object that corresponds to the MKAnnotation protocol.
    //When an annotation’s coordinate point is in the visible region, the map view asks its delegate to provide a corresponding annotation view. Annotation views may be recycled later and put into a reuse queue that is maintained by the map view.
    //}
    
    func regionDidChangeAnimated(controller: geoMap){
        
        //var a : String = "dsd"
    }
    
    
    func mapTouchMove(controller: geoMap){
        
        //var a : String = "dsd"
    }
    
    func mapTouchMoveEnded(controller: geoMap) {
        //var a : String = "dsd"
    }
    
    //MARK - Delegate Methods
    func myModalDidFinish(controller: ModalCategoryController, category: String) {
        
        //statusLabel.text = "Order " + pie + " pie"
        //controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func unwindToViewController(sender: UIStoryboardSegue) {
        if (sender.identifier != nil) {
            if sender.identifier == "categorySelected" {
                let mController = sender.sourceViewController as! ModalCategoryController
                self.selectedCategory = mController.selectedCategory;
                dispatch_async(dispatch_get_main_queue()) {
                    self.lblCategory?.text = SomeManager.sharedInstance.rptMainTitle
                    
                }
                
                _ = setTimeout(0.05, block: { () -> Void in
                    // do this stuff after 0.35 seconds
                    self.performSegueWithIdentifier("report", sender: self)
                })
                
                // Later on cancel it
                //handle.invalidate()
            }
        }
    }
    
    func setTimeout(delay:NSTimeInterval, block:()->Void) -> NSTimer {
        return NSTimer.scheduledTimerWithTimeInterval(delay, target: NSBlockOperation(block: block), selector: "main", userInfo: nil, repeats: false)
    }

}








