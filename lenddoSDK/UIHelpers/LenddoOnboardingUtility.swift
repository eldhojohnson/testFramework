//
//  LenddoOnboardingUtility.swift
//  lenddo SDK
//
//  Created by iOS dev on 30/03/21.
//

public enum AuthorizationStatus {
    case success
    case failed
    case cancelled
}

import Foundation
import UIKit

public protocol LenddoAuthorizeDelegate : class{
    func onAuthorizeStarted()
    func onAuthorizeComplete(item: AuthorizationStatus)
    func onAuthorizeFailure(item: AuthorizationStatus)
    func onAuthorizeCancelled(item: AuthorizationStatus)
}

public class LenddoAuthorize : NSObject {
    
    var _applicationName = ""
    weak var delegate : LenddoAuthorizeDelegate?
    var presentingVC : UIViewController?
    
    public static let shared = LenddoAuthorize()
     
    public func generateRandomApplicationId(name: String, delegate : LenddoAuthorizeDelegate, presentingVC: UIViewController){
        self._applicationName = name
        self.delegate = delegate
        self.presentingVC = presentingVC
        self.delegate?.onAuthorizeStarted()
        self.generateApplicationIDAPI()
    }
    
    func showVC(presentingVC: UIViewController, token : String){
        DispatchQueue.main.async {
            if let navVC = UIStoryboard(name: "Permissions", bundle: Bundle(identifier: "com.lenddo.lenddoSDK")).instantiateInitialViewController() as? UINavigationController, let vc = navVC.topViewController as? PermissionsViewController{
                
                vc.lenddoAuthorizeObject = self
                vc.service_token = token
                navVC.modalPresentationStyle = .overFullScreen
                presentingVC.present(navVC, animated: true, completion: nil)
                
            }
        }
    
    }
    
    func generateApplicationIDAPI(){
        
        var params = [String:Any]()
        
        params = ["installation_id" : "31d9688c-9683-432d-8d98-9e66991a9de3","application_id" : _applicationName,"device_id" : UIDevice.current.identifierForVendor?.uuidString ?? "", "partner_script_id" : "5671d773aa961243c55ee6ad", "platform" : "ios"]
                
        NetworkHelper.shared.makeApiCall(url: generateToken, parameters: params, token: nil, method: "POST") { (data) in
            if let data = data as? [String:Any]{
                print("success")
                if let service_token = data["service_token"] as? String{
                    if let vc = self.presentingVC{
                        self.showVC(presentingVC: vc, token: service_token)
                    }
                }
                
            }else{
                print("error")
                self.delegate?.onAuthorizeFailure(item: .failed)
            }
        }
        
    }
    
    func dismissVC(){
        self.delegate?.onAuthorizeCancelled(item: .cancelled)
    }
    
    
}
