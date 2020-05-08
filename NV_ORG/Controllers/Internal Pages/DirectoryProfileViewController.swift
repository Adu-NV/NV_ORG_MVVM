//
//  DirectoryProfileViewController.swift
//  NV_ORG
//
//  Created by Netventure on 08/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit


import SDWebImage

class DirectoryProfileViewController: UIViewController {
    var model : DirectoryProfileResponseModel?
    let profileVM = ProfileViewModel()
    var directory = DirectoryProfileRequestModel()
    var id = ""
    @IBOutlet weak var directoryProfileTableView: UITableView!
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
        directory = DirectoryProfileRequestModel(_id: id)
        Webservice.shared.directoryProfile(body: directory.updateDic, completionBlock: { (model, errorString) in
            
            debugPrint(model)
            if model != nil{
                self.model = model
//                self.profileVM.setProfileModel(model: model!)
//                self.model = self.profileVM.getProfile()
            }else{
                 self.model = nil
            }
            DispatchQueue.main.async {
                self.directoryProfileTableView.reloadData()
            }
            
        })
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

extension DirectoryProfileViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model != nil ? 2 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = profileTableViewCell()
        if indexPath.row == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "profileTableViewCell0", for: indexPath) as! profileTableViewCell
            if let _ = model{
                //SplashScreen.pn
                cell.buttonHeightConstraint.constant = 30
                cell.profileImageView!.sd_setImage(with: URL(string: (self.model?.data?.member_picture)!), placeholderImage:  UIImage(named: "profile.png"), options: .continueInBackground, completed: nil)
                cell.coverImageView!.sd_setImage(with: URL(string: (self.model?.data?.member_cover_picture!)!), placeholderImage:  UIImage(named: "SplashScreen.png"), options: .continueInBackground, completed: nil)
                cell.profileName.text = (self.model?.data?.member_firstname!)! + (self.model?.data?.member_lastname)!
                cell.userPositionLabel.text = self.model?.data?.member_designation
                cell.userMobileNumberLabel.text = self.model?.data?.member_phone!
                cell.userIDLabel.text = "\((self.model?.data?.member_id!)!)"
                
                cell.userEmailLabel.text = self.model?.data?.member_email!
                cell.userSocietyLabel.text = self.model?.data?.member_position_society!
                cell.userTeamLabel.text = self.model?.data?.member_group!
                cell.userJoiningLabel.text = self.model?.data?.member_date_of_joining!
            }
        
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "profileTableViewCell1", for: indexPath) as! profileTableViewCell
             if let _ = model{
                cell.userAddressLabel.text = self.model?.data?.member_address!
                cell.userEducationLabel.text = self.model?.data?.member_education!
                cell.userJobExperienceLabel.text = self.model?.data?.member_job_experience!
                cell.userCareerlabel.text = self.model?.data?.member_career_profile!
                
                cell.userMartialLabel.text = self.model?.data?.member_martial_status!
                cell.userSpouseLabel.text = self.model?.data?.member_spouse_name != nil ?  self.model?.data?.member_spouse_name : ""
                cell.usersLocationLabel.text = self.model?.data?.member_state!
                cell.userCountryLabel.text = self.model?.data?.member_city!
                cell.userPlaceInKeralaLabel.text = self.model?.data?.member_city!
                cell.userBuddyLabel.text = self.model?.data?.member_buddy_tree!
                cell.dateofPlannedLabel.text = self.model?.data?.member_date_planted!
            }
        }
        return cell
    }
    
    
}
