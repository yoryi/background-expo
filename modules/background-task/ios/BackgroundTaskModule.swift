import ExpoModulesCore

public class BackgroundTaskModule: Module {
  public func definition() -> ModuleDefinition {
    Name("BackgroundTask")

    Function("hello") {
      return "Hello world! 👋"
    }

  }
}
