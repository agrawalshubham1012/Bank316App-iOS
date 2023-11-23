//
//  CountryListVC.swift
//  Bank 316
//
//  Created by Dhairya on 25/08/23.
//

import UIKit

protocol SelectedCountryListProtocol: AnyObject{
    func getCountryData(countryList: CountriesNameModel?, identifier: String)
}

class CountryListVC: UIViewController {
    
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var countrySearchTF: UITextField!
    
    var index: Int = 0
    var identifier: String = ""
    var dataIdentifier: String = ""
    var countryListModel: CountryListModel?
    var filteredListModel: CountryListModel?
    weak var delegate: SelectedCountryListProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.countryListApi()
        self.updateUI()
    }

    //MARK: - Private func tableViewSetup
    private func setupTableView(){
        self.tableView.register(UINib(nibName: "CountryListTVC", bundle: nil), forCellReuseIdentifier: "CountryListTVC")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setRoundedManualTopCorners(cornerRadius: 30)
        
    }
    
    private func updateUI(){
        switch identifier{
        case "Login":
            logOutButton.isHidden = true
            break
        case "SignUp":
            break
        default:
            break
            
        }
    }
    
    
    @IBAction func searchCountryTF(_ sender: UITextField) {
        self.filteredListModel?.data?.rows?.removeAll()
        if self.countrySearchTF.text?.count != 0 {
            self.countryListModel?.data?.rows?.forEach({ data in
                let range = data.country_name?.lowercased().range(of: countrySearchTF.text ?? "", options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    filteredListModel?.data?.rows?.append(data)
                }
            })
        } else {
            self.filteredListModel = self.countryListModel
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        
    }
    
    
}

extension CountryListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredListModel?.data?.rows?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTVC", for: indexPath)as? CountryListTVC{
            cell.updateUI(data: filteredListModel?.data?.rows?[indexPath.row])
            if indexPath.row == index{
                cell.countrySelectionImage.image = UIImage(named: "Country_Selected")
            }else{
                cell.countrySelectionImage.image = UIImage(named: "Country_UnSelected")
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath)as? CountryListTVC{
            self.index = indexPath.row
            cell.countrySelectionImage.image = UIImage(named: "Country_Selected")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.dismiss(animated: true) {
                self.delegate?.getCountryData(countryList: self.filteredListModel?.data?.rows?[self.index], identifier: self.dataIdentifier)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath)as? CountryListTVC{
            self.index = indexPath.row
            cell.countrySelectionImage.image = UIImage(named: "Country_UnSelected")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//MARK: - Extension for Country List API
extension CountryListVC{
    private func countryListApi(){
        startAnimation(view: self.view)
        CountryListDataManager.shared.countryListManager { result in
            switch result{
            case .success(let data):
                defer {
                    stopAnimation(view: self.view)
                }
                self.countryListModel = data
                self.filteredListModel = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(data)
            case .failure(let error):
                defer {
                    stopAnimation(view: self.view)
                }
                print(error)
            }
        }
    }
}
