//
//  AddProductViewController.swift
//  eXpired
//
//  Created by Malik Farhan Asim on 28/06/2021.
//

import UIKit

class MakeUpItemController: AdsController , UIGestureRecognizerDelegate{
    
    //MARK:-UI-Elements
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
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        return collectionView
    }()
    
    lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = "Search"
        searchBar.searchTextField.tintColor = .black
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    var categoryId: String = ""
    var products = [Product]()
    var allProducts = [Product]()
    let productIconImage = ImageView(image: "add")
    var categoryType : CategoriesOptions!
    var backgroundColor = UIColor()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        self.navigationItem.title = "Products"
        self.navigationController?.navigationBar.barTintColor = .systemBackground

        navigationController?.navigationBar.prefersLargeTitles = true
        productIconImage.contentMode = .scaleAspectFit
        setUpUI()
        setupLongGestureRecognizerOnCollection()
        getProducts()
    }
    init(categoryType: CategoriesOptions , color: UIColor) {
        self.categoryType = categoryType
        super.init(nibName: nil, bundle: nil)
        
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:-Helper Functions
    func setUpUI(){
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            searchBar.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.heightRatio),
            searchBar.heightAnchor.constraint(equalToConstant: 40.heightRatio),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 30.heightRatio),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        
    }
    
    func getProducts(){
        showLoadingView()
        ApiManager.shared.getAllProducts(categoryType,categoryId) { [weak self] products in
            self?.hideLoadingView()
            if let product = products {
                self?.products = product
                self?.allProducts = product
                self?.products = self!.products.sorted { $0.brand.lowercased() < $1.brand.lowercased() }
                self?.collectionView.reloadData()
            }
        }
    }
   
    
    private func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionView.addGestureRecognizer(longPressedGesture)
    }

    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }

        let p = gestureRecognizer.location(in: collectionView)

        if let indexPath = collectionView.indexPathForItem(at: p) {
            showBottomSheet(productId: products[indexPath.row].id , index: indexPath.row)
        }
    }
    
    func showBottomSheet(productId: String , index: Int){
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.success)
        let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to delete?", preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "Yes", style: .destructive) { [self] ok in
            ApiManager.shared.deleteProduct(categoryType,categoryId , productId)
            products.remove(at: index)
            collectionView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
extension MakeUpItemController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , AddMakeupItemControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        if indexPath.item == products.count {
            cell.menuImage.image = UIImage(named: "collectionImage")?.withRenderingMode(.alwaysTemplate)
            cell.menuImage.tintColor = Constants.AppColor.appGreen
            cell.menuName.text = "Add Product"
        }else{
            cell.menuImage.downloadImage(url: products[indexPath.row].imageUrl)
            cell.menuName.text = products[indexPath.row].brand
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewWidth = 313.widthRatio
            let spacing = 1.widthRatio
            let totalWidth = collectionViewWidth - spacing
           
            return CGSize(width: totalWidth / 3, height: 150.heightRatio)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15.autoSized
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = AddMakeupItemController(categoryType: categoryType, color: backgroundColor)
        if indexPath.item == products.count {
            
            controller.categoryId = categoryId
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
        }else {
            controller.products = products[indexPath.row]
            controller.delegate = self
            controller.categoryId = categoryId
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    func refreshApi() {
        getProducts()
    }
}
extension MakeUpItemController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
            if !searchText.isEmpty {
                products = allProducts.filter({ product in
                    let name = product.brand.lowercased()
                    return name.contains(searchText.lowercased())
                })

            }else {
                products = allProducts
            }
        collectionView.reloadData()
    }
}
