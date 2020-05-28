//
//  CelebrationViewController.swift
//  NV_ORG
//
//  Created by Netventure on 05/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class CelebrationViewController: UIViewController {
    var count = 0
    var celebrationListModel : CelebrationListResponseModel? = nil
    var layout = UICollectionViewFlowLayout()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var row = 0
    var activitiIndicatorView = UIView()
    
    @IBOutlet weak var celebrationListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.celebrationListTableView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    
    func setUI(){
        getList()
    }
    
    func getList(){
        activitiIndicatorView = self.showActivityIndicator(_message: "Please wait...")
        Webservice.shared.getCelebrationList { (model, error) in
            self.hideActivityIndicator(uiView: self.activitiIndicatorView)
            if let _ = model{
                self.celebrationListModel = model
            }else{
                self.celebrationListModel = nil
            }
            DispatchQueue.main.async {
                self.celebrationListTableView.reloadData()
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}


extension CelebrationViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = self.celebrationListModel{
            count += (self.celebrationListModel?.data?.birthday_today_list!.count)! + (!((self.celebrationListModel?.data?.birthday_today_list!.isEmpty)!) ? 1 : 0)
            count += (self.celebrationListModel?.data?.anniversary_today_list!.count)! + (!((self.celebrationListModel?.data?.anniversary_today_list!.isEmpty)!) ? 1 : 0)
            count += (self.celebrationListModel?.data?.upcoming_birthday_today_list!.isEmpty)! ? 0 : 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = CelebrationListTableViewCell()
        if !((self.celebrationListModel?.data?.birthday_today_list!.isEmpty)!)  && indexPath.row - 1 < (self.celebrationListModel?.data?.birthday_today_list!.count)! {
            if indexPath.row == 0{
                cell = tableView.dequeueReusableCell(withIdentifier: "CelebrationListTableViewCell", for: indexPath) as! CelebrationListTableViewCell
                cell.celebrationsTodayLabel.text = "Birthday's Today"
            }else{
                 cell = tableView.dequeueReusableCell(withIdentifier: "CelebrationListTableViewCell1", for: indexPath) as! CelebrationListTableViewCell
                cell.celebrationNameLabel.text = (self.celebrationListModel?.data?.birthday_today_list![indexPath.row - 1].user_celebration_name)!
                cell.celebrationYearlabel.text = "\((self.celebrationListModel?.data?.birthday_today_list![indexPath.row - 1].user_celebration_age)!) years"
                cell.celebrationTitle.text = "Greet with"
                cell.imageView?.sd_setImage(with: URL(string: (self.celebrationListModel?.data?.birthday_today_list![indexPath.row - 1].user_celebration_profile_picture)!), placeholderImage: UIImage(named: "profile.png"), options: .continueInBackground, context: nil)
            }
            return cell
        }
        if !((self.celebrationListModel?.data?.upcoming_birthday_today_list!.isEmpty)!) && indexPath.row == (self.celebrationListModel?.data?.birthday_today_list!.count)! + 1  {
            cell = tableView.dequeueReusableCell(withIdentifier: "CelebrationListTableViewCell2", for: indexPath) as! CelebrationListTableViewCell
            cell.celebrationCollectionView.delegate = self
            cell.celebrationCollectionView.dataSource = self
            cell.celebrationCollectionView.reloadData()
            return cell
        }
        if !((self.celebrationListModel?.data?.anniversary_today_list!.isEmpty)!) &&  row < (self.celebrationListModel?.data?.anniversary_today_list!.count)! {
            row = indexPath.row - ((self.celebrationListModel?.data?.upcoming_birthday_today_list!.isEmpty)! ? 0 : 1)
            row -= (self.celebrationListModel?.data?.birthday_today_list!.count)! + 1
            if row == 0{
                cell = tableView.dequeueReusableCell(withIdentifier: "CelebrationListTableViewCell", for: indexPath) as! CelebrationListTableViewCell
                cell.celebrationsTodayLabel.text = "Anniversary's Today"
            }else{
                cell = tableView.dequeueReusableCell(withIdentifier: "CelebrationListTableViewCell1", for: indexPath) as! CelebrationListTableViewCell
                cell.celebrationNameLabel.text = (self.celebrationListModel?.data?.anniversary_today_list![row - 1].user_celebration_name)!
                cell.celebrationYearlabel.text = "Celebrating \((self.celebrationListModel?.data?.anniversary_today_list![row - 1].user_celebration_age)!) years "
                cell.celebrationTitle.text = "Greet with"
                cell.imageView?.sd_setImage(with: URL(string: (self.celebrationListModel?.data?.anniversary_today_list![row - 1].user_celebration_profile_picture)!), placeholderImage: UIImage(named: "profile.png"), options: .continueInBackground, context: nil)
            }
            return cell
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  !((self.celebrationListModel?.data?.upcoming_birthday_today_list!.isEmpty)!) && indexPath.row == (self.celebrationListModel?.data?.birthday_today_list!.count)! + (!((self.celebrationListModel?.data?.birthday_today_list!.isEmpty)!) ? 1 : 0) {
            return 230
        }else{
            return UITableView.automaticDimension
        }
        
    }
    
    
}

extension CelebrationViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.celebrationListModel?.data?.upcoming_birthday_today_list!.isEmpty)! ? 0 : (self.celebrationListModel?.data?.upcoming_birthday_today_list!.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = celebrationListCollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celebrationListCollectionViewCell", for: indexPath) as! celebrationListCollectionViewCell
        cell.celebrationPersonImageView.sd_setImage(with: URL(string: (self.celebrationListModel?.data?.upcoming_birthday_today_list![indexPath.row].user_celebration_profile_picture)!), placeholderImage: nil, options: .continueInBackground, context: nil)
         cell.celebrationPersonNameLabel.text = (self.celebrationListModel?.data?.upcoming_birthday_today_list![indexPath.row].user_celebration_name)!
        cell.celbrationDateLabel.text = "\((self.celebrationListModel?.data?.upcoming_birthday_today_list![indexPath.row].user_celebration_age)!) years"
        cell.backgroundColor = CELEBRATION_BACKGROUND
        cell.celebrationPersonImageView.setImageViewCornerRadius(radius: 20.0)
        return cell
    }
    
    
}
