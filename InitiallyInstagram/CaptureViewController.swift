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
        let imageData = UIImageJPEGRepresentation(pictureView.image!, 0)
        let imageFile = PFFile(name:"image.jpg", data:imageData!)
        let picture = PFObject(className: "Picture")
        picture["image"] = imageFile
        
        let post = PFObject(className: "Post")
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
                self.tabBarController!.selectedIndex = 0;
            }
        }

        captionField.text = ""
        pictureView.image = nil
        
    }


    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
