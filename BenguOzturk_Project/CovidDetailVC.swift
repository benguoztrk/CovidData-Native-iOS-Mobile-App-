//
//  CovidDetailVC.swift
//  BenguOzturk_Project
//
//  Created by Bengu H. Ozturk on 25.05.2021.
//  Copyright © 2021 Bengu H. Ozturk. All rights reserved.
//

import UIKit

class CovidDetailVC: UIViewController {
    var mRecord: Record?
    
    
    @IBOutlet weak var mImageView2: UIImageView!
    
    @IBOutlet weak var mTextFieldTotalCases: UITextField!
    
    @IBOutlet weak var mTextFieldTotalDeaths: UITextField!
    
    @IBOutlet weak var mTextFieldTotalRecovered: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        if let tempRecord = mRecord {
            navigationItem.title = tempRecord.Country.capitalized
            
            mImageView2.image = UIImage(named: tempRecord.image.capitalized)
            
           mTextFieldTotalCases.text = String(tempRecord.TotalConfirmed)
            mTextFieldTotalDeaths.text = String(tempRecord.TotalDeaths)
            mTextFieldTotalRecovered.text = String(tempRecord.TotalRecovered)
           
            
        }
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
