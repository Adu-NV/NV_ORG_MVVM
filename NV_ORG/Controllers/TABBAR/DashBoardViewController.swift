//
//  DashBoardViewController.swift
//  NV_ORG
//
//  Created by Netventure on 28/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class DashBoardViewController: UIViewController {
    @IBOutlet weak var dashBoardTableView: UITableView!
    @IBOutlet weak var profileImageButton: UIButton!
    
    var dashModel : DashBoardResponseModel? = nil
    var dashViewModel : DashBoardViewModel?
    internal var delegate  : DashBoardViewModelDelegateProtocol!
    var updateCellContentsTimer : Timer!
    
    var updateAdvertisementTimer : Timer!
    var newsListcount = 0
    var advertisementListCount = 0
    var swipeLeft : UISwipeGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    @IBAction func profileButtonTapped(_ sender: Any) {
        dashViewModel!.moveToMenuPage(viewController: self, model: self.dashModel)
    }
    @objc func backButton(){
        dashViewModel!.skipButtontapped(view: self)
    }
}

//MARK:- userDefined Functions

extension DashBoardViewController : DashBoardViewModelViewControllerDelegateProtocol{
    func setUI(){
        updateCellContentsTimer = Timer.scheduledTimer(timeInterval: 7,target: self,selector: #selector(self.updateCells),userInfo: nil, repeats: true)
        updateAdvertisementTimer = Timer.scheduledTimer(timeInterval: 10,target: self,selector: #selector(self.updateAdvertisementCells),userInfo: nil, repeats: true)
        
        dashViewModel = DashBoardViewModel()
        let _tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backButton))
        self.view.addGestureRecognizer(_tap)
        profileImageButton.setCornerRadius(radius: self.profileImageButton.frame.height /  2, bg_Color: .clear)
        dashViewModel?.delegate = self
        callApi()
    }
    
    func callApi(){
        Webservice.shared.dsashBoardRequest { (model, erroe) in
            debugPrint(model)
            if model != nil {
                self.dashModel = model
                self.dashViewModel!.setDashBoardCell(model: (self.dashModel?.data)!)
                self.dashBoardFeedAPI()
            }
        }
    }
    
    @objc func updateCells(){
        if let _ = dashBoardTableView{
            if self.dashBoardTableView.numberOfRows(inSection: 0) != 0{
                newsListcount = (newsListcount == (self.dashViewModel?.dashBoardFeedModel?.data?.news_list!.count)! ? 0 : newsListcount)
                self.dashBoardTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with:.none)
            }
        }
    }
    
        @objc func updateAdvertisementCells(){
            if let _ = dashBoardTableView{
                if self.dashBoardTableView.numberOfRows(inSection: 0) != 0{
                    advertisementListCount = (advertisementListCount == (self.dashViewModel?.dashBoardFeedModel?.data?.advertisement_list!.count)! ? 0 : advertisementListCount)
                    self.dashBoardTableView.reloadRows(at: [IndexPath(row: 6, section: 0)], with: .left)
                }
    //advertisementListCount
            }
        }
    
    func dashBoardFeedAPI(){
        Webservice.shared.dashBoardFeed(body: self.dashViewModel!.request!.updateDic) { (model, message) in
            if model != nil{
                self.dashViewModel?.dashBoardFeedModel = model
                        DispatchQueue.main.async {
                    self.dashBoardTableView.reloadData()
                }
            }
        }
    }
}

extension DashBoardViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dashViewModel!.numberofSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dashViewModel?.numberOfRowsInSection(section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = DashBoardTableViewCell()
        switch self.dashViewModel?.mainCell[indexPath.row] {
        case "DashBoardTableViewCell0":
            cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardTableViewCell0", for: indexPath) as! DashBoardTableViewCell
            if  !(self.dashViewModel?.dashBoardFeedModel?.data?.news_list!.isEmpty)!{
                if (self.dashViewModel?.dashBoardFeedModel?.data?.news_list!.count)! - 1 == newsListcount{
                    newsListcount = 0
                }else{
                    newsListcount += 1
                }
                cell.newsTitleLabel.text = (self.dashViewModel?.dashBoardFeedModel?.data?.news_list![newsListcount].news_name)!
                cell.newsDescriptionLabel.text = (self.dashViewModel?.dashBoardFeedModel?.data?.news_list![newsListcount].news_brief)!
                cell.newsImageView.sd_setImage(with: URL(string: (self.dashViewModel?.dashBoardFeedModel?.data?.news_list![newsListcount].news_url)!), placeholderImage:  UIImage(named: "event.png"), options: .continueInBackground, completed: nil)
                swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.ImageViewSwipedLeft(sender:)))
                swipeLeft.delegate = self
                cell.newsImageView?.addGestureRecognizer(swipeLeft)
//                return cell
            }
            
        case "DashBoardTableViewCell1":
            cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardTableViewCell1", for: indexPath) as! DashBoardTableViewCell
            cell.eventsCollectionView.dataSource = self
            cell.eventsCollectionView.delegate = self
            cell.eventsCollectionView.tag = 1
            cell.eventsCollectionView.reloadData()
//            return cell
            
        case "DashBoardTableViewCell2":
            cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardTableViewCell2", for: indexPath) as! DashBoardTableViewCell
            cell.meetingsCollectionView.dataSource = self
            cell.meetingsCollectionView.delegate = self
            cell.meetingsCollectionView.tag = 2
            cell.meetingsCollectionView.layoutIfNeeded()
            cell.meetingsCollectionView.reloadData()
            
        case "DashBoardTableViewCell3":
            cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardTableViewCell3", for: indexPath) as! DashBoardTableViewCell
            cell.WishesCollectionView.dataSource = self
            cell.WishesCollectionView.delegate = self
            cell.WishesCollectionView.tag = 3
            cell.WishesCollectionView.layoutIfNeeded()
            cell.WishesCollectionView.reloadData()
            
        case "DashBoardTableViewCell4":
            cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardTableViewCell4", for: indexPath) as! DashBoardTableViewCell
             if !(self.dashViewModel?.dashBoardFeedModel?.data?.job_vacancy_list!.isEmpty)!{
                cell.jobTitle.text = (self.dashViewModel?.dashBoardFeedModel?.data?.job_vacancy_list![0].job_vacancy_name)!
                cell.jobExperienceLabel.text = (self.dashViewModel?.dashBoardFeedModel?.data?.job_vacancy_list![0].job_vacancy_occasion)!
                cell.jobSalaryLabel.text = (self.dashViewModel?.dashBoardFeedModel?.data?.job_vacancy_list![0].job_vacancy_occasion)!
            }
            
        case "DashBoardTableViewCell5":
             cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardTableViewCell5", for: indexPath) as! DashBoardTableViewCell
            cell.galleryCollectionView.dataSource = self
            cell.galleryCollectionView.delegate = self
            cell.galleryCollectionView.tag = 5
             
            cell.galleryCollectionView.layoutIfNeeded()
            cell.galleryCollectionView.reloadData()
        case "DashBoardTableViewCell6":
            cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardTableViewCell6", for: indexPath) as! DashBoardTableViewCell
             if !(self.dashViewModel?.dashBoardFeedModel?.data?.advertisement_list!.isEmpty)!{
                if (self.dashViewModel?.dashBoardFeedModel?.data?.advertisement_list!.count)! - 1 == advertisementListCount{
                    advertisementListCount = 0
                }else{
                    advertisementListCount += 1
                }
                cell.advertisementImageView.sd_setImage(with: URL(string: (self.dashViewModel?.dashBoardFeedModel?.data?.advertisement_list![advertisementListCount].advertisement_image_url)!), placeholderImage:  UIImage(named: "events.png"), options: .continueInBackground, completed: nil)
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightForRow : CGFloat!
        switch indexPath.row {
        case 0:
            heightForRow = !(self.dashViewModel?.dashBoardFeedModel?.data?.news_list!.isEmpty)! ? 200 : 0
        case 1:
            heightForRow = !(self.dashViewModel?.dashBoardFeedModel?.data?.event_list!.isEmpty)! ? 300 : 0
        case 2:
            heightForRow = !(self.dashViewModel?.dashBoardFeedModel?.data?.meetings_list!.isEmpty)! ? 150 : 0
        case 3:
            heightForRow = !(self.dashViewModel?.dashBoardFeedModel?.data?.celebration_list!.isEmpty)! ? 190 : 0
        case 4:
            heightForRow = !(self.dashViewModel?.dashBoardFeedModel?.data?.job_vacancy_list!.isEmpty)! ? 170 : 0
        case 5:
            heightForRow = !(self.dashViewModel?.dashBoardFeedModel?.data?.gallery_list!.isEmpty)! ? 170 : 0
        case 6:
            heightForRow = !(self.dashViewModel?.dashBoardFeedModel?.data?.advertisement_list!.isEmpty)! ? 150 : 0
        default:
            heightForRow = UITableView.automaticDimension
        }
        return heightForRow
    }
}

 
extension DashBoardViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 5{
             return (self.dashViewModel?.dashBoardFeedModel?.data?.gallery_list?.count)!
        }else if collectionView.tag == 1{
             return (self.dashViewModel?.dashBoardFeedModel?.data?.event_list?.count)!
        }else if collectionView.tag == 2{
             return (self.dashViewModel?.dashBoardFeedModel?.data?.meetings_list?.count)!
        }else{
             return (self.dashViewModel?.dashBoardFeedModel?.data?.celebration_list?.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = DashBoardCollectionViewCell()
        switch collectionView.tag{
            
        case 0,4,6:
         break
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier:"DashBoardCollectionViewCell" , for: indexPath) as! DashBoardCollectionViewCell
            if !(self.dashViewModel?.dashBoardFeedModel?.data?.event_list!.isEmpty)!{
                cell.eventNameLabel.text = (self.dashViewModel?.dashBoardFeedModel?.data?.event_list![indexPath.row].event_name)!
                cell.eventOrganiserLabel.text = (self.dashViewModel?.dashBoardFeedModel?.data?.event_list![indexPath.row].event_brief)!
                cell.eventDateLabel.text = (self.dashViewModel?.dashBoardFeedModel?.data?.event_list![indexPath.row].event_date)!
                cell.eventsImageView.sd_setImage(with: URL(string: (self.dashViewModel?.dashBoardFeedModel?.data?.event_list![indexPath.row].event_url)!), placeholderImage:  UIImage(named: "events.png"), options: .continueInBackground, completed: nil)
                cell.backgroundColor = .white
                cell.setShadow(radius: 10.0)
                return cell
            }else{
                return cell
            }
        case 2:
             cell = collectionView.dequeueReusableCell(withReuseIdentifier:"DashBoardCollectionViewCell" , for: indexPath) as! DashBoardCollectionViewCell
            if !(self.dashViewModel?.dashBoardFeedModel?.data?.meetings_list!.isEmpty)!{
                cell.meetingNameLabel.text = (self.dashViewModel?.dashBoardFeedModel?.data?.meetings_list![indexPath.row].meeting_name)!
                cell.meetingDateLabel.text = (self.dashViewModel?.dashBoardFeedModel?.data?.meetings_list![indexPath.row].meeting_date)!
                cell.meetingTimeLabel.text = (self.dashViewModel?.dashBoardFeedModel?.data?.meetings_list![indexPath.row].meeting_city)!
                cell.backgroundColor = .white
                cell.setShadow(radius: 10.0)
                return cell
            }else{
                    return cell
                }
        case 3:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier:"DashBoardCollectionViewCell" , for: indexPath) as! DashBoardCollectionViewCell
            if !(self.dashViewModel?.dashBoardFeedModel?.data?.celebration_list!.isEmpty)!{
                cell.wishesNameLabel.text = (self.dashViewModel?.dashBoardFeedModel?.data?.celebration_list![indexPath.row].celebration_name)!
                cell.wishesTitleLabel.text = (self.dashViewModel?.dashBoardFeedModel?.data?.celebration_list![indexPath.row].celebration_occasion)!
                cell.wishesImageView.sd_setImage(with: URL(string: (self.dashViewModel?.dashBoardFeedModel?.data?.celebration_list![indexPath.row].celebration_name)!), placeholderImage:  UIImage(named: "profile.png"), options: .continueInBackground, completed: nil)
                 cell.setShadow(radius: 10.0)
                return cell
            }else{
                return cell
            }
        case 5:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier:"DashBoardCollectionViewCell" , for: indexPath) as! DashBoardCollectionViewCell
            if !(self.dashViewModel?.dashBoardFeedModel?.data?.gallery_list!.isEmpty)!{//rightArrowbutton
                if (self.dashViewModel?.dashBoardFeedModel?.data?.gallery_list!.count)! - 1 == indexPath.row{
                    cell.rightArrowbutton.isHidden = false
                    cell.rightArrowbutton.tintColor = .black
                    cell.galleryImageView.alpha = 0.5
                     cell.galleryVE.alpha = 0.7
                }else{
                    cell.galleryVE.alpha = 0.0
                    cell.rightArrowbutton.isHidden = true
                    cell.galleryImageView.alpha = 1.0
                }
                cell.galleryImageView.sd_setImage(with: URL(string: (self.dashViewModel?.dashBoardFeedModel?.data?.gallery_list![indexPath.row].gallery_URL)!), placeholderImage:  UIImage(named: "events.png"), options: .continueInBackground, completed: nil)
                return cell
            }else{
                return cell
            }
        default :
            return cell
        }
        return cell
    }
}

extension DashBoardViewController : UIGestureRecognizerDelegate{
    @objc func ImageViewSwipedLeft(sender: UISwipeGestureRecognizer) {
        if sender.direction == .left{
            newsListcount += 1
            updateCells()
        }
      print("labelSwipedLeft called")
    }
}
