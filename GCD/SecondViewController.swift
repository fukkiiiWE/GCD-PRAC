//
//  SecondViewController.swift
//  GCD
//
//  Created by Artur on 13.11.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    private var imageURL: URL?
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            return imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
    }
    
    private func delay(_ delay:Int, closure: @escaping () -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    
    
    
    
    private func loginAlert(){
        let ac = UIAlertController(title: "Registered?", message: "Input ur log and pass", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { usernameTF in
            usernameTF.placeholder = "Input log"
        }
        ac.addTextField { userPasswordTF in
            userPasswordTF.placeholder = "Input password"
            userPasswordTF.isSecureTextEntry = true
        }
        self.present(ac, animated: true, completion: nil)
    }
    
    
    
    
    
    
    private func fetchImage(){
        imageURL = URL(string: "https://hightech.fm/wp-content/uploads/2022/03/solar_orbiter_pillars.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL,let imageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}


