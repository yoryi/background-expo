import Foundation
import ExpoModulesCore
import UserNotifications
import ActivityKit


public class BackgroundTaskModule: Module {
    var count = 0
    var timer: Timer?
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid

    public func definition() -> ModuleDefinition {
        Name("BackgroundTask")
        
        Function("startSimulation") { (number: Int) in
            self.startSimulation(number: number)
        }

        Function("requestPermissions") {
            self.requestNotificationPermissions()
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
            let activity = try Activity<LiveActivityAttributes>.request(
              attributes: attributes,
              contentState: contentState,
              pushType: nil
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
  

    private func startSimulation(number: Int) {
        self.endBackgroundTask()
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "BackgroundTask") {
            self.endBackgroundTask()
        }
        
        self.count = 0
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.count < number {
                self.count += 1
                let requestID = self.count
                if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        if let error = error {
                            print("Error: \(error)")
                            return
                        }
                        print("Request ID: \(requestID)")
                    }
                    task.resume()
                }
            } else {
                self.timer?.invalidate()
                self.timer = nil
                self.sendNotification()
                self.endBackgroundTask()
            }
        }
    }

    private func endBackgroundTask() {
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }

    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Tarea Finalizada"
        content.body = "La simulación de carga ha finalizado."
        let request = UNNotificationRequest(identifier: "BackgroundTaskNotification", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    private func requestNotificationPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error al solicitar permisos de notificación: \(error)")
                return
            }
            if granted {
                print("Permisos de notificación concedidos")
            } else {
                print("Permisos de notificación denegados")
            }
        }
    }
}
