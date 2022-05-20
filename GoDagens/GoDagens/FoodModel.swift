//
//  FoodModel.swift
//  GoDagens
//
//  Created by Sebastian Warvsten on 2022-05-20.
//

import Foundation
import FirebaseFirestoreSwift

struct FoodModel: Identifiable, Codable {
    var id: String?
    var name: String = "Ny maträtt"
    var imageURL: String = "https://source.unsplash.com/random/300x300"
    var descrip: String = "Laga till som vanligt bara"
    var ingrediets: Array = ["Tomat", "Sallad"]
    var time: Int = 10
}
