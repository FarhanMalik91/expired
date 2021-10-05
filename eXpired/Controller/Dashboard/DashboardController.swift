//
//  HomeViewController.swift
//  eXpired
//
//  Created by Malik Farhan Asim on 28/06/2021.
//

import UIKit
import FirebaseAuth
import GoogleMobileAds


class DashboardController: AdsController {
    
   //MARK:- UI-Elements
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero,collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.estimatedItemSize = .zero
        collectionView.clipsToBounds = false
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "MenuCollectionViewCell")
        return collectionView
    }()
    
//    lazy var adBannerView: GADBannerView = {
//        let adBannerView = GADBannerView()
//        adBannerView.alpha = 0
//        adBannerView.backgroundColor = .white
//        adBannerView.delegate = self
//        adBannerView.adUnitID = Constants.adMobsId
//        adBannerView.rootViewController = self
//        adBannerView.translatesAutoresizingMaskIntoConstraints = false
//        return adBannerView
//    }()
    
    private var product = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.AppColor.dashboard
        self.navigationItem.title = "Dashboard"
//        self.navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpUI()
//        adBannerView.load(GADRequest())
        
    }
    //MARK:- Helper Functions
    func setUpUI() {
        view.addSubview(collectionView)
//        view.addSubview(adBannerView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50.heightRatio),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
//            adBannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            adBannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            adBannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            adBannerView.heightAnchor.constraint(equalToConstant: 80.autoSized),
        ])
    }
    
//    func checkPurchases(){
//        IAPManager.shared.getProducts { result in
//            switch result {
//            case .success(let product):
//                self.product.products = product
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }

}
extension DashboardController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
        cell.updateCellWithTitlteAndImage(index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewWidth = 335.widthRatio
            let spacing = 15.widthRatio
            let totalWidth = collectionViewWidth - spacing
           
            return CGSize(width: totalWidth / 2, height: 200.heightRatio)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15.autoSized
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let controller = ProductListController(categoryType: .makeup, color: Constants.AppColor.appBrown)
            navigationController?.pushViewController(controller, animated: true)
        case 1:
            let controller = ProductListController(categoryType: .skinCare, color: Constants.AppColor.skincareColor)
            navigationController?.pushViewController(controller, animated: true)
        case 2:
            let controller = ProductListController(categoryType: .perfume, color: Constants.AppColor.perfumeColor)
            navigationController?.pushViewController(controller, animated: true)
        case 3:
            let controller = SettingsViewController()
            navigationController?.pushViewController(controller, animated: true)


            
            
        default:
            return 
        }
        
    }
    
    
}

//extension DashboardController : GADBannerViewDelegate{
//
//    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
//        UIView.animate(withDuration: 1, animations: {
//          bannerView.alpha = 1
//        })
//    }
//    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
//      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
//    }
//
//    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
//      print("bannerViewDidRecordImpression")
//    }
//
//    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
//      print("bannerViewWillPresentScreen")
//
//    }
//
//    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
//      print("bannerViewWillDIsmissScreen")
//    }
//
//    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
//      print("bannerViewDidDismissScreen")
//    }
//}
