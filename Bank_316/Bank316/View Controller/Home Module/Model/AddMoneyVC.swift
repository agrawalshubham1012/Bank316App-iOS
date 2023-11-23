//
//  AddMoneyVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 10/11/23.
//

import UIKit

class AddMoneyVC: UIViewController {
    
    @IBOutlet weak var currenyWalletCollectionView: UICollectionView!
    @IBOutlet weak var freeLabel: UILabel!
    var currencyWalletData:[Wallet] = []
    var selectedCurrencyTitle:String?
    var selectedIndex:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setUI()
        print(currencyWalletData)
        print(selectedCurrencyTitle as Any)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectedIndex = 0
        DispatchQueue.main.async {
            self.currenyWalletCollectionView.reloadData()
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func registerCell(){
        self.currenyWalletCollectionView.register(UINib(nibName: "WalletCategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "WalletCategoryCollectionCell")
        self.currenyWalletCollectionView.delegate = self
        self.currenyWalletCollectionView.dataSource = self
    }
    
    func setUI(){
        self.freeLabel.layer.cornerRadius = 13
        self.freeLabel.clipsToBounds = true
        self.freeLabel.layer.masksToBounds = true
        if let index = self.currencyWalletData.firstIndex(where: {$0.currency?.title == self.selectedCurrencyTitle}) {
            self.currencyWalletData.insert(self.currencyWalletData[index], at: 0)
            self.currencyWalletData.remove(at: index + 1)
            if self.currencyWalletData.count < 4 {
                self.currencyWalletData.append(Wallet(id: 0, wuid: "", isDefault:false, currency: Currency(id: 0, title: "Add wallet", shortName: "", symbol: "+", icon: ""), balance: ""))
            }
        }
    }
    
    
    @IBAction func manualBankButton(_ sender: UIButton) {
        let vc: ManualBankVC = ManualBankVC.instantiateViewController(identifier: .transaction)
        vc.currencyData = self.currencyWalletData[selectedIndex ?? 0]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func easybankButton(_ sender: UIButton) {
        let vc: AddAmountVC = AddAmountVC.instantiateViewController(identifier: .transaction)
        vc.currencyData = self.currencyWalletData[selectedIndex ?? 0]
        vc.paymentType = .easyBank
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func googlePayButton(_ sender: UIButton) {
        let vc: AddAmountVC = AddAmountVC.instantiateViewController(identifier: .transaction)
        vc.currencyData = self.currencyWalletData[selectedIndex ?? 0]
        vc.paymentType = .googlePay
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func debitCardButton(_ sender: UIButton) {
        let vc: ManageCardVC = ManageCardVC.instantiateViewController(identifier: .transaction)
        vc.paymentType = .card
        vc.currencyData = self.currencyWalletData[selectedIndex ?? 0]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func payPalButton(_ sender: UIButton) {
    }
    
    
    @IBAction func sofortButton(_ sender: UIButton) {
    }
    
    
}


extension AddMoneyVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencyWalletData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalletCategoryCollectionCell", for: indexPath) as? WalletCategoryCollectionCell {
            cell.setUI(data:self.currencyWalletData[indexPath.row], index: indexPath.row, selectedIndex: self.selectedIndex )
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.currencyWalletData[indexPath.row].currency?.title != "Add wallet" {
            self.selectedIndex = indexPath.row
            print(self.currencyWalletData[indexPath.row])
            DispatchQueue.main.async {
                self.currenyWalletCollectionView.reloadData()
            }
        }else{
            print("add wallet")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
