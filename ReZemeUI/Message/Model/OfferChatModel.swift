//
//  OfferChatModel.swift
//  ReZeme
//
//  Created by Shakhzod on 11/04/23.
//

import Foundation

struct OfferChatModel {
    var name: String = ""
    var address: String = ""
    var date: Date = Date()
    var cost: Int = 0
    var imageURLStr: String = ""
    
    var imageURL: URL? {
        return URL(string: imageURLStr)
    }
}

//https://images.coolhouseplans.com/plans/44207/44207-b600.jpg
