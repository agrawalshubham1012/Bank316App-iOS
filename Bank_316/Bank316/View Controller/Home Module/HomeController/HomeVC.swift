//
//  HomeVC.swift
//  Bank 316
//
//  Created by Dhairya on 04/10/23.
//

import UIKit

class HomeVC: UIViewController {
    
    
    @IBOutlet weak var allViewContainer: UIView!
    @IBOutlet weak var goodMorningButton: UIButton!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var verifyEmailView: UIView!
    @IBOutlet weak var emailViewDismissButton: UIButton!
    @IBOutlet weak var emailVerifyIcon: UIImageView!
    @IBOutlet weak var docIDVerifyrequestView: UIView!
    @IBOutlet weak var cashBalanceView: UIView!
    @IBOutlet weak var defaultWalletIcon: UIImageView!
    @IBOutlet weak var cashBalanceLabel: UILabel!
    @IBOutlet weak var requestPendingImage: UIImageView!
    @IBOutlet weak var addDocView: UIView!
    @IBOutlet weak var buisnessView: UIView!
    @IBOutlet weak var buisnessInfo: UIImageView!
    @IBOutlet weak var buisnessPieChartView: UIView!
    @IBOutlet weak var investLabel: UILabel!
    @IBOutlet weak var tradersView: UIView!
    @IBOutlet weak var traderSecondView: UIView!
    @IBOutlet weak var traderHeaderlabel: UILabel!
    @IBOutlet weak var traderBarHeight: NSLayoutConstraint!
    @IBOutlet weak var traderInfoImage: UIImageView!
    @IBOutlet weak var shoppersView: UIView!
    @IBOutlet weak var hideDiscoverView: UIView!
    @IBOutlet weak var discoverView: UIView!
    @IBOutlet weak var discoverButton: UIButton!
    @IBOutlet weak var traderInvestImage: UIImageView!
    @IBOutlet weak var currencyWalletView: UIView!
    @IBOutlet weak var walletTableView: UITableView!
    @IBOutlet weak var walletTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var currencyIcon: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var availableBalance: UILabel!
    @IBOutlet weak var earningCollectionView: UICollectionView!
    @IBOutlet weak var emptyTransactionView: UIView!
    @IBOutlet weak var transactionView: UIView!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var transactionTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var transactionHeaderBtn: UIButton!
    @IBOutlet weak var inviteUserView: UIView!
    @IBOutlet weak var bgTransactionView: UIView!
    @IBOutlet weak var earningDistributionView: UIView!
    @IBOutlet weak var almostThereView: UIView!
    
    
    var isemaiVerified:Bool?
    var isDocVerified:Bool?
    var isDocPending:Bool? = false
    var emailID:String?
    var homeData:HomePageData?
    var transactionData:TransactionData?
    var aletMessage:String?
    var isDiscoverSelected:Bool = false
    var showWallet:Bool = false
    var currencyWalletID:String?
    var buisnessWebUrl:String?
    var currencyWalletData:[CurrencyWallet] = []
    var selectedCurrencyIndex:Int?
    var earningArray:[EarningModel] = [EarningModel(image: "referral", title: "Referal", currency: "0", percentage: "0.0",color:UIColor(red: 140/255, green: 84/255, blue: 247/255, alpha: 1)),EarningModel(image: "316 RF", title: "Referal", currency: "0", percentage: "0.0", color: UIColor(red: 248/255, green: 138/255, blue: 99/255, alpha: 1)),EarningModel(image: "PE", title: "Referal", currency: "0", percentage: "0.0", color: UIColor(red: 91/255, green: 172/255, blue: 78/255, alpha: 1))]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.set(true, forKey: tabbar)
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTap(_:)))
//        self.allViewContainer.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectedCurrencyIndex = nil
        fetchUserHomeData()
    }
    
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let vc: EmailVerificationVC = EmailVerificationVC.instantiateViewController(identifier: .verification)
        vc.emailD = self.emailID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func hideEmailViewButton(_ sender: UIButton) {
        verifyEmailView.isHidden = true
        self.aletMessage = "Please Verify your ID"
    }
    
    @IBAction func addDocButton(_ sender: UIButton) {
        let vc: BriefVC = BriefVC.instantiateViewController(identifier: .verification)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addWalletButton(_ sender: UIButton) {
        setAlert()
    }
    
    @IBAction func poundWalletButton(_ sender: UIButton) {
        print("wallet")
    }
    
    @IBAction func startSendingButton(_ sender: UIButton) {
        setAlert()
    }
    
    @IBAction func addMonyButton(_ sender: UIButton) {
        if self.isDocVerified ?? false {
            self.navigateToAddMoneyView()
        }else{
            setAlert()
        }
    }
    
    @IBAction func discoverButton(_ sender: UIButton) {
        self.hideDiscoverView.isHidden = false
        self.discoverButton.isHidden = true
        self.buisnessView.isHidden = false
        self.shoppersView.isHidden = false
        self.tradersView.isHidden = false
    }
    
    @IBAction func discoverHideButton(_ sender: UIButton) {
        self.hideDiscoverView.isHidden = true
        self.discoverButton.isHidden = false
        self.buisnessView.isHidden = true
        self.shoppersView.isHidden = true
        self.tradersView.isHidden = true
    }
    
    @IBAction func startSellingButton(_ sender: UIButton) {
        setAlert()
        self.buisnessWebUrl = BuisnessToolType.startSelling.rawValue
        navigateToWebPage()
    }
    
    @IBAction func collectPaymentButton(_ sender: UIButton) {
        setAlert()
        self.buisnessWebUrl = BuisnessToolType.collectPayments.rawValue
        navigateToWebPage()
    }
    
    @IBAction func buisnessToolsButton(_ sender: UIButton) {
        setAlert()
        self.buisnessWebUrl = BuisnessToolType.buisnessTools.rawValue
        navigateToWebPage()
    }
    
    @IBAction func seeTradingPlansButton(_ sender: UIButton) {
        setAlert()
        self.buisnessWebUrl = BuisnessToolType.buisnessTools.rawValue
    }
    
    @IBAction func marketPlaceSignInButton(_ sender: UIButton) {
        setAlert()
    }
    
    //    DefaultCurrency
    @IBAction func showWalletButton(_ sender: UIButton) {
        showWallet = !showWallet
        self.walletTableView.isHidden = !showWallet
    }
    
    @IBAction func addMoneyButton(_ sender: UIButton) {
        self.navigateToAddMoneyView()
    }
    
    @IBAction func sendMoneyButton(_ sender: UIButton) {
        
    }
    
    @IBAction func requestMoneyButton(_ sender: UIButton) {
        
    }
    
    //    ViewStats
    @IBAction func viewStatsButton(_ sender: UIButton) {
        
    }
    
    //    inviteFriend
    @IBAction func inviteNowButton(_ sender: UIButton) {
        
    }
    
    func navigateToAddMoneyView(){
        let vc: AddMoneyVC = AddMoneyVC.instantiateViewController(identifier: .transaction)
        vc.currencyWalletData = self.homeData?.currencyWallets ?? []
        if selectedCurrencyIndex != nil {
            vc.selectedCurrencyTitle = self.homeData?.currencyWallets?[self.selectedCurrencyIndex ?? 0].currency?.title ?? ""
        }else{
            vc.selectedCurrencyTitle = self.homeData?.defaultWallet?.currency?.title ?? ""
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func navigateToWebPage(){
        let vc: BuissnessWebViewVC = BuissnessWebViewVC.instantiateViewController(identifier: .home)
        vc.webUrl = self.buisnessWebUrl
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    @objc func handleViewTap(_ gesture: UITapGestureRecognizer) {
//        let location = gesture.location(in: self.view)
//            if !self.walletTableView.frame.contains(location) {
//                // If the tap is outside the table view, toggle its visibility
//                showWallet = !showWallet
//                self.walletTableView.isHidden = !showWallet
//                self.walletTableView.isUserInteractionEnabled = showWallet // Enable interaction based on visibility
//            }
//    }
    
    
}

extension HomeVC {
    private func fetchUserHomeData(){
        startAnimation(view: self.view)
        APIDataManager.shared.fetchHomeData() { result in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                self.homeData = data.data
                for item in self.homeData?.currencyWallets ?? [] {
                    self.currencyWalletData.append(CurrencyWallet(currencyWalletName:item.currency?.title,balance: item.balance,symbol: item.currency?.symbol))
                }
                self.checkVerification()
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
    
    private func getTransactionData(){
        startAnimation(view: self.view)
        let url = getTransactionUrl + (self.currencyWalletID ?? "")
        APIDataManager.shared.getData(url:url, param:[:]) { (result:ResultSet< TransactionResponseModel,ServerError>) in
            switch result{
            case .success(let data):
                defer{
                    stopAnimation(view: self.view)
                }
                self.transactionData = data.data
                self.setTransactionUI()
                DispatchQueue.main.async {
                    self.transactionTableView.reloadData()
                }
            case .failure(let error):
                stopAnimation(view: self.view)
                let error = error.getErrorMessage()
                self.setAlert(message:error)
            }
        }
    }
    
    
    func checkVerification(){
        self.isemaiVerified = self.homeData?.profile?.isEmailVerified
        switch self.homeData?.profile?.docVerifiedStatus {
        case "approved":
            if !(self.isemaiVerified ?? false) {
                emailVerificationPending()
                break
            }else{
                self.currencyWalletID = self.homeData?.defaultWallet?.wuid
                userApprovedCase()
            }
        case "pending":
            userPendingCase()
        case "Not_applied":
            userNotAppliedCase()
        default:
            userNotAppliedCase()
        }
        
        self.emailID = self.homeData?.profile?.email
        UserDataManager.shared.userName = self.homeData?.profile?.firstName ?? "" + "\(self.homeData?.profile?.lastName ?? "")"
        self.helloLabel.text = "Hello \(self.homeData?.profile?.firstName ?? "")"
        self.goodMorningButton.setTitle(getTimeOfDay(), for: .normal)
        DispatchQueue.main.async { [self] in
            setUI()
        }
    }
    
    func getTimeOfDay() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)
        
        if hour >= 6 && hour < 12 {
            self.goodMorningButton.setImage(UIImage(named: "morning"), for: .normal)
            return "Good Morning "
        } else if hour >= 12 && hour < 17 {
            self.goodMorningButton.setImage(UIImage(named: "night"), for: .normal)
            return "Good Afternoon "
        } else {
            self.goodMorningButton.setImage(UIImage(named: "evening"), for: .normal)
            return "Good Evening "
        }
    }
    
    
    func setUI(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        verifyEmailView.addGestureRecognizer(tapGesture)
        self.emailViewDismissButton.isHidden = false
        
        if !(self.isDocVerified ?? false){
            self.addDocView.isHidden = false
            if self.isemaiVerified ?? false {
                self.aletMessage = "Please Verify your ID"
            }
        }else{
            self.addDocView.isHidden = true
        }
        
        if !(self.isemaiVerified ?? false){
            self.verifyEmailView.isHidden = false
            self.emailViewDismissButton.isHidden = true
            //            if isDocVerified ?? false {
            //                if self.isemaiVerified ?? false {
            //                    self.emailViewDismissButton.isHidden = false
            //                }else{
            //                    self.emailViewDismissButton.isHidden = true
            //                }
            //            }else{
            //                self.emailViewDismissButton.isHidden = true
            //            }
            self.aletMessage = "Please Verify your email"
        }else{
            self.verifyEmailView.isHidden = true
        }
        
        if self.isDocPending ?? false {
            self.aletMessage = "Please Verify your ID"
            loadGif(gifName: "pendingRequest", imageView: self.requestPendingImage)
        }
        loadGif(gifName: "invest", imageView: self.traderInvestImage)
        registerCell()
        setTableViewHeight()
    }
    
    func registerCell(){
        self.walletTableView.register(UINib(nibName: "WalletCellTableViewCell", bundle: nil), forCellReuseIdentifier: "WalletCellTableViewCell")
        self.walletTableView.delegate = self
        self.walletTableView.dataSource = self
        self.walletTableView.isHidden = true
        self.walletTableView.layer.cornerRadius = 15
        self.walletTableView.backgroundColor = .white
        
        self.transactionTableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionTableViewCell")
        self.transactionTableView.delegate = self
        self.transactionTableView.dataSource = self
        
        self.earningCollectionView.register(UINib(nibName: "EarningDistributionCollectionCell", bundle: nil), forCellWithReuseIdentifier: "EarningDistributionCollectionCell")
        self.earningCollectionView.delegate = self
        self.earningCollectionView.dataSource = self
        self.earningCollectionView.isScrollEnabled = true
        self.earningCollectionView.reloadData()
    }
    
    
    func setWalletCurrencyUI(){
        self.currencyIcon.sd_setImageCustom(url: homeData?.defaultWallet?.currency?.icon ?? "")
        self.currencyLabel.text = "\(homeData?.defaultWallet?.currency?.title ?? "") - \(homeData?.defaultWallet?.currency?.shortName ?? "")"
        let formattedBalance = formatNumberToTwoDecimals(Double(homeData?.defaultWallet?.balance ?? "") ?? 0.56)
        self.availableBalance.text = "\(homeData?.defaultWallet?.currency?.symbol ?? "")\(formattedBalance)"
    }
    
    func setTransactionUI(){
        self.bgTransactionView.isHidden = false
        if !(self.transactionData?.rows?.isEmpty ?? false) {
            self.transactionView.isHidden = false
            self.emptyTransactionView.isHidden = true
            self.transactionHeaderBtn.setTitle("All ", for: .normal)
            if self.transactionData?.rows?.count ?? 0 < 4 {
                self.transactionTableViewHeight.constant = CGFloat(Double(self.transactionData?.rows?.count ?? 0) * 61.66)
            }else{
                self.transactionTableViewHeight.constant = 247
            }
            
        }else{
            self.transactionView.isHidden = true
            self.emptyTransactionView.isHidden = false
            self.transactionHeaderBtn.setTitle("", for: .normal)
        }
    }
    
    func setCashBalanceView(){
        self.defaultWalletIcon.sd_setImageCustom(url: homeData?.defaultWallet?.currency?.icon ?? "")
        self.cashBalanceLabel.text = "\(self.homeData?.defaultWallet?.currency?.symbol ?? "")\(self.homeData?.defaultWallet?.balance ?? "")"
        
    }
    
    func userApprovedCase(){
        self.isDocVerified = true
        self.isDocPending = false
        self.docIDVerifyrequestView.isHidden = true
        self.cashBalanceView.isHidden = true
        self.earningDistributionView.isHidden = false
        self.discoverButton.isHidden = true
        self.hideDiscoverView.isHidden = true
        self.buisnessView.isHidden = false
        self.shoppersView.isHidden = false
        self.tradersView.isHidden = false
        self.discoverView.isHidden = true
        self.currencyWalletView.isHidden = false
        self.inviteUserView.isHidden = false
        self.shoppersView.isHidden = true
        self.investLabel.text = "Trade"
        self.traderHeaderlabel.text = "Do more with your 316 account"
        self.traderInfoImage.isHidden = true
        self.traderBarHeight.constant = 36
        self.traderSecondView.backgroundColor = .black
        self.buisnessInfo.isHidden = true
        self.buisnessPieChartView.isHidden = true
        setWalletCurrencyUI()
        getTransactionData()
    }
    
    func userPendingCase(){
        self.isDocVerified = true
        self.isDocPending = true
        self.discoverView.isHidden = false
        self.discoverButton.isHidden = false
        self.docIDVerifyrequestView.isHidden = false
        self.buisnessView.isHidden = true
        self.shoppersView.isHidden = true
        self.tradersView.isHidden = true
        self.hideDiscoverView.isHidden = true
        self.transactionView.isHidden = true
        self.currencyWalletView.isHidden = true
        self.inviteUserView.isHidden = true
        self.earningDistributionView.isHidden = false
        self.traderBarHeight.constant = 0
        self.investLabel.text = "Invest"
        self.traderHeaderlabel.text = "316 for traders"
        self.traderInfoImage.isHidden = false
        self.traderSecondView.backgroundColor = .lightAppGreen
        self.buisnessInfo.isHidden = false
        self.buisnessPieChartView.isHidden = false
        self.cashBalanceView.isHidden = false
        self.bgTransactionView.isHidden = false
        self.emptyTransactionView.isHidden = false
    }
    
    func userNotAppliedCase(){
        self.isDocVerified = false
        self.isDocPending = false
        self.discoverView.isHidden = false
        self.discoverButton.isHidden = false
        self.docIDVerifyrequestView.isHidden = true
        self.buisnessView.isHidden = true
        self.shoppersView.isHidden = true
        self.tradersView.isHidden = true
        self.hideDiscoverView.isHidden = true
        self.transactionView.isHidden = true
        self.currencyWalletView.isHidden = true
        self.inviteUserView.isHidden = true
        self.earningDistributionView.isHidden = false
        self.traderBarHeight.constant = 0
        self.investLabel.text = "Invest"
        self.traderHeaderlabel.text = "316 for traders"
        self.traderInfoImage.isHidden = false
        self.traderSecondView.backgroundColor = .lightAppGreen
        self.buisnessInfo.isHidden = false
        self.buisnessPieChartView.isHidden = false
        self.cashBalanceView.isHidden = false
        self.bgTransactionView.isHidden = false
        self.emptyTransactionView.isHidden = false
    }
    
    func emailVerificationPending(){
        self.isDocVerified = true
        self.isDocPending = false
        self.discoverView.isHidden = false
        self.discoverButton.isHidden = false
        self.docIDVerifyrequestView.isHidden = true
        self.buisnessView.isHidden = true
        self.shoppersView.isHidden = true
        self.tradersView.isHidden = true
        self.hideDiscoverView.isHidden = true
        self.currencyWalletView.isHidden = true
        self.inviteUserView.isHidden = true
        self.earningDistributionView.isHidden = true
        self.traderBarHeight.constant = 0
        self.investLabel.text = "Invest"
        self.traderHeaderlabel.text = "316 for traders"
        self.traderInfoImage.isHidden = false
        self.traderSecondView.backgroundColor = .lightAppGreen
        self.buisnessInfo.isHidden = false
        self.buisnessPieChartView.isHidden = false
        self.cashBalanceView.isHidden = false
        self.bgTransactionView.isHidden = false
        self.emptyTransactionView.isHidden = false
        self.transactionView.isHidden = true
        self.transactionHeaderBtn.isHidden = true
        self.almostThereView.isHidden = false
        self.setCashBalanceView()
    }
    
    func setAlert(){
        if !(self.isDocVerified ?? false) || (self.isDocPending ?? false) || !(self.isemaiVerified ?? false)  {
            let popupVC: PopUpViewController = PopUpViewController.instantiateViewController(identifier: .home)
            popupVC.message = self.aletMessage ?? ""
            popupVC.imageHide = true
            popupVC.modalPresentationStyle = .overCurrentContext
            popupVC.modalTransitionStyle = .crossDissolve
            self.navigationController?.present(popupVC, animated: true, completion: nil)
        }
    }
    
    func setTableViewHeight(){
        self.walletTableViewHeight.constant = CGFloat((homeData?.currencyWallets?.count ?? 0) * 40)
        self.walletTableView.reloadData()
    }
    
    func loadGif(gifName:String,imageView:UIImageView){
        do {
            let imageData = try Data(contentsOf: Bundle.main.url(forResource: gifName, withExtension: "gif")!)
            imageView.image = UIImage.gifImageWithData(imageData)
        } catch {
            print(error)
        }
    }
    
    func formatNumberToTwoDecimals(_ number: Double) -> String {
        return String(format: "%.2f", number)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.walletTableView:
            return self.homeData?.currencyWallets?.count ?? 0
        case self.transactionTableView:
            if self.transactionData?.rows?.count ?? 0 < 4 {
                return self.transactionData?.rows?.count ?? 0
            }else{
                return 4
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.walletTableView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WalletCellTableViewCell", for: indexPath)as? WalletCellTableViewCell{
                cell.setCellData(data:homeData?.currencyWallets?[indexPath.row])
                return cell
            }
        case self.transactionTableView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath)as? TransactionTableViewCell{
                cell.setUI(data: self.transactionData?.rows?[indexPath.row])
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case self.walletTableView:
            return 40
        case self.transactionTableView:
            return 61
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case self.walletTableView:
            self.selectedCurrencyIndex = indexPath.row
            showWallet = !showWallet
            self.walletTableView.isHidden = !showWallet
            self.currencyWalletID = self.homeData?.currencyWallets?[indexPath.row].wuid
            self.currencyIcon.sd_setImageCustom(url: homeData?.currencyWallets?[indexPath.row].currency?.icon ?? "")
            self.currencyLabel.text = "\(homeData?.currencyWallets?[indexPath.row].currency?.title ?? "") - \(homeData?.currencyWallets?[indexPath.row].currency?.shortName ?? "")"
            getTransactionData()
            let data = self.currencyWalletData.filter{$0.currencyWalletName == self.homeData?.currencyWallets?[indexPath.row].currency?.title }
            let formattedBalance = formatNumberToTwoDecimals(Double(data[0].balance ?? "0") ?? 0.00)
            self.availableBalance.text = "\(data[0].symbol ?? "")\(formattedBalance)"
            
        case self.transactionTableView:
            print("yess")
        default:
            print("yess")
        }
    }
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return earningArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EarningDistributionCollectionCell", for: indexPath) as? EarningDistributionCollectionCell {
            cell.setCellData(data: earningArray[indexPath.item])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hello")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(UIScreen.main.bounds.width * 0.915) / 3, height: 115)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
