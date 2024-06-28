//
//  SplashController.swift
//  MPKL-Tourism
//
//  Created by IntecX Developer.
//

import UIKit

class SplashController: UIViewController {

    // Create IBOutlets for the UIImageViews in your storyboard
    @IBOutlet weak var swipeImageView: UIImageView!
    @IBOutlet weak var splashImageViewer: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Call functions to set up image sizes based on the screen
        setupSplashImageSize()
        setupSwipeImageSize()
        
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        self.view.addGestureRecognizer(swipeGesture)
    }

    @objc func handleSwipe(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        // Check if the user has swiped up
        if translation.y < 0 {
            // Perform the segue to OpenMenu
            performSegue(withIdentifier: "OpenMenu", sender: nil)
        }
    }

    func setupSplashImageSize() {
        // Set the splash image content mode to aspect fit, ensuring it scales properly
        splashImageViewer.contentMode = .scaleAspectFit

        // Load the splash image from the asset named "splash"
        if let splashImage = UIImage(named: "splash") {
            // Set the loaded splash image to the splashImageView
            splashImageViewer.image = splashImage

            // Adjust the splash image view's frame to fit the screen size
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            splashImageViewer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        } else {
            // Handle the case where the splash image couldn't be loaded
            print("Error: Unable to load splash image from asset.")
        }
    }
    
    func setupSwipeImageSize() {
        // Set the splash image content mode to aspect fit, ensuring it scales properly
        swipeImageView.contentMode = .scaleAspectFit

        // Load the splash image from the asset named "splash"
        if let swipeImage = UIImage(named: "swipe") {
            // Set the loaded splash image to the splashImageView
            swipeImageView.image = swipeImage
            
            // Adjust the swipe image view's frame to fit at the bottom center of the screen
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height

            // Calculate the width of the swipeImageView based on screen size
            let swipeImageWidth = screenWidth * 0.5 // Adjust the percentage as needed
            let swipeImageHeight =  screenHeight * 0.3

            // Set the frame of the swipeImageView at the bottom center of the screen
            swipeImageView.frame = CGRect(x: (screenWidth - swipeImageWidth) / 2, y: screenHeight - swipeImageHeight, width: swipeImageWidth, height: swipeImageHeight)

        } else {
            // Handle the case where the splash image couldn't be loaded
            print("Error: Unable to load swipe image from asset.")
        }
    }

}
