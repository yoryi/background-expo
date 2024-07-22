//
//  Atributes.swift
//  BackgroundTask
//
//  Created by Jorginho Ojeda on 21/07/24.
//

import Foundation
import ActivityKit
import SwiftUI

struct FizlAttributes: ActivityAttributes {
    public typealias FizlStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var startTime: String
        var endTime: String
        var title: String
        var headline: String
        var widgetUrl: String
    }
}
