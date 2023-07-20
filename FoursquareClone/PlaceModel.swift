//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by eyüp yaşar demir on 1.06.2023.
//

import Foundation
import UIKit

class placeModel {
    static let sharedInstance = placeModel()
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    
    
    private init(){}
}
