//
//  AddNoteVc.swift
//  BenguOzturk_Project
//
//  Created by Bengu H. Ozturk on 25.05.2021.
//  Copyright © 2021 Bengu H. Ozturk. All rights reserved.
//

import UIKit

protocol AddNoteDelagete {
   func obtainData(controller: AddNoteVc, data: (name: String, surname: String, descript: String, date: String))
   
   }


class AddNoteVc: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    var delegate: AddNoteDelagete?
    
    @IBAction func mDidSave(_ sender: UIBarButtonItem) {
        var input1 = ""
        var input2 = ""
        var input3 = ""
        var input4 = ""
        
        if(nameTextField.text!.isEmpty || surnameTextField.text!.isEmpty || detailsTextField.text!.isEmpty || dateTextField.text!.isEmpty) {
            displayAlert(header: "Error", msg: "Input(s) cannot be empty")
        }
        else {
            input1 = nameTextField.text!
            input2 = surnameTextField.text!
            input3 = detailsTextField.text!
            input4 = dateTextField.text!
            
            delegate?.obtainData(controller: self, data: (input1, input2, input3, input4))
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
      }
    
   func displayAlert (header: String, msg: String) {
       // Creating an Alert and display the result
       let mAlert = UIAlertController(title: header, message: msg, preferredStyle: .alert)
       // Event Handler for the button
       mAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
       // Displaying the Alert
       self.present(mAlert, animated: true, completion: nil)
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
