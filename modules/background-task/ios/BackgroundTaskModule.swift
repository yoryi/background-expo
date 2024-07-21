import ExpoModulesCore
import SwiftUI
import UserNotifications

#if canImport(ActivityKit)
import ActivityKit
#endif

public class BackgroundTaskModule: Module {
  public func definition() -> ModuleDefinition {
    Name("BackgroundTask")
    Function("showLiveActivity") {
      if #available(iOS 16.1, *) {
        self.requestNotificationAuthorization()
        self.startLiveActivity(title: "Activity Title", details: "Activity Details")
        return "Live Activity started"
      } else {
        return "ActivityKit is not available on this version of iOS"
      }
    }
  }
  
  private func requestNotificationAuthorization() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
      if granted {
        print("Notification permission granted.")
      } else {
        print("Notification permission denied: \(error?.localizedDescription ?? "Unknown error")")
      }
    }
  }

  private func startLiveActivity(title: String, details: String) {
    struct LiveActivityAttributes: ActivityAttributes {
      public typealias LiveActivityData = ContentState

      public struct ContentState: Codable, Hashable {
        var details: String
      }
      var title: String
    }
    
    let attributes = LiveActivityAttributes(title: title)
    let contentState = LiveActivityAttributes.ContentState(details: details)
    
    if #available(iOS 16.1, *) {
      Task {
        do {
          // Request a new Live Activity with push notifications enabled
          let activity = try Activity<LiveActivityAttributes>.request(
            attributes: attributes,
            contentState: contentState,
            pushType: nil // Use .liveActivity to enable push notifications
          )
          
          print("Live Activity started with id: \(activity.id)")
        } catch {
          print("Failed to start Live Activity: \(error)")
        }
      }
    } else {
      print("ActivityKit is not available on this version of iOS")
    }
  }
}

@available(iOS 16.1, *)
struct LiveActivityView: View {
  let title: String
  let details: String

  var body: some View {
    VStack {
      Text(title)
        .font(.headline)
        .padding()
      Text(details)
        .font(.subheadline)
        .padding()
    }
    .background(Color.white)
    .cornerRadius(10)
    .padding()
  }
}
