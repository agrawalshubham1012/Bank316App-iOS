//
//  ManageCardVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 16/11/23.
//

import UIKit
import CardScan

class ManageCardVC: UIViewController {
    
    @IBOutlet weak var manageCardButton: UIButton!
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cardHeader: UIStackView!
    @IBOutlet weak var cardsView: UIView!
    
    var paymentType:TransactionMethod?
    var cardData:[Card] = []
    var currencyData:Wallet?
    var manageCard:Bool? = false
    var selectedIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        print(currencyData as Any)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getCardData()
        self.manageCardButton.isHidden = false
    }
    
    func setTableViewHeight(){
        if self.cardData.isEmpty {
            self.cardsView.isHidden = true
            self.cardHeader.isHidden = false
        }else{
            self.cardsView.isHidden = false
            self.cardHeader.isHidden = true
        }
        if self.cardData.count < 4 {
            self.tableViewHeight.constant = CGFloat(65 * self.cardData.count)
        }else{
            self.tableViewHeight.constant = 260
        }
    }
    
    func setUI(){
        self.manageCardButton.underline()
        self.cardTableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardTableViewCell")
        self.cardTableView.delegate = self
        self.cardTableView.dataSource = self
        self.cardTableView.showsVerticalScrollIndicator = false
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func manageCardButton(_ sender: UIButton) {
        self.manageCard = true
        self.manageCardButton.isHidden = self.manageCard ?? false
        self.selectedIndex = nil
        DispatchQueue.main.async {
            self.cardTableView.reloadData()
        }
    }
    
    @IBAction func addCardbutton(_ sender: UIButton) {
        let vc: AddCardVC = AddCardVC.instantiateViewController(identifier: .transaction)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ManageCardVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cardData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath)as? CardTableViewCell{
            cell.setUI(data: self.cardData[indexPath.row],deleteCard:self.manageCard ?? false)
            if indexPath.row == self.selectedIndex {
                cell.rightIcon.isHidden = false
                cell.cardDeleteButton.isHidden = true
            }else{
                cell.rightIcon.isHidden = true
            }
            
            cell.deleteCardAction = { [weak self] id in
                self?.deleteCardAPI(cardID: id,index: indexPath.row)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        DispatchQueue.main.async {
            self.cardTableView.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigaeToView(index:indexPath.row)
        }
    }
    
    func navigaeToView(index:Int){
        let vc: AddAmountVC = AddAmountVC.instantiateViewController(identifier: .transaction)
        vc.paymentType = .card
        vc.cardDetails = self.cardData[index]
        vc.currencyData = self.currencyData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension ManageCardVC {
    private func getCardData(){
        startAnimation(view: self.view)
        let url = getCardList
        APIDataManager.shared.getData(url:url, param:[:]) { (result:ResultSet< CardsResponseModel,ServerError>) in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                self.cardData = data.data?.cards ?? []
                DispatchQueue.main.async {
                    self.selectedIndex = nil
                    self.manageCard = false
                    self.cardTableView.reloadData()
                    self.setTableViewHeight()
                }
                print(self.cardData)
            case .failure(let error):
                stopAnimation(view: self.view)
                let error = error.getErrorMessage()
                self.setAlert(message:error)
            }
        }
    }
    
    func setAlert(message:String){
        let popupVC: PopUpViewController = PopUpViewController.instantiateViewController(identifier: .home)
        popupVC.message = message
        popupVC.imageHide = true
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(popupVC, animated: true, completion: nil)
    }
    
    private func deleteCardAPI(cardID:Int,index:Int){
        startAnimation(view: self.view)
        let url = "\(String(describing: deleteCard))\(cardID)"
        APIDataManager.shared.deleteData(url:url, param:[:]) { (result:ResultSet< CardsDeleteResponseModel,ServerError>) in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                self.cardData.remove(at: index)
                DispatchQueue.main.async {
                    self.selectedIndex = nil
                    self.manageCard = false
                    self.manageCardButton.isHidden = false
                    self.cardTableView.reloadData()
                    self.setTableViewHeight()
                }
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}



