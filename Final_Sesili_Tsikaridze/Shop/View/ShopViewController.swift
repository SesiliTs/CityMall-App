//
//  ShopViewController.swift
//  Final_Sesili_Tsikaridze
//
//  Created by Sesili Tsikaridze on 23.03.23.
//

import UIKit

class ShopViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    var amount = 0
    var price = 0
    
    var products = [[ProductsData.Product]] ()
    var cartItems: [CartItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
//        viewModel.view = self
        NetworkService.shared.getData { [weak self] data in
            guard let self = self else { return }

            let groupedProducts = Dictionary(grouping: data.products, by: { $0.category })
            let categories = groupedProducts.keys

            self.products = categories.map { category in
                return groupedProducts[category] ?? []
            }
            
            self.tableView.reloadData()
        }
    }
}

extension ShopViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShopTableViewCell
        let productSection = products[indexPath.section]
        let currentProduct = productSection[indexPath.row]

        cell.titleLabel.text = "\(currentProduct.title)"
        cell.priceLabel.text = "price: \(currentProduct.price) $"
        cell.stockLabel.text = "stock: \(currentProduct.stock)"
        cell.shopImage.loadFrom(stringUrl: "\(currentProduct.thumbnail)")
        cell.layer.borderColor = UIColor.systemGray5.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 16
        
        cell.addAmountLabel.text = "\(currentProduct.quantity)"
        cell.addAmountAction = {
            currentProduct.quantity += 1
            tableView.reloadData()
        }
        cell.removeAmountAction = {
            currentProduct.quantity -= 1
            tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        products[section].first?.category
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         50
     }
}

extension UIImageView {
    func loadFrom(stringUrl: String) {
        if let url = URL(string: stringUrl) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          guard let imageData = data else { return }
          DispatchQueue.main.async {
            self.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }
}


