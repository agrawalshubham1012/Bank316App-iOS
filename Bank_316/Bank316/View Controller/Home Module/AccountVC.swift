//
//  AccountVC.swift
//  Bank 316
//
//  Created by Dhairya on 04/10/23.
//

import UIKit

class AccountVC: UIViewController {
    
    @IBOutlet weak var emailVerifyView: UIView!
    @IBOutlet weak var idVerifyView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var versionNumberLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    var arrayData: [AccountModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]{
                let newsize  = newvalue as! CGSize
                self.tableViewHeightConstraints.constant = newsize.height
            }
        }
    }
    //MARK: - Private func for update UI
    private func setupTableView(){
        self.tableView.register(UINib(nibName: "AccountTVC", bundle: nil), forCellReuseIdentifier: "AccountTVC")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.arrayData = AccountList.allCases.map { data in
            let seperatedData = data.rawValue.components(separatedBy: ":")
            return AccountModel(title: seperatedData[0], description: seperatedData[1])
        }
        print(self.arrayData)
    }
    
    //MARK: - Action Events
    @IBAction func idVerifyCancelButton(_ sender: UIButton) {
    }
    
    @IBAction func emailVerifyCancelButton(_ sender: UIButton) {
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        let vc: loginPageVC = loginPageVC.instantiateViewController(identifier: .login)
        self.removedefaultData()
    
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func removedefaultData(){
        defaults.removeObject(forKey:token)
        defaults.removeObject(forKey:tabbar)
    }
}
//MARK: - Extension of TableView Delegate and DataSource

extension AccountVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTVC", for: indexPath)as? AccountTVC{
            cell.lblTitle.text = arrayData[indexPath.row].title
            cell.lblDescription.text = arrayData[indexPath.row].description
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = arrayData[indexPath.row].title ?? ""
        switch AccountTitle(rawValue: selectedItem) {
        case .profile:
            print("Profile")
        case .savedAddress:
            print("Saved Address")
        case .savedBanks:
            print("Saved Banks")
        case .securityAndPrivacy:
            print("Security and Privacy")
        case .statementsAndReports:
            print("Statements and Reports")
        case .manageNotifications:
            print("Manage Notifications")
        case .helpAndSupport:
            print("Help and Support")
        case .preferences:
            print("Preferences")
        case .purchaseAndPoints:
            print("Purchase and Points")
        case .legal:
            print("Legal")
        case .myReferrals:
            print("My Referrals")
        case .closeAccount:
            print("Close Account")
        case .none:
            break
        }
    }
}

