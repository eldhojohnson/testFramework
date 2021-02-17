//
//  TestHelper.swift
//  testFramework
//
//  Created by iOS dev on 16/02/21.
//

import Foundation
import UIKit

public protocol TestVCHelperDelegate {
    func VCisPresented()
    func VCisDismissed()
}

public class TestVCHelper {
    
    var _id = ""
    var testDelegate : TestVCHelperDelegate?

    
   public init(identifier:String, delegate : TestVCHelperDelegate) {
        
        _id = identifier
        testDelegate = delegate
    }
    
    
    public func showVC(presentingVC: UIViewController){
      
        let storyboardBundle = Bundle(identifier: "in.vcoders.testFramework")
        let vc = UIStoryboard(name: "red", bundle: storyboardBundle).instantiateInitialViewController() as! RedViewController
    
        vc.testHelperObject = self
        
        presentingVC.present(vc, animated: true, completion: {
            self.testDelegate?.VCisPresented()
        })
        
    }
    
    
    func dismissVC(){
        self.testDelegate?.VCisDismissed()
        
    }
    
    
}
