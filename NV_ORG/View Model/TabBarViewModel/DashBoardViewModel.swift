//
//  DashBoardViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 30/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit
struct DashBoardViewModel{
    let mainStory =  UIStoryboard.init(name: "Main", bundle: nil)
    public var delegate : DashBoardViewModelViewControllerDelegateProtocol?
     let main =  UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    public var mainCell: [String] = [String]()
    public var request :  DashBoardFeedRequestModel?
    public var dashBoardFeedModel : DashBoardFeedResponseModel?

}

extension DashBoardViewModel : DashBoardViewModelDelegateProtocol{
    
     mutating func setDashBoardCell(model: DashBoardResponseData) {
        if model.is_news!{
            self.mainCell.append("DashBoardTableViewCell0")
        }
        if model.is_events!{
            self.mainCell.append("DashBoardTableViewCell1")
        }
        if model.is_meetings!{
            self.mainCell.append("DashBoardTableViewCell2")
        }
        if model.is_celebrating!{
            self.mainCell.append("DashBoardTableViewCell3")
        }
        if model.is_job_vacancy!{
            self.mainCell.append("DashBoardTableViewCell4")
        }
        if model.is_gallery!{
            self.mainCell.append("DashBoardTableViewCell5")
        }
        if model.is_advertisment!{
            self.mainCell.append("DashBoardTableViewCell6")
        }
        request = DashBoardFeedRequestModel(dashBoard: model)
    }
    
    func moveToMenuPage(viewController: UIViewController ,model : DashBoardResponseModel?) {
        main.model = model
        viewController.view.addSubview(main.view)
        main.didMove(toParent: viewController)
    }
    
    func skipButtontapped(view: UIViewController) {
        debugPrint(view)
        main.view.removeFromSuperview()
    }
    
    var numberofSections : Int {
         return  1
     }
    
    func numberOfRowsInSection(_ section : Int) -> Int{
        return self.mainCell.count
     }
    
    func heightForRow(_ row : Int) -> CGFloat{
        return UITableView.automaticDimension
    }

    func moveToGalleryList(viewController: UIViewController) {
        let gallery = mainStory.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        if #available(iOS 13.0, *) {
                            gallery.modalPresentationStyle = .fullScreen
            viewController.present(gallery, animated: true)
        }else{
            viewController.present(gallery, animated: false, completion: nil)
        }
    }
    
    func moveToGalleryImage(viewController: UIViewController ,id : String) {
        let galleryImage = mainStory.instantiateViewController(withIdentifier: "GalleryImageViewController") as! GalleryImageViewController
        galleryImage.galleryId = id
        if #available(iOS 13.0, *) {
                            galleryImage.modalPresentationStyle = .fullScreen
            viewController.present(galleryImage, animated: true)
        }else{
            viewController.present(galleryImage, animated: false, completion: nil)
        }
    }
    
    func moveToURLPage(viewController: UIViewController ,id : String) {
        guard let url = URL(string:id) else {
          return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func moveToJobList(viewController: UIViewController) {
        let jobs = mainStory.instantiateViewController(withIdentifier: "JobsListViewController") as! JobsListViewController
        if #available(iOS 13.0, *) {
                            jobs.modalPresentationStyle = .fullScreen
            viewController.present(jobs, animated: true)
        }else{
            viewController.present(jobs, animated: false, completion: nil)
        }
    }
    
    func moveToJobPage(viewController: UIViewController,id: String) {
        let jobDetail = mainStory.instantiateViewController(withIdentifier: "JobsDetailViewController") as! JobsDetailViewController
        jobDetail.jobId = id
        if #available(iOS 13.0, *) {
                            jobDetail.modalPresentationStyle = .fullScreen
            viewController.present(jobDetail, animated: true)
        }else{
            viewController.present(jobDetail, animated: false, completion: nil)
        }
    }
    
    
  
    func moveToCelebrationPage(viewController: UIViewController) {
        let jobDetail = mainStory.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
        if #available(iOS 13.0, *) {
                            jobDetail.modalPresentationStyle = .fullScreen
            viewController.present(jobDetail, animated: true)
        }else{
            viewController.present(jobDetail, animated: false, completion: nil)
        }
    }
    
    
    //MeetingsDetailsViewController
    func  moveToMeetingsPage(id: String, viewController: UIViewController){
        let meetings = mainStory.instantiateViewController(withIdentifier: "MeetingsDetailsViewController") as! MeetingsDetailsViewController
        meetings.id = id
        if #available(iOS 13.0, *) {
                            meetings.modalPresentationStyle = .fullScreen
            viewController.present(meetings, animated: true)
        }else{
            viewController.present(meetings, animated: false, completion: nil)
        }
    }
    //
//EventsViewController
    func  moveToEventsPage(id: String, viewController: UIViewController){
        let events = mainStory.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
        events.id = id
        if #available(iOS 13.0, *) {
                            events.modalPresentationStyle = .fullScreen
            viewController.present(events, animated: true)
        }else{
            viewController.present(events, animated: false, completion: nil)
        }
    }
    
    //NewsDetailViewController
    func moveToNewsDetailPage(id: String, viewController: UIViewController){
        let newsDetail = mainStory.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        newsDetail.news_date = id.setTime(format: "YYYY-MM-dd")
        if #available(iOS 13.0, *) {
                            newsDetail.modalPresentationStyle = .fullScreen
            viewController.present(newsDetail, animated: true)
        }else{
            viewController.present(newsDetail, animated: false, completion: nil)
        }
    }
}
