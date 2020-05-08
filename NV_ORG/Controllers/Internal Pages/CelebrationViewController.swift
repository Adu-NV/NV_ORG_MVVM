//
//  CelebrationViewController.swift
//  NV_ORG
//
//  Created by Netventure on 05/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class CelebrationViewController: UIViewController {
//celebrationListCollectionViewCell
    //CelebrationListTableViewCell2
    var celebrationListModel : CelebrationListResponseModel? = nil
    var layout = UICollectionViewFlowLayout()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @IBOutlet weak var celebrationListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    
    func setUI(){
        getList()
//        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        layout.itemSize = CGSize(width: screenWidth  - 55, height: 200)
//        layout.scrollDirection = .horizontal
//        eventsCollectionView!.collectionViewLayout = layout
//        eventsCollectionView.layoutIfNeeded()
    }
    
    func getList(){
        Webservice.shared.getCelebrationList { (model, error) in
            if let _ = model{
                self.celebrationListModel = model
            }else{
                
            }
        }
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
}


extension CelebrationViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = (self.celebrationListModel?.data?.birthday_today_list!.count)! + (self.celebrationListModel?.data?.anniversary_today_list!.count)!  + (self.celebrationListModel?.data?.upcoming_birthday_today_list!.isEmpty)! ? 0 : 1
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //CelebrationListTableViewCell2
        //CelebrationListTableViewCell1
        //CelebrationListTableViewCell
        
        var cell = CelebrationListTableViewCell()
        return UITableViewCell()
    }
    
    
}

extension CelebrationViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.celebrationListModel?.data?.upcoming_birthday_today_list!.isEmpty)! ? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //celebrationListCollectionViewCell
        return UICollectionViewCell()
    }
    
    
}
