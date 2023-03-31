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
    @IBOutlet weak var balance: UILabel!
    
    var currentBalance = 4500
    
    var totalAmount = 0
    var price = 0
    
    var products = [[ProductsData.Product]] ()
    var cartItems: [CartItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        tableView.dataSource = self
        tableView.delegate = self
        NetworkService.shared.getData { [weak self] data in
            guard let self = self else { return }
            let groupedProducts = Dictionary(grouping: data.products, by: { $0.category })
            let categories = groupedProducts.keys.sorted(by: >)
            self.products = categories.map { category in
                return groupedProducts[category] ?? []
            }
            self.tableView.reloadData()
        }
        
        balance.text = "\(currentBalance) $"
    }
    
    
    @IBAction func goToBasketButton(_ sender: Any) {
        let basketViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasketViewController") as! BasketViewController
        self.navigationController?.pushViewController(basketViewController, animated: true)
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
        cell.addAmountAction = { [self] in
            if currentProduct.quantity < currentProduct.stock {
                currentProduct.quantity += 1
                self.totalAmount += 1
                self.price += currentProduct.price
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            if let existingCartItemIndex = self.cartItems.firstIndex(where: { $0.product.id == currentProduct.id }) {
                self.cartItems[existingCartItemIndex].quantity += 1
            } else {
                let newCartItem = CartItem(product: currentProduct, quantity: 1)
                CartManager.shared.cartItems.append(newCartItem)
            }
            
        }
        cell.removeAmountAction = { [self] in
            if currentProduct.quantity > 0 {
                currentProduct.quantity -= 1
                self.totalAmount -= 1
                self.price -= currentProduct.price
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            var existingCartItemIndex: Int?
             for (index, cartItem) in CartManager.shared.cartItems.enumerated() {
                 if cartItem.product.id == currentProduct.id {
                     existingCartItemIndex = index
                     break
                 }
             }
             
             if let existingCartItemIndex = existingCartItemIndex {
                 var existingCartItem = CartManager.shared.cartItems[existingCartItemIndex]
                 existingCartItem.quantity -= 1
                 if existingCartItem.quantity == 0 {
                     CartManager.shared.cartItems.remove(at: existingCartItemIndex)
                 } else {
                     CartManager.shared.cartItems[existingCartItemIndex] = existingCartItem
                 }
             } else {
                 // Index of the existing cart item not found
                 print("Existing cart item not found")
             }
        }
        
        
        amountLabel.text = "\(totalAmount)x"
        totalPrice.text = "\(price) $"
        
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





