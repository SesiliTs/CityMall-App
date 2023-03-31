//
//  BasketViewController.swift
//  Final_Sesili_Tsikaridze
//
//  Created by Sesili Tsikaridze on 26.03.23.
//

import UIKit

class BasketViewController: UIViewController {
    
    
    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var priceAfterFees: UILabel!
    
    let cartItems = CartManager.shared.cartItems
    
    var price: Double = 0
    var fee: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basketTableView.dataSource = self
        basketTableView.delegate = self

    }
    
    
    @IBAction func payButton(_ sender: Any) {
        let paymentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        self.navigationController?.present(paymentViewController, animated: true)
    }
    
}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as! BasketTableViewCell
        let currentItem = cartItems[indexPath.row]
        
        cell.basketImageView.loadFrom(stringUrl: "\(currentItem.product.thumbnail)")
        cell.titleLabel.text = currentItem.product.title
        cell.amountLabel.text = "\(currentItem.quantity)"
        cell.priceLabel.text = "\(currentItem.product.price)"
        
        cell.layer.borderColor = UIColor.systemGray5.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 16
        
        price += Double(currentItem.product.price)
        fee = price * 0.1
        
        totalPrice.text = "\(Int(price)) $"
        feeLabel.text = "\(Int (fee)) $"
        priceAfterFees.text = "\(Int(price + fee + 15)) $"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        83
    }
    
    
    
}
