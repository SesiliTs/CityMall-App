//
//  ShopModel.swift
//  Final_Sesili_Tsikaridze
//
//  Created by Sesili Tsikaridze on 23.03.23.
//

import Foundation

struct ProductsData: Codable {
    
    let products: [Product]
    
    struct Product: Codable {
        var id: Int
        var title: String
        var description: String
        var price: Int
        var discountPercentage: Float
        var rating: Double
        var stock: Int
        var brand: String
        var category: String
        var thumbnail: String
        var images: [String]
//        var chosenAmount: Int?

    }
    
}





//id : 1
//title : "iPhone 9"
//description : "An apple mobile which is nothing like apple"
//price : 549
//discountPercentage : 12.96
//rating : 4.69
//stock : 94
//brand : "Apple"
//category : "smartphones"
//thumbnail : "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
//images
