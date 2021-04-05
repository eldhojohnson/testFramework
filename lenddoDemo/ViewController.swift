//
//  ViewController.swift
//  lenddoDemo
//
//  Created by iOS dev on 31/03/21.
//

import UIKit
import lenddoSDK

class ViewController: UIViewController {

    @IBOutlet weak var applicationIdTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applicationIdTextfield.text = "DEMObKBNWmc"

    }

    @IBAction func authenticateButtonAction(_ sender: UIButton) {
        if let text = applicationIdTextfield.text, text.trimmingCharacters(in: .whitespaces).count > 0{
            LenddoAuthorize.shared.generateRandomApplicationId(name: text.trimmingCharacters(in: .whitespaces), delegate: self, presentingVC: self)
        }else{
            print("invalid id")
        }
    }
    
}

extension ViewController : LenddoAuthorizeDelegate{
    
    func onAuthorizeStarted() {
        
    }
    
    func onAuthorizeComplete(item: AuthorizationStatus) {
        
    }
    
    func onAuthorizeFailure(item: AuthorizationStatus) {
        
    }
    
    func onAuthorizeCancelled(item: AuthorizationStatus) {
        
    }
    
}
