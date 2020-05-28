//
//  MenuViewController.swift
//  NV_ORG
//
//  Created by Netventure on 28/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController{
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var outsideVide: UIView!
    var dashModel :DashBoardViewModel!
    private var menuControllerVM : MenuControllerViewModel!
    internal var delegate  : MenuViewModelDelegateProtocol!
    var model : DashBoardResponseModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
       dashModel = DashBoardViewModel()
        self.menuTableView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpUI()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.view.removeFromSuperview()
//         dashModel.skipButtontapped(view: self)
    }
    func setUpUI(){
        backButton.setCornerRadiusWithoutBackground(radius: 6.0)
        self.menuControllerVM = MenuControllerViewModel(model: model)
        self.menuControllerVM.delegate = self
//        let _tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backButton))
//        self.menuTableView.addGestureRecognizer(_tap)
        self.menuTableView.reloadData()
    }
    
//    @objc func backButton(){
//        self.removeFromParent()
////        dashModel.skipButtontapped(view: self)
////        menuControllerVM.skipButtontapped(view: self)
//    }
}

extension MenuViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.menuControllerVM == nil ? 0 : self.menuControllerVM.numberofSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuControllerVM.numberOfRowsInSection(section)
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let  cell0 = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCells0", for: indexPath) as? MenuTableViewCells
//            let _tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backButton))
//            cell0!.contentView.addGestureRecognizer(_tap)
            cell0!.selectionStyle = .none
            return cell0!
        }else{
            let  cell1 = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCells1" , for: indexPath) as? MenuTableViewCells
            let menu = self.menuControllerVM.MenuAtIndex(indexPath.row - 1)
            cell1!.selectionStyle = .none
            cell1!.separatorInset = UIEdgeInsets(top: 0, left: 1500000, bottom: 0, right: 0)
            cell1!.menuLabel.text = menu.title
            cell1!.menuLabel.tag = indexPath.row
            cell1!.menuLabel.isUserInteractionEnabled = true
            let _tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectedRow(sender:)))
            
            cell1!.menuLabel.addGestureRecognizer(_tap)
            return cell1!
        }
     }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 80
        }else if indexPath.row > 0 && indexPath.row < self.menuControllerVM.numberOfRowsInSection(0){
            return 50
        }else{
            return 180
        }
    }
    
    @objc func selectedRow(sender: UITapGestureRecognizer){
        menuControllerVM.moveToPage(from: self, index: sender.view!.tag - 1)
    }
}

extension MenuViewController: MenuViewControllerDelegateProtocol{
    func didCallSignOutAPI() {
        Webservice.shared.signOutRequest{ (model, erroe) in
            self.menuControllerVM.moveToLogin()
        }
    }
   
}
