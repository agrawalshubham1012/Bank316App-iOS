//
//  EasyBankVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 20/11/23.
//

import UIKit

class EasyBankVC: UIViewController {
    
    
    @IBOutlet var bigView: UIView!
    @IBOutlet weak var easyBanksTableView: UITableView!
    @IBOutlet weak var bgView: UIView!
    var bankListData:[TestBank] = []
    var transactionData:TransactionModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.getBankList()
        print(self.transactionData as Any)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bgView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    func setUI(){
        self.easyBanksTableView.register(UINib(nibName: "EasyBankCell", bundle: nil), forCellReuseIdentifier: "EasyBankCell")
        self.easyBanksTableView.delegate = self
        self.easyBanksTableView.dataSource = self
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EasyBankVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bankListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EasyBankCell", for: indexPath)as? EasyBankCell{
            cell.setCellUI(data: self.bankListData[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let walletID = self.transactionData?.walletID {
            if let bankID = self.bankListData[indexPath.row].id {
                getPaymentUrlAPI(walletID:walletID,bankID:bankID)
            }
        }
    }
}

extension EasyBankVC{
    private func getBankList(){
        startloadingAnimation(view: self.view)
        let url = getBankLists
        self.bigView.backgroundColor = .white
        APIDataManager.shared.getData(url:url, param:[:]) { (result:ResultSet< BankListResponseModel,ServerError>) in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                self.bankListData = data.data?.testBanks ?? []
                DispatchQueue.main.async {
                    self.easyBanksTableView.reloadData()
                }
                print(data)
            case .failure(let error):
                stopAnimation(view: self.view)
                let error = error.getErrorMessage()
                self.setAlert(message:error)
            }
        }
    }
    
    private func getPaymentUrlAPI(walletID:String,bankID:String){
        startloadingAnimation(view: self.view)
        let url = getMoneyHubPaymentUrl + (self.transactionData?.walletID ?? "")
        let param:[String:Any] = [
            "amount": self.transactionData?.addedMoney ?? "",
            "bankId": bankID
        ]
        print(self.transactionData?.walletID as Any)
        print( url, param)
        APIDataManager.shared.postData(url:url, param:param) { (result:ResultSet< EasyBankHubResponseModel,ServerError>) in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                print(data)
                if data.status ?? false {
                    if let urlData = data.data {
                        DispatchQueue.main.async{
                            self.navigateToReviewTransaction(url:urlData.url ?? "", status: data.status ?? false)
                        }
                    }
                }else{
                    self.setAlert(message:data.message ?? "")
                }
            case .failure(let error):
                stopAnimation(view: self.view)
                let error = error.getErrorMessage()
                self.setAlert(message:error)
            }
        }
    }
    
    func navigateToReviewTransaction(url:String,status:Bool){
        let vc: ReviewTransactionVC = ReviewTransactionVC.instantiateViewController(identifier: .transaction)
        vc.transactionData = self.transactionData
        vc.webUrl = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setAlert(message:String){
        let popupVC: PopUpViewController = PopUpViewController.instantiateViewController(identifier: .home)
        popupVC.message = message
        popupVC.imageHide = true
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(popupVC, animated: true, completion: nil)
    }
}
