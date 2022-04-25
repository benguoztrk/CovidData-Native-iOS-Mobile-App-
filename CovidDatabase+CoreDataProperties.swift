//
//  CovidDatabase+CoreDataProperties.swift
//  BenguOzturk_Project
//
//  Created by Bengu H. Ozturk on 25.05.2021.
//  Copyright © 2021 Bengu H. Ozturk. All rights reserved.
//
//

import Foundation
import CoreData


extension CovidDatabase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CovidDatabase> {
        return NSFetchRequest<CovidDatabase>(entityName: "CovidDatabase")
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var date: String?
    @NSManaged public var descript: String?

}
