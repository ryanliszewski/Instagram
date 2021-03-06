//
//  PostViewController.swift
//  Instagram
//
//  Created by Ryan Liszewski on 3/5/17.
//  Copyright © 2017 Smiley. All rights reserved.
//

import UIKit
import MBProgressHUD

class PostViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var captionTextField: UITextField!

    @IBOutlet weak var postImageView: UIImageView!
    
    var editedImage: UIImage!
    
    var vc = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        captionTextField.delegate = self
        vc.delegate = self
        vc.allowsEditing = true
        
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        postImageView.image = editedImage
        
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func onUploadPictureTapped(_ sender: Any) {
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
    }
 
    @IBAction func onTakePictureTapped(_ sender: Any) {
        
        vc.sourceType = UIImagePickerControllerSourceType.camera
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onPostButtonTapped(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
        Post.postUserImage(image: editedImage, withCaption: captionTextField.text) { (success: Bool, error: Error? ) in
            if(success){
                print("posted a picture")
                MBProgressHUD.hide(for: self.view, animated: true)
                //let homeViewController = HomeViewController()
                //self.present(homeViewController, animated: true, completion: nil)
            }else {
                print(error?.localizedDescription)
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
