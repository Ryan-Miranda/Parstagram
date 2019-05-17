//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Ryan M on 5/12/19.
//  Copyright © 2019 Ryan M. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPost(_ sender: Any) {
        let post = PFObject(className: "Posts")
        post["caption"] = captionField.text!
        post["author"] = PFUser.current()!
        
        let imageData = postImageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        //image column gets url
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Post saved!")
            }
            else {
                self.displayPostError(error: error!)
            }
        }
    }
    
    @IBAction func onCameraTap(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFit: size)
        
        postImageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    //Post error alert controller
    func displayPostError(error: Error) {
        let title = "Login Error"
        let message = "Oops! Something went wrong while posting your creation: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
}
