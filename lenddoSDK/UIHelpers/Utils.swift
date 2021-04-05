//
//  Utils.swift
//  lenddoSDK
//
//  Created by iOS dev on 01/04/21.
//

import Foundation
import UIKit

class Utils {
    
    static let shared = Utils()

    func showAlertWithTitle(title:String?,andMessage message:String?, inView view:UIViewController){
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.view.tintColor = UIColor(red: 46.0/255.0, green: 70.0/255.0, blue: 126.0/255.0, alpha: 1)
            alertController.addAction(cancelAction)
            
            
            view.present(alertController, animated: true, completion: nil)
            
        }
        
        
    }
    
    func showNoInternetErrorWithTryAgain(view: UIViewController, tryAgain:@escaping () -> Void){
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: "No internet connection", message: "Please make sure WIFI or mobile data is turned on and try again.", preferredStyle: .alert)
            //
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let tryAction = UIAlertAction(title: "Retry", style: .default, handler: {
                
                (alert: UIAlertAction!) in
                
                tryAgain()
                
                
            })
            
            alertController.view.tintColor = UIColor(red: 46.0/255.0, green: 70.0/255.0, blue: 126.0/255.0, alpha: 1)
            alertController.addAction(cancelAction)
            alertController.addAction(tryAction)
            view.present(alertController, animated: true, completion: nil)
            
            
        }
        
    }
    
    
    func showAlertWithFunctionality(message: String, title : String, buttonTitle : String,view: UIViewController, fucntion:@escaping () -> Void) {
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            //
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let tryAction = UIAlertAction(title: buttonTitle, style: .default, handler: {
                
                (alert: UIAlertAction!) in
                
                fucntion()
                
                
            })
            
            
            
            alertController.view.tintColor = UIColor(red: 46.0/255.0, green: 70.0/255.0, blue: 126.0/255.0, alpha: 1)
            alertController.addAction(cancelAction)
            alertController.addAction(tryAction)
            view.present(alertController, animated: true, completion: nil)
            
            
        }
        
    }
    
    func showAlertWithSingleFunctionality(message: String, title : String, buttonTitle : String,view: UIViewController, fucntion:@escaping () -> Void) {
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            //
            
            
            let tryAction = UIAlertAction(title: buttonTitle, style: .default, handler: {
                
                (alert: UIAlertAction!) in
                
                fucntion()
                
                
            })
            
            
            
            alertController.view.tintColor = UIColor(red: 46.0/255.0, green: 70.0/255.0, blue: 126.0/255.0, alpha: 1)
            
            alertController.addAction(tryAction)
            view.present(alertController, animated: true, completion: nil)
            
            
        }
        
    }
    
    
    func showAlertWithTwoFunctionality(message: String, title : String,view: UIViewController, buttonOneTitle : String, fucntionOne:@escaping () -> Void, buttonTwoTitle : String, fucntionTwo:@escaping () -> Void) {
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            //
            let cancelAction = UIAlertAction(title: buttonOneTitle, style: .cancel, handler: {
                
                (alert: UIAlertAction!) in
                
                fucntionOne()
                
                
            })
            
            
            
            let tryAction = UIAlertAction(title: buttonTwoTitle, style: .default, handler: {
                
                (alert: UIAlertAction!) in
                
                fucntionTwo()
                
                
            })
            
            
            
            alertController.view.tintColor = UIColor(red: 46.0/255.0, green: 70.0/255.0, blue: 126.0/255.0, alpha: 1)
            alertController.addAction(cancelAction)
            alertController.addAction(tryAction)
            view.present(alertController, animated: true, completion: nil)
            
            
        }
        
    }
    
    
}
