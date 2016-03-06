//
//  CaptureViewController.swift
//  InitiallyInstagram
//
//  Created by Anisha Gupta on 2/27/16.
//  Copyright © 2016 ani6gup. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
 
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var pictureView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takeAPhoto(sender: AnyObject) {
        let cameraSource = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        // Limit to PhotoLibrary if no camera available
        let sourceType = cameraSource ? UIImagePickerControllerSourceType.Camera : UIImagePickerControllerSourceType.PhotoLibrary
        
        let viewController = UIImagePickerController()
        viewController.delegate = self
        viewController.sourceType = sourceType
        
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    @IBAction func selectAPhoto(sender: UIButton) {
        
        let picker = UIImagePickerController ()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        picker .dismissViewControllerAnimated(true, completion: nil)
        pictureView.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        
        
    }
    
    @IBAction func addPhotoAndCaption(sender: AnyObject)
    {
        
        let currentUser = PFUser.currentUser()
        
        let scaledImage = self.resize( self.pictureView.image!, newSize: CGSizeMake(750, 750))
        let imageData = UIImageJPEGRepresentation(scaledImage, 0)
        let imageFile = PFFile(name:"image.jpg", data:imageData!)
        let picture = PFObject(className: "Picture")
        picture["image"] = imageFile
        
        let post = PFObject(className: "Post")
        post["user"] = currentUser
        post["picture"] = picture
        post["caption"] = self.captionField.text
        post.saveInBackgroundWithBlock
        { (success: Bool, error: NSError?) -> Void in
            if let error = error
            {
                print("Error saving post: \(error.description)")
            } else
            {
                print("Post saved successfully")
                self.tabBarController!.selectedIndex = 0
            }
        }

        captionField.text = ""
        pictureView.image = nil
        
    }


    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
