//
//  ShopTableViewCell.swift
//  Final_Sesili_Tsikaridze
//
//  Created by Sesili Tsikaridze on 23.03.23.
//

import UIKit

class ShopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addAmountLabel: UILabel!
    
    var addAmountAction: (()->Void)?
    var removeAmountAction: (()->Void)?
    
    @IBAction func plusButton(_ sender: Any) {
        
        addAmountAction?()
        //        let intValue = Int(addAmountLabel.text!)
        //        let newValue = intValue! + 1
        //        addAmountLabel.text = "\(newValue)"
    }
    
    @IBAction func minusButton(_ sender: Any) {
        
        removeAmountAction?()
        //        if addAmountLabel.text != "0" {
        //            let intValue = Int(addAmountLabel.text!)
        //            let newValue = intValue! - 1
        //            addAmountLabel.text = "\(newValue)"
    }
}

