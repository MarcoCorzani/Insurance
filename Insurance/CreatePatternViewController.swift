//
//  CreatePatternViewController.swift
//  Insurance
//
//  Created by Marco F.A. Corzani on 25.11.14.
//  Copyright (c) 2014 Alphaweb. All rights reserved.
//

import UIKit
import CoreData



class CreatePatternViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  { // Für die Kamera

    var frontPicture = true  // Zur Unterscheidung welches Bild geklickt wurde
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        // Macht die Bilder klickbar! UserInteraction im Storyboard nicht vergessen!
        var frontTappRecognitzer = UITapGestureRecognizer(target: self, action: "frontTapped")
        self.frontImageView.addGestureRecognizer(frontTappRecognitzer)
        
        var backTappRecognitzer = UITapGestureRecognizer(target: self, action: "backTapped")
        self.backImageView.addGestureRecognizer(backTappRecognitzer)
 }
    
    func frontTapped() {
        self.frontPicture = true
        lauchCamera()
    }
    
    func backTapped() {
        self.frontPicture = false
        lauchCamera()
    }
    
    
    func lauchCamera() {
    //checken ob Kamera vorhanden, dann launchen!
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            var cameraViewController = UIImagePickerController()
            cameraViewController.sourceType = UIImagePickerControllerSourceType.Camera
            cameraViewController.delegate = self
            self.presentViewController(cameraViewController, animated: true, completion: nil)
        
        }
    }
    
    
    // Image am richtigen Ort anzeigen (Front oder Back)
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        if self.frontPicture == true {
            self.frontImageView.image = image
        } else {
            self.backImageView.image = image
            }
        picker.dismissViewControllerAnimated(true, completion: nil) //Der ViewController muss explizit verlassen werden
    }

    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    @IBAction func saveTapped(sender: AnyObject) {
    
    
        
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        var pattern = NSEntityDescription.insertNewObjectForEntityForName("Pattern", inManagedObjectContext: context) as Pattern
        pattern.name = self.nameTextField.text
        pattern.frontImage = UIImageJPEGRepresentation(self.frontImageView.image,1)
        pattern.backImage = UIImageJPEGRepresentation(self.backImageView.image,1)
        context.save(nil)
        self.dismissViewControllerAnimated(true, completion: nil) //Der ViewController muss explizit verlassen werden
    }


}
