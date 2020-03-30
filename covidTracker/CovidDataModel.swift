//
//  CovidDataModel.swift
//  covidTracker
//
//  Created by pradeep Kolli on 3/24/20.
//  Copyright © 2020 pradeep Kolli. All rights reserved.
//

import Foundation
 /// COVID Cases details
struct Cases: Codable{
    var newCases:String
    var activeCases:Int
    var criticalCases:Int
    var recoveredCases:Int
    var totalCases:Int
    
    ///COVID Cases codingkeys to check for additional JSON keys
    private enum CasesCodingKeys: String, CodingKey{
        case newCases = "new"
        case activeCases = "active"
        case criticalCases = "critical"
        case recoveredCases = "recovered"
        case totalCases = "total"
    }
    init(from decoder:Decoder) throws {
        let casesModel = try decoder.container(keyedBy: CasesCodingKeys.self)
        newCases = try casesModel.decodeIfPresent(String.self, forKey: .newCases) ?? "+0"
        activeCases = try casesModel.decodeIfPresent(Int.self, forKey: .activeCases) ?? 0
        criticalCases = try casesModel.decodeIfPresent(Int.self, forKey: .criticalCases) ?? 0
        recoveredCases = try casesModel.decodeIfPresent(Int.self, forKey: .recoveredCases) ?? 0
        totalCases = try casesModel.decodeIfPresent(Int.self, forKey: .totalCases) ?? 0
    }
    
}

///COVID Death Cases Registered
struct Deaths: Codable{
    var newDeaths:String
    var totalDeaths:Int
    
    private enum DeathsCodingKeys: String, CodingKey{
        case newDeaths = "new"
        case totalDeaths = "total"
    }
    init(from decoder:Decoder) throws {
        let deathsModel = try decoder.container(keyedBy:DeathsCodingKeys.self)
        newDeaths = try deathsModel.decodeIfPresent(String.self, forKey: .newDeaths) ?? "+0"
        totalDeaths = try deathsModel.decodeIfPresent(Int.self, forKey: .totalDeaths) ?? 0
    }
}

/// COVID Cases recorded 
struct Countries: Codable{
    var countryName:String
    var cases:Cases
    var deaths:Deaths
    
    private enum CountriesCodingKeys: String, CodingKey{
        case countryName = "country"
        case cases
        case deaths
    }
    init(from decoder:Decoder) throws {
        let countriesModel = try decoder.container(keyedBy:CountriesCodingKeys.self)
        countryName = try countriesModel.decodeIfPresent(String.self, forKey: .countryName) ?? "--"
        cases =  try countriesModel.decodeIfPresent(Cases.self, forKey: .cases)!
        deaths = try countriesModel.decodeIfPresent(Deaths.self,forKey: .deaths)!
    }
}

struct CovidCases: Codable {
    var response:[Countries]
    
    private enum CovidCasesCodingKeys: String, CodingKey{
        case response
    }
//    init(from decoder: Decoder) throws {
//        let covidCasesModel = try decoder.container(keyedBy: CovidCasesCodingKeys.self)
//        listOfCountries = try covidCasesModel.decodeIfPresent(Countries.self, forKey: .listOfCountries) ?? []
//    }
}
