//
//  Feed.swift
//  TransitIOSTest
//
//  Created by Adam Rais on 2021-02-12.
//

import Foundation
import MapKit
import SwiftyJSON

class Feed: NSObject, MKAnnotation {
    
    //MARK: - Properties
    let title: String?
    let city: String?
    let countryCode: String?
    let coordinate: CLLocationCoordinate2D 
    
    var subtitle: String? {
        return city
    }
    
    var image: UIImage {
        return #imageLiteral(resourceName: "pin")
    }
    
    //MARK: - IBOutlet
    init(
        title: String?,
        city: String?,
        countryCode: String?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.title = title
        self.city = city
        self.countryCode = countryCode
        self.coordinate = coordinate
        
        super.init()
    }
    
    
    
    class func from(json: JSON) -> Feed? {
        var title: String
        if let unwrappedTitle = json["name"].string {
            title = unwrappedTitle
        } else {
            title = ""
        }
        let locationName = json["location"].string
        let countryCode = json["country_code"].string
        let latitude = json["bounds"]["min_lat"].doubleValue
        let longitude = json["bounds"]["min_lon"].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        return Feed(title: title, city: locationName, countryCode: countryCode, coordinate: coordinate)
        
    }
    
    var markerTintColor: UIColor? {
        switch countryCode {
        case "CA":
            return UIColor(named: "Canada")
        case "US":
            return UIColor(named: "UnitedStates")
        case "FR":
            return UIColor(named: "France")
        case "GB":
            return UIColor(named: "UnitedKingdom")
        case "DE":
            return UIColor(named: "Germany")
        default:
            return UIColor(named: "OtherCountries")
        }
    }
    
}
