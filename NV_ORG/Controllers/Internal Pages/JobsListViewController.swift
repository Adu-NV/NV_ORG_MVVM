//
//  JobsListViewController.swift
//  NV_ORG
//
//  Created by Netventure on 05/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class JobsListViewController: UIViewController {
    var activitiIndicatorView = UIView()
    var jobTypes : JobTypeResponseModel? = nil
    var jobList : JobsPageListResponseModel? = nil
    var jobRequest = JobListRequestModel()
    var search_Key = ""
    var job_Type = ""
    let mainStory =  UIStoryboard.init(name: "Main", bundle: nil)
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    
    @IBOutlet weak var jobSearch: UISearchBar!
    @IBOutlet weak var jobSegment: UISegmentedControl!
    @IBOutlet weak var jobListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpUI()
    }
    
    func setUpUI(){
        jobRequest = JobListRequestModel(_state: "", _search_word: search_Key, _job_type: job_Type)
        self.getList()
    }
    
    func getList(){
        activitiIndicatorView = self.showActivityIndicator(_message: "Please wait...")
        Webservice.shared.jobsList(body: jobRequest.updateDic) { (model, error) in
            self.hideActivityIndicator(uiView: self.activitiIndicatorView)
            if let _ = model{
                self.jobList = model
                DispatchQueue.main.async {
                    self.jobListTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func jobsSegmentTapped(_ sender: UISegmentedControl) {
        if sender.tag == 1{
            jobRequest = JobListRequestModel(_state: UserDefaults.standard.value(forKey: "state") as! String, _search_word: search_Key, _job_type: job_Type)
        }else{
            jobRequest = JobListRequestModel(_state: "", _search_word: search_Key, _job_type: job_Type)
        }
        self.getList()
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
    
    @IBAction func filterTapped(_ sender: Any) {
        self.getTypes()
    }
    
    func setJobTypesPicker(){
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = PICKER_BACKGROUND
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        jobRequest = JobListRequestModel(_state: UserDefaults.standard.value(forKey: "state") as! String, _search_word: search_Key, _job_type: job_Type)
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        self.getList()
    }
    
    func getTypes(){
        Webservice.shared.getJobTypesList { (model, errorMessage) in
            if let _ = model{
                DispatchQueue.main.async {
                    self.jobTypes = model
                    self.setJobTypesPicker()
                }
            }
        }
    }
}

extension JobsListViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jobList?.data != nil ? (self.jobList?.data?.job_vacancy_list!.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = JobListTableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "JobListTableViewCell", for: indexPath) as! JobListTableViewCell
        cell.jobCompanyLabel.text = (self.jobList?.data?.job_vacancy_list![indexPath.row].job_vacancy_company_name)!
        cell.jobLocationLabel.text = (self.jobList?.data?.job_vacancy_list![indexPath.row].job_vacancy_location)!
        cell.jobTitleLabel.text = (self.jobList?.data?.job_vacancy_list![indexPath.row].job_vacancy_name)!
        cell.jobUpdatedLabel.text = (self.jobList?.data?.job_vacancy_list![indexPath.row].job_posted_date)!
        cell.jobExperinceLabel.text = (self.jobList?.data?.job_vacancy_list![indexPath.row].job_vacancy_package)!
        cell.jobImage.sd_setImage(with: URL(string: (self.jobList?.data?.job_vacancy_list![indexPath.row].job_vacancy_company_logo)!) , placeholderImage: UIImage(named: "netventure.png"), options: .continueInBackground, completed: nil)
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jobDetail = mainStory.instantiateViewController(withIdentifier: "JobsDetailViewController") as! JobsDetailViewController
        jobDetail.jobId = (self.jobList?.data?.job_vacancy_list![0].job_vacancy_id)!
        if #available(iOS 13.0, *) {
            self.navigationController?.pushViewController(jobDetail, animated: false)
        }else{
            self.present(jobDetail, animated: false, completion: nil)
        }
    }
}

extension JobsListViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (self.jobTypes?.data?.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (self.jobTypes?.data![row].name)!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        debugPrint(self.jobTypes?.data![row].name)
        job_Type = (self.jobTypes?.data![row].name)!
    }
}

