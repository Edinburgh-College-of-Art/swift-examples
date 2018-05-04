//
//  ViewController.swift
//  UIBasics
//
//  Created by mhamilt7 on 26/04/2018.
//  Copyright © 2018 mhamilt7. All rights reserved.
//

import UIKit
import AVFoundation         // This Package is for any audio visual tools

class ViewController: UIViewController
{
    //--------------------------------------------------------------------------
    // Class Methods
    //--------------------------------------------------------------------------
    override func loadView()
    {
        let view = UIView()
        //--------------------------------------------------------------------------
        //: Hard Coding Dimensions is a bad idea
        //: Try to always use relative positions so that the UI scales well to different devices
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        //--------------------------------------------------------------------------
        let label = UILabel()
        let labelFrame = CGRect(x: 10, y: screenHeight/14, width: screenWidth, height: 20)
        label.frame = labelFrame
        label.text = "Hello, This slider does not do anything"
        label.textColor = .purple
        //--------------------------------------------------------------------------
        let slider = UISwitch()
        let sliderFrame = CGRect(x: screenWidth/2-20, y: screenHeight/8, width: 0, height: 0)
        slider.frame = sliderFrame
        slider.tintColor = .purple
        slider.onTintColor = .magenta
        //--------------------------------------------------------------------------
        let buttonFrame = CGRect(x: 0, y: screenHeight-40, width: screenWidth, height: 20)
        let button = UIButton()
        button.frame = buttonFrame
        button.backgroundColor = .clear
        button.setTitleColor(.purple, for: .normal)
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 40)
        button.setTitle("▶️", for: .normal)
        button.setTitle("⏹", for: .highlighted)
        //: This line attaches the UI Button to the function PlaySound defined below.
        //: Since PlaySound is marked with `@IBAction` it is expecting some UI element to trigger it
        button.addTarget(self,
                         action: #selector(self.PlaySound(sender:)),
                         for: .touchUpInside)
        //--------------------------------------------------------------------------
        view.addSubview(button)
        view.addSubview(slider)
        view.addSubview(label)
        self.view = view
    }
    
    //--------------------------------------------------------------------------
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addBackground(imageName: backgroundImage)
    }

    //--------------------------------------------------------------------------
    
    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //--------------------------------------------------------------------------
    // Class Callbacks
    //--------------------------------------------------------------------------
    @IBAction func PlaySound(sender: UIButton)
    {
        let audioFilePath = Bundle.main.path(forResource: audioSample[0], ofType: audioSample[1])
        
        if audioFilePath != nil
        {
            let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
            do
            {
                try audioPlayer = AVAudioPlayer(contentsOf: audioFileUrl)
                audioPlayer.play()
            }
            catch
            {
                print("Failed to Load Audio")
            }
        }
        else
        {
            print("audio file is not found")
        }
    }
    //--------------------------------------------------------------------------
    // Class Members
    //--------------------------------------------------------------------------
    let backgroundImage = "burst3.png"
    var audioPlayer:AVAudioPlayer!
    let audioSample = ["cowbell-808", "wav"]
}


extension UIView
{
    func addBackground(imageName: String, contentMode: UIViewContentMode = .scaleToFill)
    {
        // setup the UIImageView
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundImageView)
        sendSubview(toBack: backgroundImageView)
        
        // adding NSLayoutConstraints
        let leadingConstraint = NSLayoutConstraint(item: backgroundImageView,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImageView,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .trailing,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImageView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImageView,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: 0.0)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
}
