//
//  EasyBankTransactionWebViewVC.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 21/11/23.
//

import UIKit
import WebKit

class EasyBankTransactionWebViewVC:UIViewController , WKNavigationDelegate{
    
    
    @IBOutlet weak var sudoView: UIView!
    @IBOutlet var webView: WKWebView!
    var webUrl:String?
    var addedMOney:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sudoView.isHidden = true
        self.setSwipeNavigation()
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.navigationDelegate = self
        self.loadWebPage()
    }
    
    func loadWebPage(){
        if let url = URL(string: webUrl ?? "") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func setSwipeNavigation(){
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        rightSwipeGesture.direction = .right
        view.addGestureRecognizer(rightSwipeGesture)
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            print("")
        } else if gesture.direction == .right {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let currentURL = webView.url else {
            print("No URL loaded.")
            return
        }
        if currentURL.absoluteString.contains(BASE_URL) {
            DispatchQueue.main.async{
                if let components = URLComponents(url: currentURL, resolvingAgainstBaseURL: false) {
                    print(components)
                    if let error = components.queryItems?.first(where:{ $0.name == "error" })?.value,
                       let errorDescription = components.queryItems?.first(where: { $0.name == "error_description" })?.value {
                        print("Error:", error)
                        print("Error Description:", errorDescription)
                        self.sudoView.isHidden = false
                        self.handleError(error: error,description:errorDescription)
                        return
                    }
                    
                    if let error = components.queryItems?.first(where:{ $0.name == "error" })?.value {
                        print("Error:", error)
                        self.handleError(error: error, description:"")
                        return
                    }
                    
                    if let code = components.queryItems?.first(where: { $0.name == "code" })?.value,
                       let state = components.queryItems?.first(where: { $0.name == "state" })?.value {
                        print("Code:", code)
                        print("State:", state)
                        let doubleMoney = Double(self.addedMOney ?? "")
                        self.addedMOney = doubleMoney?.formatNumberToTwoDecimals()
                        self.getPaymentUrlAPI(code: code, state: state)
                    }
                }
            }
        }else {
            print("The current URL is not part of the base URL.")
            print(URLComponents(url: currentURL, resolvingAgainstBaseURL: false) as Any)
        }
    }
}

// APICall
extension EasyBankTransactionWebViewVC{
    private func getPaymentUrlAPI(code:String,state:String){
        self.sudoView.isHidden = false
        startloadingAnimation(view: self.view)
        let url = moneyHubCallBackUrl + "?code=\(code )&state=\(state )"
        let token = "\(defaults.string(forKey: token) ?? "")"
        let param:[String:Any] = [
            "code":code,
            "state":state,
            "id_token": token,
            "amount":self.addedMOney ?? ""
        ]
        print( url, param)
        APIDataManager.shared.getData(url:url, param:param) { (result:ResultSet< EasyBankWebTransactionResponseModel,ServerError>) in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                print(data)
                DispatchQueue.main.async{
                    self.navigateToCompleteTransactionView(status: data.status ?? false,descriptions: data.description ?? "", message: data.message ?? "")
                }
            case .failure(let error):
                print(error)
                stopAnimation(view: self.view)
                DispatchQueue.main.async{
                    self.navigateToCompleteTransactionView(status:false, descriptions:"\(error)", message: "")
                }
            }
        }
    }
    
    func navigateToCompleteTransactionView(status:Bool,descriptions:String,message:String) {
        if status {
            let vc: CompleteTransactionVC = CompleteTransactionVC.instantiateViewController(identifier: .transaction)
            vc.fromView = .easyBank
            vc.apiDescription = descriptions
            vc.headerLabel = message
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc: FailureTransactionVC = FailureTransactionVC.instantiateViewController(identifier: .transaction)
            vc.apiError = message
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func handleError(error:String,description:String?){
        if error == "access_denied" || description == "User rejected consent"{
            self.navigateToBankListScreen()
        }else if error == "access_denied" {
            self.sudoView.isHidden = false
            self.navigateToBankListScreen()
        }
    }
    
    func navigateToBankListScreen() {
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        if let addMoneyVC = viewControllers.first(where: { $0 is EasyBankVC }) as? EasyBankVC {
            self.navigationController?.popToViewController(addMoneyVC, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }

}


extension URL {
    func valueOf(_ queryParameterName: String) -> String? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return nil }
        return components.queryItems?.first(where: { $0.name == queryParameterName })?.value
    }
}
