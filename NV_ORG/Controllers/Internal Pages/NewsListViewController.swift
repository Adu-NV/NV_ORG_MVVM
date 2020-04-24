//
//  NewsListViewController.swift
//  NV_ORG
//
//  Created by Netventure on 13/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {
var newsListVM = NewsListPageViewModel()
    @IBOutlet weak var newsListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        newsListVM.skipButtontapped(view: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    
    func setUI(){
        Webservice.shared.newsList { (model, message) in
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
        newsListVM.numberofSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListPageTableViewCell", for: indexPath) as! NewsListPageTableViewCell
        cell.newsListTitleLabel.text = newsListVM.ListAtIndex(indexPath.row).title
        cell.newsUpdationLabel.text = newsListVM.ListAtIndex(indexPath.row).update
        cell.newsPublishedLabel.text = newsListVM.ListAtIndex(indexPath.row).published
        cell.notificationTitleLabel.sd_setImage(with: URL(string: newsListVM.ListAtIndex(indexPath.row).url!), placeholderImage:  UIImage(named: "profile.png"), options: .continueInBackground, completed: nil)
        return cell
    }
    
    
}
