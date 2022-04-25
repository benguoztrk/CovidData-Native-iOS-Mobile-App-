//
//  Record.swift
// BenguOzturk_Project
//
//  Created by Bengu H. Ozturk on 25.05.2021.
//  Copyright © 2021 Bengu H. Ozturk. All rights reserved.
//

import Foundation

class Record {
    var Country: String
    var category: String
    var TotalConfirmed: Int
    var TotalDeaths: Int
    var TotalRecovered: Int
    var image: String
    
    init(Country: String, category: String, TotalConfirmed: Int, TotalRecovered: Int, TotalDeaths: Int ,image: String) {
        self.category = category
        self.Country = Country
        self.TotalConfirmed = TotalConfirmed
        self.TotalDeaths = TotalDeaths
        self.TotalRecovered = TotalRecovered
        self.image = image
    }
        
}
