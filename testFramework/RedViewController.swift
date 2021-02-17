//
//  RedViewController.swift
//  testFramework
//
//  Created by iOS dev on 16/02/21.
//

import UIKit

class RedViewController: UIViewController {
    
    @IBOutlet weak var btnObject: UIButton!
    var testHelperObject : TestVCHelper?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnObject.setTitle(testHelperObject?._id, for: .normal)
        
    }
    
    @IBAction func actionClose(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            self.testHelperObject?.dismissVC()
        })
        
       
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
