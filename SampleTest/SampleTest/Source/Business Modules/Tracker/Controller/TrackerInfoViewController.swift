//
//  TrackerInfoViewController.swift
//  SampleTest
//
//  Created by Mac HD on 24/10/19.
//  Copyright © 2019 HMSPL. All rights reserved.
//

import UIKit
import CoreLocation

class TrackerInfoViewController: BaseViewController {
    
    @IBOutlet weak var txtfieldFirstName: UITextField!
    @IBOutlet weak var txtfieldLastName: UITextField!
    @IBOutlet weak var txtfieldEmail: UITextField!
    @IBOutlet weak var lblAccountName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var scrollview: UIScrollView!
    
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
    }
    
    func configureData() {
        
        lblAccountName.text = UIDevice.current.name

        addKeypadDismiss()
        addPullToRefresh()
        setupLocationManager()
        
        txtfieldFirstName.delegate = self
        txtfieldLastName.delegate = self
        txtfieldEmail.delegate = self
    }
    
    func setupLocationManager() {
        
        locationManager = CLLocationManager()
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
        
    }
    
    func addPullToRefresh() {
        scrollview.refreshControl = UIRefreshControl()
        scrollview.refreshControl?.addTarget(self, action: #selector(refreshValuechanged), for: .valueChanged)
    }
    
    func addKeypadDismiss() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func refreshValuechanged() {
        
        self.locationManager.startUpdatingLocation()
        
        
    }
    
    func validateInputFields(fName: String, lName: String, email: String) -> Bool {
        
        var isPass: Bool = false
        
        if fName.isEmpty {
            self.showAlertMessage(message: " FirstName \(AlertConstant.nameEmpty)")
        }
        else if ((fName.count < 2 || fName.count > 15)) {
            self.showAlertMessage(title: "First Name", message: AlertConstant.validName, completionHandler: nil)
        }
        else if lName.isEmpty {
            self.showAlertMessage(message: " LastName \(AlertConstant.nameEmpty)")
        }
        else if (lName.count < 2 || lName.count > 15)
        {
            self.showAlertMessage(title: "Last Name", message: AlertConstant.validName, completionHandler: nil)
        }
        else if email.isEmpty {
            self.showAlertMessage(message: " Email \(AlertConstant.nameEmpty)")
        }
        else if !isValidEmail(emailStr: email)
        {
            self.showAlertMessage(message: AlertConstant.email)
        }
        else {
            isPass = true
        }
        
        return isPass
        
    }
    
    
    func getUserLocation(lat: CLLocationDegrees,long: CLLocationDegrees) {
        
        let loc: CLLocation = CLLocation(latitude: lat, longitude: long)
        
        CLGeocoder().reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                if let placeMark = placemarks {
                    
                    if let place = placeMark.first {
                        self.lblLocation.text = place.locality
                    }
                }
        })

        
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        
        if validateInputFields(fName: txtfieldFirstName.text ?? "", lName: txtfieldLastName.text ?? "", email: txtfieldEmail.text ?? "") {
            showToast(message: "Success")
        }
        else {
            print("Input validation failed")
        }
        
    }

}

extension TrackerInfoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField
        {
        case txtfieldFirstName:
            txtfieldLastName.becomeFirstResponder()
        case txtfieldLastName:
            txtfieldEmail.becomeFirstResponder()
        case txtfieldEmail:
            txtfieldEmail.resignFirstResponder()
        default:
            print("none")
        }
        
        return true
    }
}

extension TrackerInfoViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locCordinate: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        print("locations = \(locCordinate.latitude) \(locCordinate.longitude)")
        
        manager.stopUpdatingLocation()
        
        self.scrollview.refreshControl?.endRefreshing()
        
        getUserLocation(lat: locCordinate.latitude, long: locCordinate.longitude)
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            print("Location permission not authorized")
        }
    }
    
}
