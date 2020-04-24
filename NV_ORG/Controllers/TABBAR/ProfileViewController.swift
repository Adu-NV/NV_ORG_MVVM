//
//  ProfileViewController.swift
//  NV_ORG
//
//  Created by Netventure on 28/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    var model : Profile?
    let profileVM = ProfileViewModel()
    @IBOutlet weak var profileTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    
    func setUI(){
        callWebservice()
    }
    
    func callWebservice(){
        Webservice.shared.profileRequest { (model, erroe) in
            debugPrint(model)
            if model != nil{
                self.profileVM.setProfileModel(model: model!)
                self.model = self.profileVM.getProfile()
            }
            DispatchQueue.main.async {
                self.profileTableView.reloadData()
            }
            
        }
    }

    @IBAction func editButtonTapped(_ sender: Any) {
        self.profileVM.edittapped(view: self)
    }
}

extension ProfileViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileVM.numberofSections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return profileVM.heightForRow(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = profileTableViewCell()
        if indexPath.row == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "profileTableViewCell0", for: indexPath) as! profileTableViewCell
            if let _ = model{
                //SplashScreen.pn
                cell.profileImageView!.sd_setImage(with: URL(string: (self.model?.profileImage!)!), placeholderImage:  UIImage(named: "profile.png"), options: .continueInBackground, completed: nil)
                cell.coverImageView!.sd_setImage(with: URL(string: (self.model?.coverImage!)!), placeholderImage:  UIImage(named: "SplashScreen.png"), options: .continueInBackground, completed: nil)
                cell.profileName.text = self.model?.name!
                cell.userPositionLabel.text = self.model?.occupation!
                cell.userMobileNumberLabel.text = self.model?.mobileNo!
                cell.userIDLabel.text = self.model?.memberID!
                
                cell.userEmailLabel.text = self.model?.email!
                cell.userSocietyLabel.text = self.model?.position!
                cell.userTeamLabel.text = self.model?.belong!
                cell.userJoiningLabel.text = self.model?.dateOfJoin!
            }
        
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "profileTableViewCell1", for: indexPath) as! profileTableViewCell
             if let _ = model{
                cell.userAddressLabel.text = self.model?.address!
                cell.userEducationLabel.text = self.model?.education!
                cell.userJobExperienceLabel.text = self.model?.job!
                cell.userCareerlabel.text = self.model?.career!
                
                cell.userMartialLabel.text = self.model?.maritial!
                cell.userSpouseLabel.text = self.model?.spouse!
                cell.usersLocationLabel.text = self.model?.currentLocation!
                cell.userCountryLabel.text = self.model?.country!
                cell.userPlaceInKeralaLabel.text = self.model?.placeInKerala!
                cell.userBuddyLabel.text = self.model?.buddyTree!
                cell.dateofPlannedLabel.text = self.model?.datePlanned!
            }
        }
        return cell
    }
    
    
}
