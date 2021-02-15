//
//  ArtworkViews.swift
//  TransitIOSTest
//
//  Created by Adam Rais on 2021-02-11.
//

import Foundation
import MapKit

class PinsView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let feed = newValue as? Feed else {
                return
            }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            markerTintColor = feed.markerTintColor
            glyphImage = feed.image
        }
    }
}
