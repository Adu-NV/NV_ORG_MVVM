//
//  PrivacyPolicyViewController.swift
//  NV_ORG
//
//  Created by Netventure on 31/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
    var privacyViewModel = PrivacyPolicyViewModel()
    @IBOutlet weak var privacyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        privacyViewModel.skipButtontapped(view: self)
    }
}

extension PrivacyPolicyViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        privacyViewModel.numberofSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        privacyViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrivacyTableViewCell", for: indexPath) as! PrivacyTableViewCell
        return cell
    }
}
