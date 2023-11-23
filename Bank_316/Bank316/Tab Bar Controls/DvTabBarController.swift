//
//  DvTabBarController.swift
//  Bank 316
//
//  Created by Dhairya on 04/10/23.
//

import Foundation
import UIKit

class DvTabBarController : UITabBarController {
    
    var menuButton : UIButton? = nil
    var home: HomeVC = HomeVC.instantiateViewController(identifier: .home)
    var wallet : WalletVC = WalletVC.instantiateViewController(identifier: .home)
    var bank316: MainBankVC = MainBankVC.instantiateViewController(identifier: .home)
    var recepients: RecepientsVC = RecepientsVC.instantiateViewController(identifier: .home)
    var account: AccountVC = AccountVC.instantiateViewController(identifier: .home)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMiddleButton()
        self.tabBar.setRoundedManualTopCorners(cornerRadius: 20)
        self.tabBar.layer.masksToBounds = true
        self.customTab()
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.selectedImage = UIImage(named: "selectedHome")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.title = "Home"
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "wallet")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "wallet")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.title = "Wallet"
        //        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        //        myTabBarItem3.image = UIImage(named: "logo-Shadow")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        //        myTabBarItem3.selectedImage = UIImage(named: "logo-Shadow")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        //        //        logo-Shadow
        let myTabBarItem4 = (self.tabBar.items?[3])! as UITabBarItem
        myTabBarItem4.image = UIImage(named: "receipt-item")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem4.selectedImage = UIImage(named: "receipt-itemr")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem4.title = "Recepients"
        let myTabBarItem5 = (self.tabBar.items?[4])! as UITabBarItem
        myTabBarItem5.image = UIImage(named: "profile")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem5.selectedImage = UIImage(named: "profile")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem5.title = "Account"
        home.tabBarItem = myTabBarItem1
        wallet.tabBarItem = myTabBarItem2
        //        bank316.tabBarItem = myTabBarItem3
        recepients.tabBarItem = myTabBarItem4
        account.tabBarItem = myTabBarItem5
        home.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        wallet.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        bank316.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -18, right: 0)
        recepients.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        account.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        let tabBarList = [home, wallet, bank316, recepients, account]
        self.setViewControllers(tabBarList, animated: true)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        self.tabBar.tintColor = .white
        self.tabBar.barTintColor = UIColor(red: 22/255, green: 51/255, blue:0 ,alpha:1)
        self.tabBar.barStyle = UIBarStyle.black
        self.selectedIndex = 0
        if let items = self.tabBar.items {
            let numItems = CGFloat(items.count)
            let itemSize = CGSize(
                width: (tabBar.frame.width / numItems)+1,
                height: tabBar.bounds.height + 1)
            
        }
    }
    
    func setupMiddleButton() {
        guard menuButton == nil else {return}
        menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        menuButton?.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        menuButton?.setImage(UIImage(named: "centreButton"), for: .normal)
        menuButton?.sizeToFit()
        menuButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(menuButton!, aboveSubview: tabBar)
        tabBar.centerXAnchor.constraint(equalTo: menuButton!.centerXAnchor).isActive = true
        tabBar.topAnchor.constraint(equalTo: menuButton!.centerYAnchor, constant: -40).isActive = true
        view.layoutIfNeeded()
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        print("Middle")
    }
    
    
    private func customTab(){
        let path = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.clear.cgColor
        shape.fillColor = UIColor.init(red: 44/255, green: 70/255, blue: 24/255, alpha: 1).cgColor
        
        // Set the bounds and position of the shape layer
        shape.bounds = self.tabBar.bounds
        shape.position = CGPoint(x: self.tabBar.bounds.midX, y: self.tabBar.bounds.midY)
        
        // Add the shape layer to the tab bar's layer
        self.tabBar.layer.insertSublayer(shape, at: 0)
    }
    
    
    func getPathForTabBar() -> UIBezierPath {
        let frameWidth = self.tabBar.bounds.width
        let frameHeight = self.tabBar.bounds.height + 20
        let holeWidth = frameWidth * 0.6 // Adjust the width of the cutout
        let holeHeight = 100 // Height of the cutout
        let leftXUntilHole = (frameWidth - holeWidth) / 2

        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: leftXUntilHole, y: 0)) // Start of the path

        // Curve for the rounded top-left corner
        path.addQuadCurve(to: CGPoint(x: leftXUntilHole + holeWidth / 2, y: -CGFloat(holeHeight)), controlPoint: CGPoint(x: leftXUntilHole, y: -CGFloat(holeHeight)))

        // Curve for the rounded top-right corner
        path.addQuadCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint: CGPoint(x: leftXUntilHole + holeWidth, y: -CGFloat(holeHeight)))

        path.addLine(to: CGPoint(x: frameWidth, y: 0)) // Top-right corner of the frame
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight)) // Bottom-right corner of the frame
        path.addLine(to: CGPoint(x: 0, y: frameHeight)) // Bottom-left corner of the frame
        path.close() // Complete the path

        return path
    }


    
    
//    func getPathForTabBar() -> UIBezierPath {
//        let frameWidth = self.tabBar.bounds.width
//        let frameHeight = self.tabBar.bounds.height + 20
//        let holeWidth = 150
//        let holeHeight = 50
//        let leftXUntilHole = Int(frameWidth/2) - Int(holeWidth/2)
//        print(leftXUntilHole)
//        let path : UIBezierPath = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: leftXUntilHole , y: 0)) // 1.Line
//        path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6,y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2)) // part I
//        
//        path.addCurve(to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4)) // part II
//        
//        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3,y: holeHeight/2), controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0)) // part III
//        path.addLine(to: CGPoint(x: frameWidth, y: 0)) // 2. Line
//        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight)) // 3. Line
//        path.addLine(to: CGPoint(x: 0, y: frameHeight)) // 4. Line
//        path.addLine(to: CGPoint(x: 0, y: 0)) // 5. Line
//        path.close()
//        return path
//    }
    
    
}
