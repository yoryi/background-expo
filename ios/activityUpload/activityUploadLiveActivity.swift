//
//  activityUploadLiveActivity.swift
//  activityUpload
//
//  Created by Jorginho Ojeda on 21/07/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct activityUploadAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct activityUploadLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: activityUploadAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension activityUploadAttributes {
    fileprivate static var preview: activityUploadAttributes {
        activityUploadAttributes(name: "World")
    }
}

extension activityUploadAttributes.ContentState {
    fileprivate static var smiley: activityUploadAttributes.ContentState {
        activityUploadAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: activityUploadAttributes.ContentState {
         activityUploadAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: activityUploadAttributes.preview) {
   activityUploadLiveActivity()
} contentStates: {
    activityUploadAttributes.ContentState.smiley
    activityUploadAttributes.ContentState.starEyes
}
