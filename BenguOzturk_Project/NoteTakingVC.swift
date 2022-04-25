//
//  NoteTakingVC.swift
// BenguOzturk_Project
//
//  Created by Bengu H. Ozturk on 25.05.2021.
//  Copyright © 2021 Bengu H. Ozturk. All rights reserved.
//

import UIKit
import CoreData

class NoteTakingVC: UIViewController, AddNoteDelagete, UpdateNoteDelagete {

    @IBOutlet weak var mTableView: UITableView!
    
    var mCovid = [CovidDatabase]()
    
    func obtainData(controller: AddNoteVc, data: (name: String, surname: String, descript: String, date: String)) {
        saveNewItem(name: data.name, surname: data.surname, descript: data.descript, date: data.date)
        self.mTableView.reloadData()
        controller.navigationController?.popViewController(animated: true)
        
    }
    
    
    func updateData(controller: UpdateNoteVC, data: (name: String, surname: String, descript: String, date: String)) {
        updateItem(name: data.name, surname: data.surname, descript: data.descript, date: data.date)
        
        func saveNewItem(name : String, surname : String, descript: String, date: String) {
        
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Create the new CovidDatabase item
            let newCovidItem = CovidDatabase.createInManagedObjectContext(context,
                                                                  name: name,
                                                                  surname: surname,
                                                                  date: date, descript: descript
                                                                  )
        
        // Update the array containing the table view row data
        fetchData()
        
        // Use Swift's FirstIndex function for Arrays to figure out the index of the newCovidItem
        // after it's been added and sorted in our mCovid array
        if let newCovidIndex = mCovid.firstIndex(of: newCovidItem) {
            // Create an NSIndexPath from the newCovidIndex
            let newCovidItemIndexPath = IndexPath(row: newCovidIndex, section: 0)
            // Animate in the insertion of this row
            mTableView.insertRows(at: [ newCovidItemIndexPath ], with: .automatic)
            
            save()
        }
    }
    self.mTableView.reloadData()
        controller.navigationController?.popViewController(animated: true)
    }
    
    func saveNewItem(name : String, surname : String, descript: String, date: String) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Create the new CovidDatabase item
        let newCovidItem = CovidDatabase.createInManagedObjectContext(context,
                                                                  name: name,
                                                                  surname: surname,
                                                                  date: date,
                                                                  descript: descript)
        
        // Update the array containing the table view row data
        fetchData()
        
        // Use Swift's FirstIndex function for Arrays to figure out the index of the newCovidItem
        // after it's been added and sorted in our mCovid array
        if let newCovidIndex = mCovid.firstIndex(of: newCovidItem) {
            // Create an NSIndexPath from the newCovidIndex
            let newCovidItemIndexPath = IndexPath(row: newCovidIndex, section: 0)
            // Animate in the insertion of this row
            mTableView.insertRows(at: [ newCovidItemIndexPath ], with: .automatic)
            
            save()
        }
    }
    
    
    func updateItem(name : String, surname : String, descript: String, date: String) {
        if let indexPath = getIndexPathForSelectedRow() {
            let covidToUpdate = mCovid[indexPath.row]
            covidToUpdate.name = name
            covidToUpdate.surname = surname
            covidToUpdate.descript = descript
            covidToUpdate.date = date
            
        }
        
        save()
    }
      
       func save() {
           let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           
           do {
               try context.save()
           } catch let error as NSError  {
               print("Could not save \(error), \(error.userInfo)")
           }
       }
       
       // function to fetch data from Core Data
       func fetchData() {
           let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CovidDatabase")
           
           do {
               let results = try context.fetch(fetchRequest)
               mCovid = results as! [CovidDatabase]
           } catch let error as NSError {
               print("Could not fetch \(error), \(error.userInfo)")
           }
           
       }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            if let vc = segue.destination as? AddNoteVc {
                vc.navigationItem.title = "Add New Vaccine Record"
                vc.delegate = self
            }
        }
        if segue.identifier == "update" {
            if let vc = segue.destination as? UpdateNoteVC {
                if let indexPath = getIndexPathForSelectedRow() {
                    vc.navigationItem.title = "Update Record"
                    vc.updateNote = mCovid[indexPath.row]
                    vc.delegate = self
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Vaccine Records"
        fetchData()
    }
    

}

extension NoteTakingVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mCovid.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        let covid = mCovid[indexPath.row]
        
        cell.textLabel?.text = covid.name! + " " + covid.surname!
        cell.detailTextLabel?.text = covid.descript! + " :  " + covid.date!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if(editingStyle == .delete ) {
            // Find the CovidDatabase object the user is trying to delete
            let covidToDelete = mCovid[indexPath.row]
            
            // Delete it from the managedObjectContext
            context.delete(covidToDelete)
            
            // Delete it from mCovid Array
            mCovid.remove(at: indexPath.row)
            
            // Tell the table view to animate out that row
            mTableView.deleteRows(at: [indexPath], with: .automatic)
            
            save()
        }
    }
    
    // function to have a reference to indexPath for the TableView
        func getIndexPathForSelectedRow() -> IndexPath? {
            var indexPath: IndexPath?
            
            if mTableView.indexPathsForSelectedRows!.count > 0 {
                indexPath = mTableView.indexPathsForSelectedRows![0] as IndexPath
            }
            
            return indexPath
    }
        
    
}
