//
//  NewsDetailViewController.swift
//  NV_ORG
//
//  Created by Netventure on 05/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit
import FSCalendar

class NewsDetailViewController: UIViewController {
    var dates : [String] = [String]()
    var formatter = DateFormatter()
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet var fsCalenderView: UIView!
    
    var calender1: FSCalendar!
    var dateString = ""
    var news_id = ""
    var news_date = ""
    var count = 0
    var dic = Dictionary<String,String>()
    var newsModel : NewsDetailsResponseModel?  = nil
     var activitiIndicatorView = UIView()
    var swipeRight = UISwipeGestureRecognizer()
    var swipeLeft  = UISwipeGestureRecognizer()
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var newsDetailTableView: UITableView!
    @IBOutlet weak var newsPageController: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.newsDetailTableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: "EmptyTableViewCell")
    }
    
    @IBAction func dateButtonTapped(_ sender: Any) {
        getNewsDates()
    }
    
    @IBAction func viewAllButtonTapped(_ sender: Any) {
        //NewsListViewController
        let newsList = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
        newsList.delegate = self
        if #available(iOS 13.0, *) {
            newsList.modalPresentationStyle = .fullScreen
            self.present(newsList, animated: true)
        }else{
            self.present(newsList, animated: false, completion: nil)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        previousButton.setCornerRadius(radius: 6.0, bg_Color: BUTTON_SELECTED_COLOR)
        nextButton.setCornerRadius(radius: 6.0, bg_Color: BUTTON_SELECTED_COLOR)
        getNewsDetails()
    }
    
    func getNewsDetails(){
        buttonsView.isUserInteractionEnabled = false
        activitiIndicatorView = self.showActivityIndicator(_message: "Please wait...")
        dic["news_id"] = news_id
        dic["news_date"] = news_date
        Webservice.shared.newsDetails(body: dic) { (model, error) in
            self.hideActivityIndicator(uiView: self.activitiIndicatorView)
            if let  _ = model{
                self.newsModel = model
            }else{
                self.newsModel = nil
            }
            self.setUI()
            
        }
    }
    
    func setUI(){
        DispatchQueue.main.async {
            self.buttonsView.isUserInteractionEnabled = true
            self.newsPageController.currentPage = self.count
            self.newsPageController.numberOfPages = (self.newsModel?.data?.current_news_details?.count)!
            if (self.newsModel?.data?.next_date) == nil || (self.newsModel?.data?.next_date)! == ""{
                self.nextButton.isEnabled = false
                self.nextButton.backgroundColor = BUTTON_UNSELECTED_COLOR
            }else{
                self.nextButton.isEnabled = true
                self.nextButton.backgroundColor = BUTTON_SELECTED_COLOR
            }
            if (self.newsModel?.data?.previous_date) == nil || (self.newsModel?.data?.previous_date)! == ""{
                self.previousButton.isEnabled = false
                self.previousButton.backgroundColor = BUTTON_UNSELECTED_COLOR
            }else{
                self.previousButton.isEnabled = true
                self.previousButton.backgroundColor = BUTTON_SELECTED_COLOR
            }
           self.newsDetailTableView.reloadData()
            self.newsDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        news_date = (self.newsModel?.data?.next_date)!.setTime(format: "YYYY-MM-dd")
        news_id = ""
        count = 0
        getNewsDetails()
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        news_date = (self.newsModel?.data?.previous_date)!.setTime(format: "YYYY-MM-dd")
        news_id = ""
        count = 0
        getNewsDetails()
    }
}

extension NewsDetailViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let _ = newsModel{
            return (newsModel?.data?.current_news_details!.isEmpty)! ?  tableView.frame.height : UITableView.automaticDimension
        }else{
            return tableView.frame.height
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = NewsDetailTableViewCell()
        if let _ =  newsModel{
            if (newsModel?.data?.current_news_details!.isEmpty)!{
                let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
//                cell.noDataImageView.image = UIImage(named: "nodatafound.png")
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.text = "No Data Available"
                return cell
            }else{
                cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailTableViewCell", for: indexPath) as! NewsDetailTableViewCell
                           if (self.newsModel?.data?.current_news_details?.count)! > 0{
                               swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeTapped(sender:)))
                               swipeRight.numberOfTouchesRequired = 1
                           }
                           cell.newsBackGroundView.setViewCornerRadiusWithBorder(radius: 6.0, borderColor: BUTTON_UNSELECTED_COLOR, width: 0.5)
                           cell.newsTitleLabel.text = (newsModel?.data?.current_news_details![count].news_name)!
                           cell.newsUpdatedLabel.text = (newsModel?.data?.current_news_details![count].news_date)!.setTime(format: "dd MMM YYYY")
                           cell.newsDescriptionLabel.text = (newsModel?.data?.current_news_details![count].news_brief)!
                           cell.publishedAuthorLabel.text = (newsModel?.data?.current_news_details![count].news_author)!
                           if (newsModel?.data?.current_news_details![indexPath.row].news_url) != nil{
                               cell.newImageView.sd_setImage(with: URL(string: "\((newsModel?.data?.current_news_details![count].news_url)!)"), completed: nil)
                               cell.newImageView.setImageViewCornerRadiusWithBorder(radius: 6.0, borderwidth: 0.5, color: BUTTON_UNSELECTED_COLOR)
                               cell.imageViewheight.constant = 150
                           }else{
                               cell.imageViewheight.constant = 0
                           }
                           return cell
            }
           
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        if count >= 0{
            if (self.newsModel?.data?.current_news_details?.count)! > count{
                count -= 1
                if self.count != -1{
                    self.setUI()
                }
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        if (self.newsModel?.data?.current_news_details?.count)! > count{
            count += 1
            if self.count != (self.newsModel?.data?.current_news_details?.count)!{
                self.setUI()
            }
        }
        return nil
    }
    
    @objc func swipeTapped(sender : UISwipeGestureRecognizer){
        if sender.direction == .left{
        }else{
        }
    }
    
    @objc func swipeRightTapped(sender : UISwipeGestureRecognizer){
    }
    
    @objc func swipeLeftTapped(sender : UISwipeGestureRecognizer){
    }
}

extension NewsDetailViewController : FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance{
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.fsCalenderView.removeFromSuperview()
    }
    
    func getNewsDates(){
        self.dates.removeAll()
        activitiIndicatorView = self.showActivityIndicator(_message: "Please wait...")
        Webservice.shared.getNewsDates { (model, error) in
            self.hideActivityIndicator(uiView: self.activitiIndicatorView)
            if let _ = model{
                if !(model?.data?.news_date_list!.isEmpty)!{
                    for i in 0 ..< (model?.data?.news_date_list!.count)!{
                        self.dates.append((model?.data?.news_date_list![i].news_date)!.setTime(format: "yyyy-MM-dd"))
                    }
                }
                DispatchQueue.main.async {
                    self.view.addSubview(self.setCalenderUI())
                    self.setFsCalenderDates()
                }
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateStr = self.formatter.string(from: date)
        dateString = dateStr
        news_date = dateString
        news_id = ""
        getNewsDetails()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.formatter.string(from: date)
        if self.dates.contains(dateString) {
            return 1
        }
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        let dateString = self.formatter.string(from: date)
        if self.dates.contains(dateString) {
            return 6.0
               }
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
                let dateString = self.formatter.string(from: date)
        if self.dates.contains(dateString) {
            return [.blue]
        }
        return [.white]
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
         let dateString = self.formatter.string(from: date)
        if self.dates.contains(dateString) {
            return [.green]
        }
        return [.blue]
    }
    
    func setFsCalenderDates(){
        formatter.dateFormat = "yyyy-MM-dd"
    }
    
    func setCalenderUI() -> UIView{

        self.fsCalenderView = UIView(frame: CGRect(x: self.view.frame.width - 240, y: 70, width: 240, height: 220))
        self.fsCalenderView.setViewCornerRadiusWithBorder(radius: 6.0, borderColor: BUTTON_LIGHT_GREEN_COLOR, width: 0.5)
        self.calender1 = FSCalendar(frame: CGRect(x:10, y: 30, width: 220, height: 190))
        let buttonClose = UIButton(frame: CGRect(x: self.fsCalenderView.frame.width - 25, y: 5, width: 20, height: 20))
        buttonClose.setImage(UIImage(named: "close.png"), for: .normal)
        buttonClose.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        self.fsCalenderView.backgroundColor = BUTTON_UNSELECTED_COLOR
        self.calender1.delegate = self
        self.calender1.dataSource = self
        self.calender1.scope = .month
        self.calender1.placeholderType = .none
        self.calender1.allowsSelection = true
        self.fsCalenderView.addSubview(self.calender1)
        self.fsCalenderView.addSubview(buttonClose)
        return self.fsCalenderView
    }
}

extension NewsDetailViewController : NewsListProtocol{
    func didSelectNews(news_dates: String, viewController: UIViewController) {
        viewController.dismiss(animated: false, completion: nil)
         news_date = news_dates.setTime(format: "YYYY-MM-dd")
    }
    
    
}


