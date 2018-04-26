/*:
 # UIKit Playground
 A Playground to demonstrate adding UI elements to an iOS App
 
 ## Introduction:
 - #### Markup
 You can Toggle the markup in the menu:
 
 `Editor -> Show Rendered Markup / Raw Markup`
 
 I would probably advise setting a shortcut via `Xcode -> Prefernces -> Key Bindings` and setting a shortcut for Show Rendered Markup, something like ⇧⎇⌘M should do the trick
 
 You can also see the result of each line by clicking the small square boxes in the column to the right `->`
 Setting a shortcut for this is a little trickier. See [Apple's custom keyboard shortcut guide for help](https://support.apple.com/kb/PH25377?locale=en_GB)
 
 - #### Live View
 You can see the 'Live View' of the code by showing the assistant editor in the View menu or by pressing ⎇⌘↩
 The Live you will behave as though the app is running and will update as you type.
 - #### Resources
 You can add resources to the project by dragging and dropping files from Finder
 ## Recommended Links
 
 - [A Guided Tour of Swift](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.playground.zip)
 
 */
//------------------------------------------------------------------------------
import UIKit                // This Package is required for UI controls
import AVFoundation         // This Package is for any audio visual tools
import PlaygroundSupport
//------------------------------------------------------------------------------

class MyViewController : UIViewController
{
    //--------------------------------------------------------------------------
//: Change this variable to change the background image. Try burst2.png or burst3.png
    let backgroundImage = "burst3.png"
//: Change This variable to alter the sound that is played. the first item is the file name and the second is the file extension (without the dot)
    let audioSample = ["cowbell-808", "wav"]
    //--------------------------------------------------------------------------
    override func loadView()
    {
        let view = UIView()
        //--------------------------------------------------------------------------
//: Hard Coding Dimensions is a bad idea
//: Try to always use relative positions so that the UI scales well to different devices
        let previewWidth = 376
        let previewHeight = 650
        //--------------------------------------------------------------------------
        let label = UILabel()
        let labelFrame = CGRect(x: 10, y: 30, width: previewWidth, height: 20)
        label.frame = labelFrame
        label.text = "Hello, This slider does not do anything"
        label.textColor = .purple
        //--------------------------------------------------------------------------
        let slider = UISwitch()
        let sliderFrame = CGRect(x: 310, y: 25, width: 0, height: 0)
        slider.frame = sliderFrame
        slider.tintColor = .purple
        slider.onTintColor = .magenta
        //--------------------------------------------------------------------------
        let buttonFrame = CGRect(x: 0, y: 630, width: previewWidth, height: 20)
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
    // Play Audio
    //--------------------------------------------------------------------------
    var audioPlayer:AVAudioPlayer!
    /// Play the sound file: triggered from a UIButton
    ///
    /// - Parameter sender: The control that triggers this function
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
}
//------------------------------------------------------------------------------
//: This is an Extension to UIView. [You can read about extensions here](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html)
//: There is probably a nicer way to do this. Answers on a postcard to matt.hamilton@ed.ac.uk
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
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
