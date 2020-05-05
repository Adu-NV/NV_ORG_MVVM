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
let directoryVM = DirectoryViewModel()
    @IBOutlet weak var directorySearchBar: UISearchBar!
    @IBOutlet weak var directoryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.directoryTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    func setUI(){
        Webservice.shared.getDirectoryLis { (model, message) in
            if let _ = model{
                debugPrint(model)
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
        if #available(iOS 13.0, *) {
            self.navigationController?.pushViewController(viewC, animated: false)
        }else{
            self.present(viewC, animated: false, completion: nil)
        }
    }
    
}

extension DirectoryViewController :UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        directoryVM.numberofSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        directoryVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DirectoryTableViewCell", for: indexPath) as! DirectoryTableViewCell
        cell.directoryNameLabel.text = self.directoryVM.directory[indexPath.row].name
        cell.positionHeightConstraint.constant = self.directoryVM.directory[indexPath.row].position != "" ? 30 : 0
        cell.directorypositionLabel.text = self.directoryVM.directory[indexPath.row].position == "" ? self.directoryVM.directory[indexPath.row].number : self.directoryVM.directory[indexPath.row].position
        cell.directoryMobileLabel.text = self.directoryVM.directory[indexPath.row].position == "" ? "" : self.directoryVM.directory[indexPath.row].number
        let imageStr = (self.directoryVM.directory[indexPath.row].image)!
        cell.directoryProfileImageView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "profile.png"), options: .continueInBackground, completed: nil)
        return  cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        directoryVM.heightForRow(indexPath.row)
    }
}

extension DirectoryViewController : UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
    }
}
