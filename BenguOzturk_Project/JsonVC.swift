//
//  JsonVC.swift
//  BenguOzturk_Project
//
//  Created by Bengu H. Ozturk on 25.05.2021.
//  Copyright © 2021 Bengu H. Ozturk. All rights reserved.
//

import UIKit

class JsonVC: UIViewController {
    

    @IBOutlet weak var mTableView: UITableView!
    
    let mJSONDataSource = DataSource()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           //print("Inside Prepare")
           
           if segue.identifier == "detailJSON" {
               if let indexPath = getIndexPathForSelectedRow() {
                   let record = mJSONDataSource.itemsInCategory(index: indexPath.section)[indexPath.row]
                   
                   let coviddetailVC = segue.destination as!CovidDetailVC
                   
                   coviddetailVC.mRecord = record
               }
           }
        
       }
    func getIndexPathForSelectedRow() -> IndexPath? {
        var indexPath: IndexPath?
        
        if mTableView.indexPathsForSelectedRows!.count > 0 {
            indexPath = mTableView.indexPathsForSelectedRows![0] as IndexPath
        }
        
        return indexPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mJSONDataSource.populate(type: "json")
    }

}


extension JsonVC: UITableViewDataSource, UITableViewDelegate {
    
     func numberOfSections(in tableView: UITableView) -> Int {
           //print("sections = \(mJSONDataSource.numberOfCategories())")
           return mJSONDataSource.numberOfCategories()
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return mJSONDataSource.numbeOfItemsInEachCategory(index: section)
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let records: [Record] = mJSONDataSource.itemsInCategory(index: indexPath.section)
        let record = records[indexPath.row]
        
        cell.mImageView?.image = UIImage(named: record.image.capitalized)
        cell.mLabel?.text = record.Country.capitalized
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           
           let label : UILabel = UILabel()
           
           label.text = mJSONDataSource.getCategoryLabelAtIndex(index: section)
           label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
           label.textAlignment = .center
           // Color Literal
           label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           label.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
           
           return label
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100.0
       }
       
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 40.0
       }
    
    
}
