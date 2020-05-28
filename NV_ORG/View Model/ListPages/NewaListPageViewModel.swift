//
//  NewaListPageViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 15/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit
class NewsListPageViewModel{
    var list : [List] = [List()]
    var model : NewsListpageResponseModel!
//    init(){
//        model = nil
//    }
    
    init(_model : NewsListpageResponseModel) {
        model = _model
        list.removeAll()
        for i in 0 ..< (_model.data?.news_list?.count)!{
            list.append(List(_model.data?.news_list![i]))
        }
    }
    
    var numberofSections : Int {
        return  1
    }
    
    func numberOfRowsInSection(_ section : Int) -> Int{
        return model != nil ? (list.count) : 0
    }
    
    func heightForRow(_ row : Int) -> CGFloat{
        return UITableView.automaticDimension
    }
}
extension NewsListPageViewModel : NewsListPageViewModelDelegateProtocol{
    func skipButtontapped(view: UIViewController) {
        view.dismiss(animated: false, completion: nil)
    }
    
    func ListAtIndex(_ index : Int) -> List{
        return list[index]
    }
}

struct List{
    var title : String?
    var update : String?
    var published : String?
    var url : String?
    init() {
        self.title = ""
        self.published = ""
        self.update = ""
        self.url = ""
    }
    
    init(_ article : News_list_Page?) {
        self.title = article?.news_name
        self.update = article?.news_date
        self.published = article?.news_author_name
        self.url = article?.news_picture
    }
}
