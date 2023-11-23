//
//  SignUpProgressVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 03/11/23.
//

import UIKit

class SignUpProgressVC: UIViewController {
    
    var imageNames = ["signUpProgress1", "signUpProgress2", "signUpProgress3","signUpProgress4","signUpProgress1", "signUpProgress2", "signUpProgress3","signUpProgress4","signUpProgress5","signUpProgress6","signUpProgress7","signUpProgress8","signUpProgress9","signUpProgress10","signUpProgress11","signUpProgress12","signUpProgress13","signUpProgress10","signUpProgress11","signUpProgress12","signUpProgress13","signUpProgress14","signUpProgress15","signUpProgress16","signUpProgress17","signUpProgress18","signUpProgress19","signUpProgress20","signUpProgress21","signUpProgress22","signUpProgress19","signUpProgress20","signUpProgress21","signUpProgress22","signUpProgress23"]
    
    var imageArray:[UIImage] = []
    
    @IBOutlet weak var imageView: AnimationImageView!
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertToUIImage()
        AnimationImageView.action = {
            let vc: DvTabBarController = DvTabBarController.instantiateViewController(identifier: .home)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }

    
    func convertToUIImage(){
        self.imageArray = self.imageNames.map { data in
            if let newImage = UIImage(named: data) {
                
                return newImage
            }else{
                return UIImage()
            }
        }
        print(imageArray)
        imageView.animationImages = imageArray
        imageView.animationDuration = 2
        self.imageView.startAnimating()
    }
}



