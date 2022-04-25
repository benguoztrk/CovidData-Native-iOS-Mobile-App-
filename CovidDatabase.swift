//
//  CovidDatabase+CoreDataClass.swift
//  BenguOzturk_Project
//
//  Created by Bengu H. Ozturk on 25.05.2021.
//  Copyright © 2021 Bengu H. Ozturk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CovidDatabase)
public class CovidDatabase: NSManagedObject {
    class func createInManagedObjectContext(_ context: NSManagedObjectContext, name: String, surname: String, date: String, descript: String) -> CovidDatabase {
           let covidObject = NSEntityDescription.insertNewObject(forEntityName: "CovidDatabase", into: context) as! CovidDatabase
           covidObject.name = name
           covidObject.surname = surname
           covidObject.date = date
           covidObject.descript = descript
           
           return covidObject
       }
    

}
