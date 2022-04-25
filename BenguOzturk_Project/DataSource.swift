//
//  DataSource.swift
//  BenguOzturk_Project
//
//  Created by Bengu H. Ozturk on 25.05.2021.
//  Copyright © 2021 Bengu H. Ozturk. All rights reserved.
//

import Foundation

class DataSource {
    var mCovidRecordList: [Record] = []
    var categories: [String] = []
    
    func numbeOfItemsInEachCategory(index: Int) -> Int {
        return itemsInCategory(index: index).count
    }
    
    func numberOfCategories() -> Int {
        return categories.count
    }
    
    func getCategoryLabelAtIndex(index: Int) -> String {
        return categories[index]
    }
    
    // MARK:- Populate Data from files
    
    func populate(type: String) {
        
        if type.lowercased() == "json" {
            if let path = Bundle.main.path(forResource: "covid19", ofType: "json") {
                if let jsonToParse = NSData(contentsOfFile: path) {
                    
                    guard let json = try? JSON(data: jsonToParse as Data) else {
                        print("Error with JSON")
                        return
                    }
                    //print(json)
                    for index in 0..<json["Countries"].count {
                        let country = json["Countries"][index]["Country"].string!
                        let category = json["Countries"][index]["category"].string!
                        let totalConfirmed = json["Countries"][index]["TotalConfirmed"].int!
                        let totalDeaths = json["Countries"][index]["TotalDeaths"].int!
                        let totalRecovered = json["Countries"][index]["TotalRecovered"].int!
                        let image = json["Countries"][index]["image"].string!
                        
                        let mRecord = Record(Country: country, category: category, TotalConfirmed: totalConfirmed, TotalRecovered: totalRecovered, TotalDeaths: totalDeaths, image: image)
                        
                        mCovidRecordList.append(mRecord)
                        
                        if !categories.contains(category) {
                            categories.append(category)
                        }
                    }
                }
                else {
                    print("NSData error")
                }
            }
            else {
                print("Path error")
            }
            
        }
    }
        // MARK:- itemsForEachGroup
        func itemsInCategory(index: Int) -> [Record] {
            let item = categories[index]
            
            let filteredItems = mCovidRecordList.filter { (record: Record) -> Bool in
                return record.category == item
            }
            
            return filteredItems
        }
        
    
}
