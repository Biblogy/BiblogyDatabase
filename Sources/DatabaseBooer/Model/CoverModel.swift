//
//  CoverModel.swift
//  
//
//  Created by Veit Progl on 30.05.22.
//

import Foundation
import SwiftUI

public struct Cover: Equatable, Decodable {
    public init(smallThumbnail: String, thumbnail: String) {
        self.smallThumbnail = smallThumbnail
        self.thumbnail = thumbnail
    }
    
    public let smallThumbnail, thumbnail: String?
}
