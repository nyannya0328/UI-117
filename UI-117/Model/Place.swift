//
//  Place.swift
//  UI-117
//
//  Created by にゃんにゃん丸 on 2021/02/03.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    
    var id = UUID().uuidString
    var placemark : CLPlacemark
}


