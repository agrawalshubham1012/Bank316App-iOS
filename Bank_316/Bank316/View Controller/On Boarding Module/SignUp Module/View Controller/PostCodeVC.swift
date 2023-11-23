//
//  PostCodeVC.swift
//  Bank 316
//
//  Created by Dhairya on 28/08/23.
//

import UIKit

class PostCodeVC: UIViewController {

    @IBOutlet weak var mannuallyAddressButton: UIButton!
    @IBOutlet weak var manualAddressView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postCodeTF: UITextField!
    
    var postCodeModel: PostCodeModel?
    var personalDetalis: [String: Any] = ["firstName": String.self, "lastName": String.self, "emailAddress": String.self, "dateOfBirth": String.self, "newPassword": String.self, "confirmPassword": String.self]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //MARK: - Private func to update UI
    private func setupTableView(){
        tableView.register(UINib(nibName: "postCodeTVC", bundle: nil), forCellReuseIdentifier: "postCodeTVC")
        tableView.delegate = self
        tableView.dataSource = self
//        postCodeTF.delegate = self
        tableView.setRoundedManualTopCorners(cornerRadius: 30)
        manualAddressView.setRoundedManualTopCorners(cornerRadius: 30)
    }

    @IBAction func mannuallyAddressButton(_ sender: UIButton) {
        let vc: PrefillVC = PrefillVC.instantiateViewController(identifier: .signUp)
            vc.personalDetalis["firstName"] = personalDetalis["firstName"]
            vc.personalDetalis["lastName"] = personalDetalis["lastName"]
            vc.personalDetalis["emailAddress"] = personalDetalis["emailAddress"]
            vc.personalDetalis["dateOfbirth"] = personalDetalis["dateOfBirth"]
            vc.personalDetalis["newPassword"] = personalDetalis["newPassword"]
            vc.personalDetalis["confirmPassword"] = personalDetalis["confirmPassword"]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func postCodeTF(_ sender: UITextField) {
        if postCodeTF.text?.count == 0{
            self.manualAddressView.isHidden = false
            self.tableView.isHidden = true
        }else{
            self.manualAddressView.isHidden = true
            self.tableView.isHidden = false
            self.getPostCodeData(postCode: postCodeTF.text ?? "")
        }
    }
}


extension PostCodeVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postCodeTVC", for: indexPath)as? postCodeTVC{
            cell.updateUI(address: postCodeModel?.results?[indexPath.row].address_components?.first?.long_name ?? "", formattedAddress: postCodeModel?.results?[indexPath.row].formatted_address ?? "")
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: PrefillVC = PrefillVC.instantiateViewController(identifier: .signUp)
            vc.personalDetalis["firstName"] = personalDetalis["firstName"]
            vc.personalDetalis["lastName"] = personalDetalis["lastName"]
            vc.personalDetalis["emailAddress"] = personalDetalis["emailAddress"]
            vc.personalDetalis["dateOfbirth"] = personalDetalis["dateOfBirth"]
            vc.personalDetalis["newPassword"] = personalDetalis["newPassword"]
            vc.personalDetalis["confirmPassword"] = personalDetalis["confirmPassword"]
        vc.personalDetalis["postCode"] = postCodeModel?.results?[indexPath.row].address_components?.first?.long_name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
//MARK: - Extension to call post Code Google API
extension PostCodeVC {
    private func getPostCodeData(postCode: String){
        let parameters = ["address": postCode,
                          "key": postCodeKey]
        SignUpDataManager.shared.getPostCode(url: "https://maps.googleapis.com/maps/api/geocode/json?address=\(postCode)&key=\(postCodeKey)", params: parameters) { result in
            switch result{
            case .success(let data):
                if data.status == "OK"{
                    self.postCodeModel = data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }else{
                    print("Not Ok")
                }
                print(data)
            case .failure(let error):
                print(error)
                
            }
        }
    }
}
