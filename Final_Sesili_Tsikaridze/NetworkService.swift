//
//  NetworkService.swift
//  Final_Sesili_Tsikaridze
//
//  Created by Sesili Tsikaridze on 23.03.23.
//

import Foundation


class NetworkService {
    
    static var shared = NetworkService()
    var session = URLSession()
    
    init() {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        self.session = urlSession
    }

        func getData(comletion: @escaping (ProductsData)->(Void)) {
            let urlsString = "https://dummyjson.com/products"
            let url = URL(string: urlsString)!
    
            session.dataTask(with: URLRequest(url: url)) { data, response, error in
    
                if let error = error {
                    print(error.localizedDescription)
                }
    
                guard let response = response as? HTTPURLResponse else {
                    return
                }
    
                guard (200...299).contains(response.statusCode) else {
                    print("wrong response")
                    return
                }
    
                guard let data = data else {
                    return
                }
    
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(ProductsData.self, from: data)
    
                    DispatchQueue.main.async {
                        comletion(object)
                    }
                } catch {
                    print(error)
                }
            }.resume()
        }

}

