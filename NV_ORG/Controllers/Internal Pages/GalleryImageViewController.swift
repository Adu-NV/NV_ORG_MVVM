//
//  GalleryImageViewController.swift
//  NV_ORG
//
//  Created by Netventure on 04/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class GalleryImageViewController: UIViewController {
var galleryId = ""
    
    @IBOutlet weak var galleryImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    func setUI(){
        galleryImageView.sd_setImage(with: URL(string: galleryId), placeholderImage: UIImage(named: "events.png"), options: .continueInBackground, context: nil)
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
       self.dismiss(animated: false, completion: nil)
    }
}
