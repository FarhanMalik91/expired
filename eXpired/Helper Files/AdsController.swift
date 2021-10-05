//
//  AdsController.swift
//  eXpired
//
//  Created by Sarmad Ishfaq on 25/08/2021.
//

import UIKit
import GoogleMobileAds

class AdsController: UIViewController {

    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView()
        adBannerView.alpha = 0
        adBannerView.backgroundColor = .white
        adBannerView.delegate = self
        adBannerView.adUnitID = Constants.adMobsId
        adBannerView.rootViewController = self
        adBannerView.translatesAutoresizingMaskIntoConstraints = false
        return adBannerView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adBannerView.load(GADRequest())
        addConstraint()
    }
    
    func addConstraint(){
        view.addSubview(adBannerView)
        
        NSLayoutConstraint.activate([
            
            adBannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            adBannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            adBannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            adBannerView.heightAnchor.constraint(equalToConstant: 80.autoSized),
        ])
    }

}
extension AdsController : GADBannerViewDelegate{

    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        UIView.animate(withDuration: 1, animations: {
          bannerView.alpha = 1
        })
    }
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
        
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
}
