//
//  NeighborhoodModel.swift
//  ReZemeUI
//
//  Created by Shakhzod on 26/04/23.
//

import Foundation

struct NeighborhoodModel {
    let id = Int.random(in: (0...50))
    let name: String
    let imageName: String
}


//TODO: - Remove

let neighMockData = [
    NeighborhoodModel(name: "Parks Nearby", imageName: "Park"),
    NeighborhoodModel(name: "School Rankings", imageName: "School"),
    NeighborhoodModel(name: "Points of Interest", imageName: "Outline"),
    NeighborhoodModel(name: "Commute Time", imageName: "smart-car")
]
