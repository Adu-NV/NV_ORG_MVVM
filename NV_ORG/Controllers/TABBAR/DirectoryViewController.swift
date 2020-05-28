//
//  DirectoryViewController.swift
//  NV_ORG
//
//  Created by Netventure on 28/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit
import SDWebImage

class DirectoryViewController: UIViewController {
    var _searchText = ""
    var dic = Dictionary<String,String>()
    var activitiIndicatorView = UIView()
    let directoryVM = DirectoryViewModel()
    @IBOutlet weak var directorySearchBar: UISearchBar!
    @IBOutlet weak var directoryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.directoryTableView.tableFooterView = UIView()
        self.directoryTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.directoryTableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: "EmptyTableViewCell")
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.removeObject(forKey: "dic")
    }
    
    func setUIFromFilter(){
        activitiIndicatorView = self.showActivityIndicator(_message: "Please wait...")
        Webservice.shared.directorySearch(body: dic) { (model, message) in
            self.hideActivityIndicator(uiView: self.activitiIndicatorView)
            if let _ = model{
                self.directoryVM.setUpModel(model: model!)
                DispatchQueue.main.async {
                    self.directoryTableView.reloadData()
                }
            }
        }
    }
    
    func setUI(){
        activitiIndicatorView = self.showActivityIndicator(_message: "Please wait...")
        Webservice.shared.getDirectoryLis { (model, message) in
            self.hideActivityIndicator(uiView: self.activitiIndicatorView)
            if let _ = model{
                self.directoryVM.setUpModel(model: model!)
                DispatchQueue.main.async {
                    self.directoryTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        let main =  UIStoryboard.init(name: "Main", bundle: nil)
        let viewC = main.instantiateViewController(withIdentifier: "DirectoryFilterViewController") as! DirectoryFilterViewController
        viewC.delegate = self
        if #available(iOS 13.0, *) {
            viewC.modalPresentationStyle = .overFullScreen
            self.present(viewC, animated: true)
        }else{
            self.present(viewC, animated: false, completion: nil)
        }
    }
}

extension DirectoryViewController : DirectoryFilterDelegate{
    func didSelect(_dic: Dictionary<String, String> ,viewController : UIViewController ) {
        viewController.dismiss(animated: false, completion: nil)
        self.dic = _dic
        setUIFromFilter()
    }
 }

extension DirectoryViewController :UITableViewDelegate,UITableViewDataSource{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        directorySearchBar.endEditing(true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        directoryVM.numberofSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.directoryVM.templist.count == 0 ? 1 : self.directoryVM.templist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.directoryVM.templist.isEmpty{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = "No Data Found...!"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DirectoryTableViewCell", for: indexPath) as! DirectoryTableViewCell
            if !(indexPath.row >= self.directoryVM.templist.count){
                cell.directoryNameLabel.text = self.directoryVM.templist[indexPath.row].name
                cell.positionHeightConstraint.constant = self.directoryVM.templist[indexPath.row].position != "" ? 30 : 0
                cell.directorypositionLabel.text = self.directoryVM.templist[indexPath.row].position == "" ? self.directoryVM.templist[indexPath.row].number : self.directoryVM.templist[indexPath.row].position
                cell.directoryMobileLabel.text = self.directoryVM.templist[indexPath.row].position == "" ? "" : self.directoryVM.templist[indexPath.row].number
                let imageStr = (self.directoryVM.templist[indexPath.row].image)!
                cell.directoryProfileImageView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "profile.png"), options: .continueInBackground, completed: nil)
                return  cell
            }else{
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.directoryVM.templist.isEmpty{
            return tableView.frame.height
        }else{
            return directoryVM.heightForRow(indexPath.row)
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        directoryVM.moveToProfile(id: self.directoryVM.templist[indexPath.row].id!, viewController: self)
    }
}

extension DirectoryViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        self.directoryVM.templist.removeAll()
        _searchText = searchBar.text!
        self.directoryVM.templist = searchBar.text!.isEmpty ? self.directoryVM.directory : self.directoryVM.directory.filter {
            return ($0.name!.range(of:searchBar.text!,options:.caseInsensitive) != nil || $0.position!.range(of:searchBar.text!,options:.caseInsensitive) != nil)
        }
        self.directoryTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.directoryVM.templist.removeAll()
        self.directoryVM.templist = searchBar.text!.isEmpty ? self.directoryVM.directory : self.directoryVM.directory.filter {
            return ($0.name!.range(of:searchBar.text!,options:.caseInsensitive) != nil || $0.position!.range(of:searchBar.text!,options:.caseInsensitive) != nil)
        }
        self.directoryTableView.reloadData()
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        _searchText = ""
        searchBar.text! = ""
        self.directoryVM.templist = self.directoryVM.directory
        self.directoryTableView.reloadData()
    }
    
}
