//
//  ViewController.swift
//  TransitIOSTest
//
//  Created by Adam Rais on 2021-02-11.
//

import UIKit
import MapKit
import SwiftyJSON

class ViewController: UIViewController {
    var feeds = [Feed]()
    
    //MARK: - IBOutlet
    @IBOutlet private var mapView: MKMapView!
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapView.delegate = self
        mapView.register(PinsView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        loadFeeds()
        mapView.addAnnotations(feeds)
    }

    func loadFeeds() {
        let fileName = Bundle.main.path(forResource: "Feeds", ofType: "json")
        let filePath = URL(fileURLWithPath: fileName!)
        var data: Data?

        do {
            data = try Data(contentsOf: filePath, options: Data.ReadingOptions(rawValue: 0))
        } catch let error {
            data = nil
            print("Unexpected error: \(error.localizedDescription).")
        }

        if let jsonData = data {
            let json = try? JSON(data: jsonData)
            if let feedJSONs = json?["feeds"].array {
                for feedJSON in feedJSONs {
                    if let feed = Feed.from(json: feedJSON) {
                        self.feeds.append(feed)
                    }
                }
            }
        }
    }
}

//MARK: - MKMapViewDelegate
extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard (view.annotation as? Feed) != nil else { return }
    
    }
    
}

