//
//  DirectoryViewController.swift
//  NV_ORG
//
//  Created by Netventure on 28/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

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
