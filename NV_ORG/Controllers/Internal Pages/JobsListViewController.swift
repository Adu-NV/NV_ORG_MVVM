//
//  JobsListViewController.swift
//  NV_ORG
//
//  Created by Netventure on 05/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class JobsListViewController: UIViewController {
    var _searchText = ""
    var tag = 0
    var tempjobList : [Job_details] = []
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
    @IBOutlet weak var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.jobListTableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: "EmptyTableViewCell")
        self.jobListTableView.tableFooterView = UIView()
        jobSearch.delegate = self
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
                self.tempjobList = self.jobList?.data?.job_vacancy_list as! [Job_details]
                DispatchQueue.main.async {
                    self.jobListTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func jobsSegmentTapped(_ sender: UISegmentedControl) {
        if tag != sender.tag{
            jobSearch.text = ""
            jobSearch.showsCancelButton = false
        }
        if sender.tag == 1{
            tag = sender.tag
            jobRequest = JobListRequestModel(_state: UserDefaults.standard.value(forKey: "state") as! String, _search_word: search_Key, _job_type: job_Type)
        }else{
            tag = sender.tag
            jobRequest = JobListRequestModel(_state: "", _search_word: search_Key, _job_type: job_Type)
        }
        self.getList()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        
        self.getTypes()
    }
    
    func setJobTypesPicker(){
         jobSearch.endEditing(true)
        self.filterButton.isEnabled = false
        self.filterButton.setImage(nil, for: .normal)
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
        self.filterButton.isEnabled = true
        self.filterButton.setImage(UIImage(named: "filter.png"), for: .normal)
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
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        jobSearch.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.tempjobList.count  == 0{
            return tableView.frame.height
        }else{
            return  UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tempjobList.count == 0 ? 1 : self.tempjobList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = JobListTableViewCell()
        if self.tempjobList.isEmpty{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
            //            cell.noDataImageView.image = UIImage(named: "nodatafound.png")
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = "No Jobs Found...!"
            return cell
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "JobListTableViewCell", for: indexPath) as! JobListTableViewCell
            cell.jobCompanyLabel.text = (self.tempjobList[indexPath.row].job_vacancy_company_name)!
            cell.jobLocationLabel.text = (self.tempjobList[indexPath.row].job_vacancy_location)!
            cell.jobTitleLabel.text = (self.tempjobList[indexPath.row].job_vacancy_name)!
            cell.jobUpdatedLabel.text = (self.tempjobList[indexPath.row].job_posted_date)!.setTime(format: "dd MMM YYYY")
            cell.jobExperinceLabel.text = (self.tempjobList[indexPath.row].job_vacancy_package)!
            cell.jobImage.sd_setImage(with: URL(string: (self.tempjobList[indexPath.row].job_vacancy_company_logo)!) , placeholderImage: UIImage(named: "netventure.png"), options: .continueInBackground, completed: nil)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jobDetail = mainStory.instantiateViewController(withIdentifier: "JobsDetailViewController") as! JobsDetailViewController
        jobDetail.jobId = (tempjobList[0].job_vacancy_id)!
        if #available(iOS 13.0, *) {
            jobDetail.modalPresentationStyle = .fullScreen
            self.present(jobDetail, animated: true)
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
        job_Type = (self.jobTypes?.data![row].name)!
    }
}

extension JobsListViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        _searchText = searchBar.text!
        self.tempjobList = (searchBar.text!.isEmpty ? self.jobList?.data?.job_vacancy_list : self.jobList?.data?.job_vacancy_list!.filter {
            return ($0.job_vacancy_company_name!.range(of:searchBar.text!,options:.caseInsensitive) != nil || $0.job_vacancy_country!.range(of:searchBar.text!,options:.caseInsensitive) != nil || $0.job_vacancy_name!.range(of:searchBar.text!,options:.caseInsensitive) != nil || $0.job_vacancy_location!.range(of:searchBar.text!,options:.caseInsensitive) != nil)
            } as! [Job_details])!
        self.jobListTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        jobSearch.endEditing(true)
                self.tempjobList = (searchBar.text!.isEmpty ? self.jobList?.data?.job_vacancy_list : self.jobList?.data?.job_vacancy_list!.filter {
            return ($0.job_vacancy_company_name!.range(of:searchBar.text!,options:.caseInsensitive) != nil || $0.job_vacancy_country!.range(of:searchBar.text!,options:.caseInsensitive) != nil || $0.job_vacancy_name!.range(of:searchBar.text!,options:.caseInsensitive) != nil || $0.job_vacancy_location!.range(of:searchBar.text!,options:.caseInsensitive) != nil)
            } as! [Job_details])!
        self.jobListTableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        jobSearch.endEditing(true)
        searchBar.showsCancelButton = false
        _searchText = ""
        searchBar.text! = ""
        self.tempjobList = self.jobList?.data?.job_vacancy_list as! [Job_details]
        self.jobListTableView.reloadData()
    }
    
}

