//
//  PatternDetailViewController.swift
//  Insurance
//
//  Created by Marco F.A. Corzani on 25.11.14.
//  Copyright (c) 2014 Alphaweb. All rights reserved.
//

import UIKit

class PatternDetailViewController: UIViewController {

    var pattern : Pattern? = nil
    var tappedImage : UIImage? = nil
    
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        var myColor = UIColor.whiteColor()
        self.backImageView.layer.borderWidth = 5
        self.backImageView.layer.borderColor = myColor.CGColor
        self.frontImageView.layer.borderWidth = 5
        self.frontImageView.layer.borderColor = myColor.CGColor
        
        
        self.navigationItem.title = self.pattern!.name
        self.frontImageView.image = UIImage(data:self.pattern!.frontImage)
        self.backImageView.image = UIImage(data:self.pattern!.backImage)
    
        // Macht die Bilder klickbar! UserInteraction im Storyboard nicht vergessen!
        var frontTappRecognitzer = UITapGestureRecognizer(target: self, action: "frontTapped")
        self.frontImageView.addGestureRecognizer(frontTappRecognitzer)
        
        var backTappRecognitzer = UITapGestureRecognizer(target: self, action: "backTapped")
        self.backImageView.addGestureRecognizer(backTappRecognitzer)
    }
    
    func frontTapped() {
        self.tappedImage = self.frontImageView.image
        self.performSegueWithIdentifier("zoomSegue", sender: self)
    }
    
    func backTapped() {
        self.tappedImage = self.backImageView.image
        self.performSegueWithIdentifier("zoomSegue", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var zoomViewController = segue.destinationViewController as ZoomViewController
        zoomViewController.bild = self.tappedImage!
    }
    }
