//
//  ViewController.swift
//  MPKL-Tourism
//
//  Created by IntecX Developer.
//

import UIKit
import WebKit
import CoreLocation

class NoLongPressWKWebView: WKWebView {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // Disable the default touch and hold gestures
        return false
    }
}

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, CLLocationManagerDelegate {

    var webView: NoLongPressWKWebView!
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Allow loading HTTP URLs
        var infoDict = Bundle.main.infoDictionary
        infoDict?["App Transport Security Settings"] = ["Allow Arbitrary Loads": true]

        // Create NoLongPressWKWebView
        webView = NoLongPressWKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.uiDelegate = self
        webView.navigationDelegate = self

        // Add NoLongPressWKWebView to the view hierarchy
        view.addSubview(webView)

        // Set constraints to make the NoLongPressWKWebView fill the entire screen
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        // Location manager setup
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        // Request location authorization
        locationManager?.requestWhenInUseAuthorization()

        // Load the web content
        let urlString = "your url"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)

            // Inject JavaScript to handle touch events
            let disableTouchScript = """
                document.addEventListener('touchstart', function(event) {
                    event.preventDefault();
                });
            """
            webView.evaluateJavaScript(disableTouchScript, completionHandler: nil)
        }
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            // If permission denied or restricted, show an alert
            let alertController = UIAlertController(title: "Location Access Denied",
                                                    message: "Please enable location access to use this feature.",
                                                    preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(settingsAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}



