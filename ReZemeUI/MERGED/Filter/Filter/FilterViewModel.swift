//
//  FilterViewModel.swift
//  ReZemeUI
//
//  Created by Shakhzod on 27/04/23.
//

import SwiftUI
import Combine

class FilterViewModel: ObservableObject {
    
    //MARK: - PROPERTIES
    
    @Published var searchText = ""
    @Published var bedroomsFilterValues: [String:Bool] = [
        "1": false,
        "2": false,
        "3": false,
        "4": false,
        "5 +": false
    ]
    @Published var bathroomsFilterValues: [String:Bool] = [ // Key: Title, Value: isSelected
        "1": false,
        "1.5": false,
        "2": false,
        "2.5": false,
        "3": false,
        "3.5 +": false
    ]
    @Published var totalUpfrontCost: String = "$400"
    @Published var totalMonthlyCost: String = "$400"
    @Published var amenitiesValues: [String:Bool] = [
        "Parking": false,
        "Doorman": false,
        "Gym": false,
        "Roof Deck": false,
        "Elevator Building": true,
        "Pool": false,
        "In-Unit Dishwasher": false,
        "Laundromat": false
    ]
    @Published var moveInDate: String = ""
    @Published var timeToWorkCount = 0
    
    
    //MARK: - method
    
    func deselectAll() {
        searchText = ""
        moveInDate = ""
        totalUpfrontCost = "$400"
        totalMonthlyCost = "$400"
        timeToWorkCount = 0
        bedroomsFilterValues = bedroomsFilterValues.mapValues({ _ in false})
        bathroomsFilterValues = bathroomsFilterValues.mapValues({ _ in false})
        amenitiesValues = amenitiesValues.mapValues({ _ in false})
    }
    
    func bedroomChangeValue(by key: String) {
        bedroomsFilterValues[key] = !(bedroomsFilterValues[key] ?? true)
    }
    
    func bathroomChangeValue(by key: String) {
        bathroomsFilterValues[key] = !(bathroomsFilterValues[key] ?? true)
    }
    
    func amenitiesChangeValue(by key: String) {
        amenitiesValues[key] = !(amenitiesValues[key] ?? true)
    }
    
    func applyAction() {}
}
