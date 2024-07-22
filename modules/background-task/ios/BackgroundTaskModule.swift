import ExpoModulesCore
import ActivityKit

public class BackgroundTaskModule: Module {
    public func definition() -> ModuleDefinition {
        Name("BackgroundTask")
        
        Function("areActivitiesEnabled") { () -> Bool in
            print("areActivitiesEnabled()")
            
            if #available(iOS 16.2, *) {
                return ActivityAuthorizationInfo().areActivitiesEnabled
            } else {
                return false
            }
        }
        
        Function("startActivity") {
            print("startActivity()")

            let startTime =  "init"
            let endTime =  "end"
            
            if #available(iOS 16.2, *) {
                let attributes = FizlAttributes()
                let contentState = FizlAttributes.ContentState(startTime: startTime, endTime: endTime, title: "title", headline: "headline", widgetUrl: "widgetUrl")
                
                let activityContent = ActivityContent(state: contentState, staleDate: nil)
                
                do {
                    let activity = try Activity.request(attributes: attributes, content: activityContent)
                    print("Requested a Live Activity \(String(describing: activity.id)).")
                    return true
                } catch (let error) {
                    print("Error requesting Live Activity \(error.localizedDescription).")
                    return false
                }
            } else {
                print("iOS version is lower than 16.2. Live Activity is not available.")
                return false
            }
        }

        Function("endActivity") {
            print("endActivity()")
            
            if #available(iOS 16.2, *) {
                let contentState = FizlAttributes.ContentState(startTime: "start", endTime: "end", title: "title", headline: "headline", widgetUrl: "widgetUrl")
                let finalContent = ActivityContent(state: contentState, staleDate: nil)
                
                Task {
                    for activity in Activity<FizlAttributes>.activities {
                        await activity.end(finalContent, dismissalPolicy: .immediate)
                        print("Ending the Live Activity: \(activity.id)")
                    }
                }
            }
        }
    }
}
