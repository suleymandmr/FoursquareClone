//
//  MapVC.swift
//  FoursquareClone
//
//  Created by eyüp yaşar demir on 1.06.2023.
//

import UIKit
import MapKit
import Parse
class MapVC: UIViewController , MKMapViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
     
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked ))
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let recongnizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecongnizer:)))
        recongnizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(recongnizer)
        
    }
    @objc func chooseLocation(gestureRecongnizer: UIGestureRecognizer){
        if gestureRecongnizer.state == UIGestureRecognizer.State.began{
            let touches = gestureRecongnizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = placeModel.sharedInstance.placeName
            annotation.subtitle  = placeModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(annotation)
            
            placeModel.sharedInstance.placeLatitude = String(coordinates.latitude)
            placeModel.sharedInstance.placeLongitude = String(coordinates.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func saveButtonClicked() {
        let placeModel = placeModel.sharedInstance
        
        let object = PFObject(className: "Places")
        object["name"] = placeModel.placeName
        object["type"] = placeModel.placeType
        object["atmosphere"] = placeModel.placeAtmosphere
        object["latitude"] = placeModel.placeLatitude
        object["longitude"] = placeModel.placeLongitude
        
        if let imageData = placeModel.placeImage.jpegData(compressionQuality: 0.5){
            object["image"] = PFFileObject(name: "image.jpg", data: imageData)
        }
        
        object.saveInBackground {  success, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default , handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true ,completion: nil)
                
            }else{
                self.performSegue(withIdentifier:  "fromMapVCtoPlacesVC", sender: nil)
            }
        }
        
        
        
        
    }

    @objc func backButtonClicked() {
        self.dismiss(animated: true,completion: nil)
    }
}
