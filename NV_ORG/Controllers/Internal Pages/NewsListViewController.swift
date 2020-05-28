//
//  NewsListViewController.swift
//  NV_ORG
//
//  Created by Netventure on 13/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit
import Foundation
import FSCalendar


class NewsListViewController: UIViewController {
    var delegate : NewsListProtocol?
    var newsListVM : NewsListPageViewModel? = nil
    var activitiIndicatorView = UIView()
    @IBOutlet weak var newsListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        newsListVM!.skipButtontapped(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    
    func setUI(){
         activitiIndicatorView = self.showActivityIndicator(_message: "Please wait...")
        Webservice.shared.newsList { (model, message) in
            self.hideActivityIndicator(uiView: self.activitiIndicatorView)
            if model != nil{
                self.newsListVM = NewsListPageViewModel(_model: model!)
                DispatchQueue.main.async {
                     self.newsListTableView.reloadData()
                }
            }
        }
    }
}

extension NewsListViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if let _ = newsListVM{
            return newsListVM!.numberofSections
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = newsListVM{
           return newsListVM!.numberOfRowsInSection(section)
        }else{
             return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let _ = self.newsListVM{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListPageTableViewCell", for: indexPath) as! NewsListPageTableViewCell
            cell.newsListTitleLabel.text = newsListVM!.ListAtIndex(indexPath.row).title
            cell.newsUpdationLabel.text = newsListVM!.ListAtIndex(indexPath.row).update != "" ? newsListVM!.ListAtIndex(indexPath.row).update?.setTime(format: "dd MMM YYYY") : ""
            cell.newsPublishedLabel.text = newsListVM!.ListAtIndex(indexPath.row).published
            cell.notificationTitleLabel.sd_setImage(with: URL(string: newsListVM!.ListAtIndex(indexPath.row).url!), placeholderImage:  UIImage(named: "profile.png"), options: .continueInBackground, completed: nil)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectNews(news_dates: (newsListVM!.ListAtIndex(indexPath.row).update)!, viewController: self)
    }
}


