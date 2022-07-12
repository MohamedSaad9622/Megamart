//
//  Favorites_ViewController.swift
//  Megamart
//
//  Created by MAC on 02/07/2022.
//

import UIKit

class Favorites_ViewController: UIViewController {

    @IBOutlet weak var favorites_collectionView: UICollectionView!
    
    var ids: [Int] = []
    var titles: [String] = []
    var images: [String] = []
    
    var favoritesModelView: Favorites_protocol = Favorites_viewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favorites_collectionView.delegate = self
        favorites_collectionView.dataSource = self

        self.favorites_collectionView.register(UINib(nibName: Constants.favorite_nib_name , bundle: nil), forCellWithReuseIdentifier: Constants.favorite_Cell_id)
        
        self.favoritesModelView.fetchFavorites()
        
        self.favoritesModelView.binding = { products, error in
            if let error = error {
                addAlert(title: "Warning", message: error.localizedDescription , ActionTitle: "Cancel", viewController: self)
            }
            if let products = products {
                if let ids = products["ids"] as? [Int] {
                    self.ids = ids
                }
                if let titles = products["titles"] as? [String] {
                    self.titles = titles
                }
                if let images = products["images"] as? [String] {
                    self.images = images
                }
                
                self.favorites_collectionView.reloadData()
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if ids.count == 0 {
            addAlert(title: "Alert!", message: "There are no favorite Products", ActionTitle: "Cancel", viewController: self)
        }
    }


}


//MARK: -                                       Collection View


extension Favorites_ViewController: UICollectionViewDelegate{
    
}

extension Favorites_ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ids.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.favorite_Cell_id, for: indexPath) as? FavoritesCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.setCell(imageUrl: images[indexPath.row], title: titles[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.productDetails_storyboard, bundle:nil)
        let productDetailsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.ProductDetails_ViewController_id) as! ProductDetails_ViewController
        productDetailsViewController.productID = String(ids[indexPath.row])
        self.navigationController?.pushViewController(productDetailsViewController, animated: true)
    
    }

    
    
}


extension Favorites_ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2 , height: collectionView.frame.size.height/2)
    }
    
}
