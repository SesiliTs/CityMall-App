//
//  ViewController.swift
//  Final_Sesili_Tsikaridze
//
//  Created by Sesili Tsikaridze on 22.03.23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        let password = passwordTextField.text
        
        
        if isValidEmail(emailTextField.text ?? "") == true && password?.isEmpty == false {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShopVC") as! ShopViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            wrongMailAlert()
        }
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func wrongMailAlert() {
        let alert = UIAlertController(title: "wrong email", message: "email address format is wrong", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in } )
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func emptyPasswordField() {
        let alert = UIAlertController(title: "empty password field", message: "fill your password field", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in } )
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func emptyMailField() {
        let alert = UIAlertController(title: "empty email field", message: "fill your email field", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in } )
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
}





