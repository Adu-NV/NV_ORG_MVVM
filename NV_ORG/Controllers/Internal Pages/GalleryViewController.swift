//
//  GalleryViewController.swift
//  NV_ORG
//
//  Created by Netventure on 04/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit
import SDWebImage

class GalleryViewController: UIViewController {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var galleryList : GalleryListResponseData? = nil
    let mainStory =  UIStoryboard.init(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        if #available(iOS 13.0, *) {
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }else{
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func setUI(){
        getGaleryList()
        self.galleryCollectionView!.register(GalleryCollectionViewReusableCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:"GalleryCollectionViewReusableCell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
//        layout.itemSize = CGSize(width: self.view.frame.width / 3 - 2, height: 140)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        layout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 50)
        galleryCollectionView!.collectionViewLayout = layout.getLayoutWithEdgeAndSpacing(scrollDirection: .vertical, itemWidth:  self.view.frame.width / 3 - 2, itemHeight: 140, edge: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1), lineSpace: 0, itemSpace: 0, headerSize: CGSize(width: self.view.frame.width, height: 50))
        galleryCollectionView.layoutIfNeeded()
    }

    func getGaleryList(){
        Webservice.shared.getGalleryList { (model, error) in
            debugPrint(model)
            if let _ = model{
                self.galleryList = model?.data
                DispatchQueue.main.async {
                    self.galleryCollectionView.reloadData()
                }
            }
        }
    }

}

extension GalleryViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.galleryList != nil ? ((self.galleryList?.gallery_list!)?.count)! : 0
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GalleryCollectionViewReusableCell", for: indexPath) as! GalleryCollectionViewReusableCell
            header.headerLabels.text = "PHOTOS"
            header.backgroundColor = UIColor.clear
             return header
         }
         abort()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell =  galleryCollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCollectionViewCell", for: indexPath) as! galleryCollectionViewCell
        cell.galleryImages.sd_setImage(with: URL(string:(self.galleryList?.gallery_list![indexPath.row].gallery_URL)!), placeholderImage: UIImage(named: "placeholder.png"))//sd_setImage(with: URL(string:(self.galleryList?.gallery_list![indexPath.row].gallery_URL)!), placeholderImage:  UIImage(named: "events.png"), options: .continueInBackground, completed: nil)
        cell.contentView.setViewCornerRadiusWithBorder(radius: 2.0, borderColor: UIColor.lightGray, width: 0.5)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let galleryImage = mainStory.instantiateViewController(withIdentifier: "GalleryImageViewController") as! GalleryImageViewController
        galleryImage.galleryId = (self.galleryList?.gallery_list![indexPath.row].gallery_URL)!
        if #available(iOS 13.0, *) {
            self.navigationController?.pushViewController(galleryImage, animated: false)
        }else{
            self.present(galleryImage, animated: false, completion: nil)
        }
    }
    
}



