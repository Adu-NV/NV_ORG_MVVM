//
//  ProfileViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 02/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import Photos

class ProfileViewModel{
//    var
    var profile : Profile?
    public var delegate : ProfileViewControllerDelegateProtocol?
    let main = UIStoryboard.init(name: "Main", bundle: nil)
}

extension ProfileViewModel :ProfileViewModelDelegateProtocol{
    
    func edittapped(view: UIViewController) {
        let edit = main.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        if #available(iOS 13.0, *) {
            view.navigationController?.pushViewController(edit, animated: false)
        }else{
            view.present(edit, animated: false, completion: nil)
        }
    }
    
    var numberofSections : Int {
        return  1
    }
    
    func numberOfRowsInSection(_ section : Int) -> Int{
        return 2
    }
    
    func heightForRow(_ row : Int) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    func setProfileModel(model: UserDetailsResponseModel) {
        if model != nil {
        }
        profile = Profile(model: model.data!)
    }
    
    func getProfile()->Profile{
        return profile!
    }
 
    func imageToBase64(imageToDecode: UIImage! ,profileImg : UIImage?) -> String {
        var imageData =  profileImg!.jpegData(compressionQuality: 0.5)
        var base64String = imageData?.base64EncodedString(options: .init(rawValue: 0))
        base64String = base64String?.replacingOccurrences(of: "+", with: "%2B")
        base64String = base64String?.replacingOccurrences(of: "/", with: "%2F")
        return base64String!
    }
}

struct Profile{
    var coverImage : String?
    var profileImage : String?
    var first_name : String?
    var last_name : String?
    var name:String?
    var occupation:String?
    var memberID:String?
    var mobileNo:String?
    var email:String?
    var position:String?
    var belong:String?
    var dateOfJoin:String?
    
    var address:String?
    var education:String?
    var job:String?
    var career:String?
    var maritial:String?
    var spouse:String?
    var currentLocation:String?
    var country:String?
    var placeInKerala:String?
    var buddyTree:String?
    var datePlanned:String?
    
    init(model : UserDetailResponseData) {
        coverImage = model.user_cover_picture!
        profileImage = model.user_profile_picture!
        
        first_name = model.user_firstname != nil ? model.user_firstname! : ""
        last_name = model.user_lastname != nil ? model.user_lastname! : ""
        name = model.user_name != nil ?  model.user_name! : first_name! + " " + last_name!
        occupation = model.user_designation!
        memberID = "\((model.user_id)!)"
        mobileNo = model.user_mobile!
        email = model.user_email!
        position = model.user_position_society!
        belong = model.user_group!
        dateOfJoin = model.user_date_of_joining!
        
        address = model.user_address!
        education = model.user_education!
        job = model.user_job_experience
        career = model.user_career_profile!
        maritial = model.user_martial_status!
        spouse = model.user_spouse_name!
        currentLocation = model.user_city!
        country = model.user_state!
        placeInKerala = model.user_state!
        buddyTree = model.user_buddy_tree!
        datePlanned = model.user_date_planted!
    }
}


extension ProfileViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func coverImageClicked(view : UIViewController) {
        cameraIcon(view: view)
    }
    func profileImageClicked(view : UIViewController) {
        cameraIcon(view: view)
    }
    func cameraIcon(view: UIViewController){
       
        let actionSheet = UIAlertController(title:"Select Options", message: nil, preferredStyle: .alert)
        let cameraButton = UIAlertAction(title: "Camera", style: .default, handler: {(actonsheet)-> Void in
            
            self.cameraButtonAction(view: view)
        })
        let libraryButton = UIAlertAction(title: "Library", style: .default, handler: {(actonsheet)-> Void in
            self.libraryButtonAction(view: view)
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: {(actonsheet) -> Void in
            //handle cancel
        })
        actionSheet.addAction(cameraButton)
        actionSheet.addAction(libraryButton)
        actionSheet.addAction(cancelButton)
        view.present(actionSheet, animated: true, completion: nil)
    }
    
    func cameraButtonAction(view : UIViewController) {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == AVAuthorizationStatus.authorized {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            view.present(imagePicker, animated: true, completion: nil)
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {(granted: Bool) -> Void in
                DispatchQueue.main.async {
                    if !(AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == AVAuthorizationStatus.authorized) {
                        let alert = UIAlertController(title: "NV_ORG Would Like to Access the Camera", message: "Allow NV_ORG to take pictures?", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
                            DispatchQueue.main.async {
                                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                    if #available(iOS 10.0, *) {
                                        UIApplication.shared.open(settingsURL, options:[:], completionHandler: nil)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                }
                            }
                        }))
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
                            (alertAction) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                        view.present(alert, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    func libraryButtonAction(view : UIViewController) {
        DispatchQueue.main.async {
            let photoLibraryAuthStatus = PHPhotoLibrary.authorizationStatus()
            switch photoLibraryAuthStatus {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({ (newStatus) in
                    if (newStatus == PHAuthorizationStatus.authorized) {
                        DispatchQueue.main.async {
                            self.imagePicker.allowsEditing = true
                            self.imagePicker.sourceType = .photoLibrary
                            view.present(self.imagePicker, animated: true, completion: nil)
                        }
                    }
                })
            case .restricted:
                break
            case .denied:
                DispatchQueue.main.async {
                    if .denied == PHPhotoLibrary.authorizationStatus() {
                        let alert = UIAlertController(title: "NV_ORG Would Like to Access Your Photos", message: "For choosing the photo for your personal profile data update.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
                            DispatchQueue.main.async {
                                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                    if #available(iOS 10.0, *) {
                                        UIApplication.shared.open(settingsURL, options:[:], completionHandler: nil)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                }
                            }
                        }))
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
                            (alertAction) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                        view.present(alert, animated: true, completion: nil)
                    }
                }
            case .authorized:
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = .photoLibrary
                view.present(self.imagePicker, animated: true, completion: nil)
            }
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.editedImage.rawValue)] as? UIImage {
            profileImg = pickedImage
            imageData = profileImg!.jpegData(compressionQuality: 0.5)!
            encoded = imageData!.base64EncodedString(options: .endLineWithCarriageReturn)
            profileImage = pickedImage
        }else if let pickedImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            profileImg = pickedImage
            imageData = profileImg!.jpegData(compressionQuality: 0.5)!
            profileImage = pickedImage
            encoded = imageData!.base64EncodedString(options: .endLineWithCarriageReturn)
         }
        profileimageurl = encoded
        saveProfileData()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage {
            profileImg = pickedImage
            imageData = profileImg!.jpegData(compressionQuality: 0.5)!
            encoded = imageData!.base64EncodedString(options: .endLineWithCarriageReturn)
            profileImage = pickedImage
        }else if let pickedImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            profileImg = pickedImage
            imageData = profileImg!.jpegData(compressionQuality: 0.5)!
            profileImage = pickedImage
            encoded = imageData!.base64EncodedString(options: .endLineWithCarriageReturn)
         }
        profileimageurl = encoded
        saveProfileData()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveProfileData(){
        let str = self.profileVM.imageToBase64(imageToDecode: profileImg!, profileImg: profileImg!)
        if imageType == "Profile"{
            uploadDictionary["user_profile_picture"] = str
        }else{
            uploadDictionary["user_cover_picture"] = str
        }
//        activitiIndicatorView = self.showActivityIndicator(_message: "Please wait...")
        Webservice.shared.profileImageUpload(files: imageType == "Profile" ? "user_profile_picture" : "user_cover_picture", uploadDictionary: uploadDictionary, filename: imageType+".jpeg", mimeType: "image/jpeg", imagedata: imageData!) { (success, error, model) in
            DispatchQueue.main.async {
//                 self.hideActivityIndicator(uiView: self.activitiIndicatorView)
                           if success{
                               self.callWebservice()
                           }else{
                               self.callWebservice()
                           }
            }
            
        }
       
    }
}
