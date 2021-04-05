//
//  PermissionsViewController.swift
//  lenddo SDK
//
//  Created by iOS dev on 25/03/21.
//

import UIKit
import CoreLocation
import Contacts

class PermissionsViewController: UIViewController {

    @IBOutlet weak var areyouSureLabel: UILabel!
    var lenddoAuthorizeObject : LenddoAuthorize?
    
    var locationManager = CLLocationManager()
    var userLocation : CLLocation?
    var locationAuthStatus : CLAuthorizationStatus?
    
    var contactsStore = CNContactStore()
    var contactsArray = [CNContact]()
        
    var service_token : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attrText1 = NSMutableAttributedString(string: "All your personal information is kept 100% secure.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor.black])
        let attrText2 =  NSMutableAttributedString(string: " Do you want to allow the permissions?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor.black])
        attrText1.append(attrText2)
        areyouSureLabel.attributedText = attrText1
        
    }
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButtonAction(_ sender: UIButton) {
        fetchLocationData()
    }
    
    func checkDataFetchStatus(){
        if self.locationManager.authorizationStatus == .denied || self.locationManager.authorizationStatus == .restricted{
            print("error")
            locationAuthStatus = self.locationManager.authorizationStatus
            locationFetchCompleted()
        }
    }
    
    func fetchLocationData(){
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.stopUpdatingLocation()
        self.locationManager.startUpdatingLocation()
        self.checkDataFetchStatus()
        NotificationCenter.default.addObserver(self, selector: #selector(locationFetchCompleted), name: NSNotification.Name(rawValue: "locationFetched"), object: nil)
    }
    
    @objc func locationFetchCompleted(){
        print("fetchContacts")
        fetchContacts()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "locationFetched"), object: nil)
    }
    
    func fetchContacts(){
                
        contactsStore.requestAccess(for: .contacts, completionHandler: {
            granted, error in

            guard granted else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Can't access contact", message: "Please go to Settings -> App to enable contact permission", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }

            let keysToFetch: [CNKeyDescriptor] = [
                        CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                        CNContactPostalAddressesKey as CNKeyDescriptor,
                        CNContactEmailAddressesKey as CNKeyDescriptor,
                        CNContactPhoneNumbersKey as CNKeyDescriptor,
                        CNContactImageDataAvailableKey as CNKeyDescriptor,
                        CNContactThumbnailImageDataKey as CNKeyDescriptor]
            let request = CNContactFetchRequest(keysToFetch: keysToFetch)
            self.contactsArray.removeAll()

            do {
                try self.contactsStore.enumerateContacts(with: request){
                    (contact, cursor) -> Void in
                    self.contactsArray.append(contact)
                }
            } catch let error {
                NSLog("Fetch contact error: \(error)")
            }

            NSLog(">>>> Contact list:")
            for contact in self.contactsArray {
                let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? "No Name"
                NSLog("\(fullName): \(contact.phoneNumbers.description)")
            }
        })
    }
    
}

extension PermissionsViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization")
        manager.startUpdatingLocation()
        locationAuthStatus = status
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "locationFetched"), object: nil)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
      
        if let loc = locations.last{
            userLocation = loc
            locationManager.stopUpdatingLocation()
            locationUpdationAPICall(location: loc)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "locationFetched"), object: nil)
        }
      
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Denied \(error)")
        
    }
      
  
}
extension PermissionsViewController {
    
    func locationUpdationAPICall(location : CLLocation){
        
        var details = [String:Any]()
        
        details = ["mProvider":"gps","mTime": Int(Date().timeIntervalSince1970),"mLatitude": location.coordinate.latitude,"mLongitude": location.coordinate.longitude ,"mHasAltitude":true,"mAltitude":location.altitude,"mHasSpeed":true,"mSpeed":location.speed,"mHasBearing":true,"mBearing":0.0,"mHasAccuracy":true,"mAccuracy":10.0]
        
        var params = [String:Any]()
                                
        params = ["type":"location","details": details,"version": "1.0"]

        if let timeZone = TimeZone.current.abbreviation(){
            params["tz"] = timeZone
        }
        
        NetworkHelper.shared.makeApiCall(url: dataUpdation, parameters: params, token: service_token, method: "POST") { (data) in
            
            if let data = data as? [String:Any]{
                print("success")
               
            }else{
                print("error")
                
            }
        }
        
    }
}
