//
//  JobsDetailViewController.swift
//  NV_ORG
//
//  Created by Netventure on 05/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class JobsDetailViewController: UIViewController {
    var jobId : String = ""
    var jobDetail : JobDetailResponseModel? = nil
    @IBOutlet weak var jobDetailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpUI()
    }
    func setUpUI(){
        getDetails()
    }

    func getDetails(){
        Webservice.shared.getJobDetail(id: jobId) { (model, error) in
            if let _ = model{
                self.jobDetail  = model
            }
            else{
                self.jobDetail = nil
            }
            DispatchQueue.main.async {
                self.jobDetailTableView.reloadData()
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

extension JobsDetailViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = jobDetail{
             return (jobDetail?.data?.related_jobs_list!.isEmpty)! ? 1 : (jobDetail?.data?.related_jobs_list!.count)! + 1
        }else{
            return 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = JobDetailTableViewCell()
        if indexPath.row == 0{
            
            cell =  tableView.dequeueReusableCell(withIdentifier: "JobDetailTableViewCell", for: indexPath) as! JobDetailTableViewCell
            cell.jobCompanyLogo.sd_setImage(with: URL(string: (jobDetail?.data?.job_details![0].job_vacancy_company_logo)!), placeholderImage: UIImage(named:"netventure.png"), options: .continueInBackground, completed: nil)
            cell.jobTitleLabel.text = (jobDetail?.data?.job_details![0].job_vacancy_name)!
            cell.jobCompanyNameLabel.text = (jobDetail?.data?.job_details![0].job_vacancy_company_name)!
            cell.jobLocationLabel.text = (jobDetail?.data?.job_details![0].job_vacancy_location)!
            cell.jobPriceLAbel.text = (jobDetail?.data?.job_details![0].job_vacancy_package)!
            cell.jobUpdatedLabel.text = (jobDetail?.data?.job_details![0].job_posted_date)!
//            cell.jobExperienceLabel.text = (jobDetail?.data?.job_details![0].)!
//            cell.jobDescriptionLabel.text = (jobDetail?.data?.job_details![0].job_brief)!
            cell.contentView.setViewCornerRadiusWithBorder(radius: 3.0, borderColor: .lightGray, width: 0.5)
            
            
        }else{
            cell =  tableView.dequeueReusableCell(withIdentifier: "JobDetailTableViewCell1", for: indexPath) as! JobDetailTableViewCell
            cell.jobCompanyLogo.sd_setImage(with: URL(string: (jobDetail?.data?.related_jobs_list![indexPath.row - 1].job_vacancy_company_logo)!), placeholderImage: UIImage(named:"netventure.png"), options: .continueInBackground, completed: nil)
            cell.jobTitleLabel.text = (jobDetail?.data?.related_jobs_list![indexPath.row - 1].job_vacancy_name)!
            cell.jobCompanyNameLabel.text = (jobDetail?.data?.related_jobs_list![indexPath.row - 1].job_vacancy_company_name)!
            cell.jobLocationLabel.text = (jobDetail?.data?.related_jobs_list![indexPath.row - 1].job_vacancy_location)!
            cell.jobPriceLAbel.text = (jobDetail?.data?.related_jobs_list![indexPath.row - 1].job_vacancy_package)!
            cell.jobUpdatedLabel.text = (jobDetail?.data?.related_jobs_list![indexPath.row - 1].job_posted_date)!
            cell.selectionStyle = .none
             cell.relatedView.setViewCornerRadiusWithBorder(radius: 8.0, borderColor: .lightGray, width: 0.5)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //JobDetailTableViewCell
//    JobDetailTableViewCell1
    
}
