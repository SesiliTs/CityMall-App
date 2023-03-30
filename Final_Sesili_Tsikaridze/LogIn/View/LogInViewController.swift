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
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShopVC") as! ShopViewController
//        let currentPost = viewModel.posts[indexPath.row]
//        let viewModel = CommentsViewModel(postId: currentPost.id)
//
//        vc.viewModel = viewModel
//        viewModel.view = vc
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}





