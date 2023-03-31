//
//  ShopModel.swift
//  Final_Sesili_Tsikaridze
//
//  Created by Sesili Tsikaridze on 23.03.23.
//

import Foundation

struct CartItem {
    let product: ProductsData.Product
    var quantity: Int
}

struct ProductsData: Codable {
    
    let products: [Product]
    
    class Product: Codable {
        var id: Int
        var title: String
        var price: Int
        var stock: Int
        var category: String
        var thumbnail: String
        var quantity: Int
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
            case price
            case stock
            case category
            case thumbnail
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            price = try container.decode(Int.self, forKey: .price)
            stock = try container.decode(Int.self, forKey: .stock)
            category = try container.decode(String.self, forKey: .category)
            thumbnail = try container.decode(String.self, forKey: .thumbnail)
            quantity = 0
        }
    }
}
